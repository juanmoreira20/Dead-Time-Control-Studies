close all; clc; clear;
s = tf('s');

%% for integrative processes, we use a gain Ko in feedback with the disturbance and the process, and project it using root locus
% such as, for our FOPDT model, Ko = 0.5/(Kv*L)
%% Next we use our pole cancelation stable formulation with a filtered
% formulation, being that our initial formulation does not allow complex
% zeros. C = Kc(1+(1/(s*Ti))+Td*s)/(1+Tf*s)
%Ti = 1.5*L; Td = 2*L/3; Tf = gamma*0.5*L; Kc = 1.5/(Kv*(4*to*L))
% To = 0.5*L*[gamma + sqrt(gamma^2+gamma)]
%% At least, we need to use a reference filter do attenuate the overshoot.
% Our filter is similar to 2DOF one being: F = (1+(b*Tif*s)+(c*Tif*Tdf*s*s))/(1+(Tif*s)+(Tif*Tdf*s*s))
% Kcf = Kc+Ko; Tff =Tf; Tif = (1+(Ko/Kc))*Ti; Tdf = Kc*Tf+Ko*Tf/(Kc+ko);
%% Note: In lag dominant process, being that T >> L, we can approximate P to be integrative
%% application
P = 2/((1+s)*(1+0.5*s)*s*(1+0.1*s));
P.OutputDelay = 5;
% de Pn temos:
Kv = 2; 
L = 6.7;
Pn = Kv/s;
Pn.OutputDelay = L;
gamma = 0.2;
b = 1;
c = 1;
Ko = 0.5/(Kv*L);
fgamma = gamma + sqrt(gamma^2+gamma);
To = 0.5*L*(fgamma);
Kc = (1/(2*Kv*L))*(1+(3*(4*fgamma+1)^(-1)));
Ti = 2*L*(fgamma+1);
Td = (L/8)*((4+gamma*(4*fgamma+1))*(fgamma+1)^(-1));
Tf = gamma*L/2;

%formulação 1: com Fo, Co e Ko:
C = Kc*(1+(1/(Ti*s))+Td*s)*(1/(1+s*Tf));
F = (1+(b*Ti*s)+(c*Ti*Td*s*s))/(1+(Ti*s)+(Ti*Td*s*s));
Tinit = 0;
Tsim = 150;
Tdist = 75;
AmpDist = -0.05;

sim_02 = sim('idealIntegrative2DOF.slx');
b = 0.43;
c = 0.5;
F = (1+(b*Ti*s)+(c*Ti*Td*s*s))/(1+(Ti*s)+(Ti*Td*s*s));
sim_03 = sim('idealIntegrative2DOF.slx');

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


