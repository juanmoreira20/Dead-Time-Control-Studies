clc; close all; clear;
s = tf('s');
%% Third case: Dead Time estimation error
% Processes nominal model
Tn = 1.5;
Kn = 1;
Ln = 10.5;
Gn = Kn/(1+Tn*s);
Pn = Gn;
Pn.OutputDelay = Ln;
Kc = 1;
Ti = Tn;
C_sp = Kc*(1+Ti*s)/(Ti*s); 
%% Controller formulation:
Tsim  = 100;
Tinit = 10;
Tdist = 60;
Ampdist = -0.1;
% Processes error
P = 1/((1+s)*(1+0.5*s)*(1+0.25*s)*(1+0.125*s));
L = 12;
P.OutputDelay = L;
sim1 = sim('SsmithPredictor.slx');


%%
L = 10;
P.OutputDelay = L;
sim2 = sim('SsmithPredictor.slx');
%%
L = 8;
P.OutputDelay = L;
sim3 = sim('SsmithPredictor.slx');

%%


figure
subplot(2,1,1)
plot(sim1.y, 'r', 'linewidth', 2)       
hold on
plot(sim2.y, '-.k', 'linewidth', 1)
hold on
plot(sim3.y, '-.k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) L = 12','Output, y(t) L = 10','Output y(t) L = 8', 'location', 'best')
subplot(2,1,2)
plot(sim1.u, 'r', 'linewidth', 2)       
hold on
plot(sim2.u, '-.k', 'linewidth', 1)
hold on
plot(sim3.u, '-.k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) L = 12','Output, u(t) L = 10','Output u(t) L = 8', 'location', 'best') 