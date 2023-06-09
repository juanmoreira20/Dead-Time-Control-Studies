clc; close all; clear;
s = tf('s');
%% Smith predictor properties:
%% 1) Dead time compensation:
% 1+ C* Gn = 0, thus, dead time is compensated as e(t) = 0 with our
% prediction yp(t) = y_hat(t+Ln)
%% 2) As mentioned before, smith predictor have a predictor  signal yp(t)
% which is designed to anticipate system output changes in set-point.
%% 3) Ideal Dynamic Compensator: if our plant is equal to the nominal form, than
% we have a perfect dynamic compenstion.

%%simulation:
Gn = 1/(1+1.5*s);
P = Gn;
L = 2;
P.OutputDelay = L;
Tsim  = 35;
Tinit = 5;
Tdist = 20;
Ampdist = 0.5;
%%smith predictor
Ti = 1.5;
% 1 + C*G = 0, thus 1+ Kc/(1.5*s) = 0, and, for s = -1/0.3, Kc = 5
Kc = 5;
C_sp = Kc*(1+Ti*s)/(Ti*s);
sim_sp = sim('SsmithPredictor.slx');
%% PID for comparison:
% 2*L > T, thus:
T = 1.5;
Kp = 1;
Kc = 0.35*(L+2*T)/(Kp*L);
Ti = T+L/2;
Td = L*T/(L+2*T);
Tf = 0.15*L;
b = 0.8;
c = 1;
C = Kc*(1+Ti*s+Ti*Td*s^2)/(Ti*s*(1+s*Tf));
F = (1+(b*Ti*s)+(c*Ti*Td*s*s))/(1+(Ti*s)+(Ti*Td*s*s));

sim_pid = sim('Spid2DOF.slx');

figure
subplot(2,1,1)
plot(sim_sp.y, '--k', 'linewidth', 2)       
hold on
plot(sim_pid.y, 'r', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) sp','Output, y(t) pid', 'location', 'best')
subplot(2,1,2)
plot(sim_sp.u, '--k', 'linewidth', 1)
hold on
plot(sim_pid.u, 'b', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) sp','Output u(t) pid', 'location', 'best') 

