close all; clc; clear;
s = tf('s');
% add independent reference filter in PID formulation such:
% U(s) = Kc((b*R(s)-Y(s))+(E(s)/(ti*s))+(Td*s)*(c*R(s)-Y(s)))*(1+Tf*s)e-1;
%C(s) = (Kc/Ti)*(1+Ti*s+Ti*Td*s*s)/(s*(1+s*Tf));
% F(s) = (1+b*Ti*s+c*Ti*Td*s*s)/(1+Ti*s+Ti*Td*s*s) 
P = (((1+s)^3)*(5*s+1))^(-1);
P.OutputDelay = 10;
Pn = (1+6*s)^(-1);
Pn.OutputDelay = 12;
Kp = 1;
L = 12;
T = 6;
alpha = 0.5;
Ti = T;
Td = 0.5*L;
To = ((alpha^2+alpha)^(1/2) +alpha)*L/2;
Kc = 2*T/((4*To+L)*Kp);
b = 0.8;
c = 1;
Tf = 0.5*alpha*L;
C = (Kc/Ti)*(1+Ti*s+Ti*Td*s*s)/(s*(1+s*Tf));
F = (1+b*Ti*s+c*Ti*Td*s*s)/(1+Ti*s+Ti*Td*s*s);
%simple filter
% F = (1+beta*Tr/s)/(1+s*Tr); Tr = L/2;  0.2<beta<0.6

%% Simulation

% parameters
Tinit = 5;
Tsim = 150;
Tdist = 75;
AmpDist = -0.8;

sim_02 = sim('Spid2DOF.slx');
T = 6;
alpha = 0.3;
Ti = T;
Td = 0.5*L;
To = ((alpha^2+alpha)^(1/2) +alpha)*L/2;
Kc = 2*T/((4*To+L)*Kp);
b = 0.8;
c = 1;
Tf = 0.5*alpha*L;
C = (Kc/Ti)*(1+Ti*s+Ti*Td*s*s)/(s*(1+s*Tf));
F = (1+b*Ti*s+c*Ti*Td*s*s)/(1+Ti*s+Ti*Td*s*s);

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


