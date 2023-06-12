clc; close all; clear;
s = tf('s');
%For Robustness, we can say that P = Pn[1 + delP], thus, our characteristic
%equation can be described as 1+C[Gn + deltaP], meaning that if we
%stabilize Gn, than our equation is stabilized, such:
% dP = abs(1+C*G)/abs(C*G) and uncertanty < dP
%This shows that SP handles uncertanties better than PID
%% Second case: Gain error
% Processes model
P = 1/((1+s)*(1+0.5*s)*(1+0.25*s)*(1+0.125*s));
%P.OutputDelay = L;
Ln = 10.5;
L = 10;
P.OutputDelay = L;
Tn = 1.5;

Kn1 = 1.2;
Gn1 = Kn1/(1+Tn*s);
Pn1 = Gn1;
Pn1.OutputDelay = Ln;

Kn2 = 1;
Gn2 = Kn2/(1+Tn*s);
Pn2 = Gn2;
Pn2.OutputDelay = Ln;

Kn3 = 0.8;
Gn3 = Kn3/(1+Tn*s);
Pn3 = Gn3;
Pn3.OutputDelay = Ln;

%% Controller formulation:
Tsim  = 100;
Tinit = 10;
Tdist = 60;
Ampdist = -0.1;

Kc = 1;
Ti = Tn;
C_sp = Kc*(1+Ti*s)/(Ti*s); 
Gn = Gn1;
sim1 = sim('SsmithPredictor.slx');

Kc = 1;
Ti = Tn;
C_sp = Kc*(1+Ti*s)/(Ti*s); 
Gn = Gn2;
sim2 = sim('SsmithPredictor.slx');

Kc = 1;
Ti = Tn;
C_sp = Kc*(1+Ti*s)/(Ti*s); 
Gn = Gn3;
sim3 = sim('SsmithPredictor.slx');

figure
subplot(2,1,1)
plot(sim1.y, 'r', 'linewidth', 2)       
hold on
plot(sim2.y, '-.k', 'linewidth', 1)
hold on
plot(sim3.y, '-.k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) Kn = 1.2','Output, y(t) Kn = 1','Output y(t) Kn = 0.8', 'location', 'best')
subplot(2,1,2)
plot(sim1.u, 'r', 'linewidth', 2)       
hold on
plot(sim2.u, '-.k', 'linewidth', 1)
hold on
plot(sim3.u, '-.k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) Kn = 1.2','Output, u(t) Kn = 1','Output u(t) Kn = 0.8', 'location', 'best') 