close all; clc; clear;
s = tf('s');
% add independent reference filter in PID formulation such:
% U(s) = Kc((b*R(s)-Y(s))+(E(s)/(ti*s))+(Td*s)*(c*R(s)-Y(s)))*(1+Tf*s)e-1;
%C(s) = (Kc/Ti)*(1+Ti*s+Ti*Td*s*s)/(s*(1+s*Tf));
% F(s) = (1+b*Ti*s+c*Ti*Td*s*s)/(1+Ti*s+Ti*Td*s*s) 
% Standard PID tuning for dead time with padeé approximation: 
% Tf = 0.5*alpha*L;
% Kc = Kc*(T+0.5*L)/T;
% Ti = T+0.5*L;
% Td = 0.5*T*L/(T+0.5*L);
P = 1/(((1+s)^3)*(5*s+1));
P.OutputDelay = 10;
Pn = (1+6*s)^(-1);
Pn.OutputDelay = 12;
Kp = 1;
L = 12;
T = 6;
alpha = 0.5;
Ti = T;
Td = 0.5*L;
To = ((alpha^2+alpha)^(1/2) +alpha)*L*0.5;
Kc = 2*T/((4*To+L)*Kp);
b = 1;
c = 1;
Tf = 0.5*alpha*L;
Kc = Kc*(T+0.5*L)/T;
Ti = T+0.5*L;
Td = 0.5*T*L/(T+0.5*L);
% num = conv([Ti 1], [Td 1]);
% den = conv([Ti 0],[alpha*Td 1]);
% C = tf(Kc*num,den);
C = Kc*(1+Ti*s+Ti*Td*s^2)/(Ti*s*(1+s*Tf));
F = (1+(b*Ti*s)+(c*Ti*Td*s*s))/(1+(Ti*s)+(Ti*Td*s*s));
% simple filter
% F = (1+beta*Tr/s)/(1+s*Tr); Tr = L/2;  0.2<beta<0.6

%% Simulation

% parameters
Tinit = 0;
Tsim = 200;
Tdist = 100;
AmpDist = -0.8;

Ts = 1;
wz = logspace(-1,log10(pi/Ts),1000);
dP = abs(freqresp((P - Pn),wz))./abs(freqresp(Pn,wz));
dP = squeeze(dP(1,1,:));

Ir = abs(freqresp((C*P + 1),wz))./abs(freqresp(C*P,wz));
Ir = squeeze(Ir(1,1,:));

figure
semilogx(wz, dP, '--k', 'linewidth', 2)
hold on
semilogx(wz, Ir, 'b', 'linewidth', 1.5)
grid on
axis tight
xlabel('Frequency, rad/s')
ylabel('Magnitude')
legend('Uncertainty, dP','Robustness index', 'location', 'best')

sim_02 = sim('Spid2DOF.slx');
alpha = 0.3;
Ti = T;
Td = 0.5*L;
To = ((alpha^2+alpha)^(1/2) +alpha)*L*0.5;
Kc = 2*T/((4*To+L)*Kp);
b = 1;
c = 1;
Tf = 0.5*alpha*L;
Kc = Kc*(T+0.5*L)/T;
Ti = T+0.5*L;
Td = 0.5*T*L/(T+0.5*L);
num = conv([Ti 1], [Td 1]);
den = conv([Ti 0],[alpha*Td 1]);
Cx = tf(Kc*num,den);
C = Kc*(1+Ti*s+Ti*Td*s^2)/(Ti*s*(1+s*Tf));
F = (1+(b*Ti*s)+(c*Ti*Td*s*s))/(1+(Ti*s)+(Ti*Td*s*s));

Ts = 1;
wz = logspace(-1,log10(pi/Ts),1000);
dP = abs(freqresp((P - Pn),wz))./abs(freqresp(Pn,wz));
dP = squeeze(dP(1,1,:));

Ir = abs(freqresp((C*P + 1),wz))./abs(freqresp(C*P,wz));
Ir = squeeze(Ir(1,1,:));

figure
semilogx(wz, dP, '--k', 'linewidth', 2)
hold on
semilogx(wz, Ir, 'b', 'linewidth', 1.5)
grid on
axis tight
xlabel('Frequency, rad/s')
ylabel('Magnitude')
legend('Uncertainty, dP','Robustness index', 'location', 'best')

sim_03 = sim('Spid2DOF.slx');


figure
subplot(2,1,1)
plot(sim_02.y, 'r', 'linewidth', 2)       
hold on
plot(sim_03.y, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) 0.2','Output, y(t) 0.3', 'location', 'best')
subplot(2,1,2)
plot(sim_02.u, 'b', 'linewidth', 1)
hold on
plot(sim_03.u, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) 0.2','Output u(t) 0.3', 'location', 'best') 


