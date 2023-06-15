clc; clear; close all;
s = tf('s');
%% For SP fast model we have a new Gm with the same poles as Pn but with a
% new zero that cancels the poles of the disturbance rejection transfer
% function to achieve new poles for a faster response
% as the poles of Gm are the same as Pn, we have:
% Gm - Pn = (Nm - Np*exp(-L*s))/Dp = 0 for all sj = poles;
%% Example:
% Pn = exp(-L*s)/(1+s*T), sj = 0  and sj = -1/T, thus:
% Nm = T0 +T1*s, so, for s = 0, T0 - 1 = 0 => T0 = 1;
% For s = -1/T, 1 -T1*s/T -exp(L/T) = 0 => T1 = T*(1-exp(L/T));
% For our robustness indice, we have dP = abs((1+j*w*To)^2/(1+j*w*Ti))
%% Simulation Example:
Gn = 1/(1+s);
L = 0.5;
T = 1;
P = Gn;
P.OutputDelay = L;
Pn = P;
C_sp = 10*(1+s)/s;
Gm = (1 - (1-exp(L/T))*s)/(1+s);
C_fastsp = 3*(1+0.5*s)/s;
Tsim = 20;
Tdist = 10;
Ampdist = -0.1;
F = 1;
Tinit = 0;

sim1 = sim('SfastModel.slx');

sim2 = sim("S2DOFSP.slx");

figure
subplot(2,1,1)
plot(sim1.y, 'r', 'linewidth', 2)       
hold on
plot(sim1.ref, '--k', 'linewidth', 1)
hold on
plot(sim2.y, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) sp','Reference', 'location', 'best')
subplot(2,1,2)
plot(sim1.u, 'b', 'linewidth', 1)
hold on
plot(sim1.ref, '--k', 'linewidth', 1)
hold on
plot(sim2.u, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) sp','Reference', 'location', 'best') 
