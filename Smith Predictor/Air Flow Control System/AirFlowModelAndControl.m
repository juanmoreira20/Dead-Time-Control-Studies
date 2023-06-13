clc; close all; clear;
s = tf('s');
%The airflow model is a non-linear model that is linearized to be used
%in the extent of 0 < V < 5, saturating our control law:
%Our approximate linear model have 30% estimation error in dead time
Gn = 1/(1+1.7*s);
Pn = Gn;
Ln = 8.2;
Pn.OutputDelay = Ln;
P = 1.02*Pn;
% using To = 1.7*Ld, and Ld = 0.3*Ln:
Ld = 0.3*Ln;
To = 1.7*Ld;
T = 1.7;
Ti = T;
T1 = T;
Kp = 1;
Kc = Ti/(Kp*To);
C_sp = Kc*(1+(1/(s*Ti)));
F = (1+s*To)/(1+s*T1);

%defining simulation parameters:
Tinit = 0;
Tsim  = 100;
Tdist = 60;
Ampdist = 0.5;

sim = sim('SairFlowSmithPredictor.slx');

figure
subplot(2,1,1)
plot(sim.y, 'r', 'linewidth', 2)       
hold on
plot(sim.ref, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) sp','Reference', 'location', 'best')
subplot(2,1,2)
plot(sim.u, 'b', 'linewidth', 1)
hold on
plot(sim.ref, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) sp','Reference', 'location', 'best') 


