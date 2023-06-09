clc; close all; clear;
s = tf('s');
%% General tuning strategies:
% First step consists in tuning C for the highest bandwidth for the nominal
% disturbance response maintaing the robustnesse condition
% Second step: Tune F to improve closed-loop set point response
% C is defined with one or two integrador in order to cope with step or
% ramp disturbances or set point changes.
Gn = -12/((1+60*s)*(1+30*s));
P = Gn;
Ln = 330;
P.OutputDelay = Ln;
Pn = P;
% Modeling error:
W = logspace(-3,2,300);
dL = 30;
delP = exp(-dL*s)*s/s -1;
% deltaP = abs(freqresp(1/delP,W));
% deltaP = squeeze(deltaP(1,1,:));
for i = 1:300
    w = W(i);
    deltaP(i) = abs(exp(-j*dL*w)-1);
    em(i) = 1./deltaP(i);
    em(i) = mag2db(em(i));
    Mfreq_1(i) = 1/abs(1+22*j*w);
    Mfreq_1(i) = mag2db(Mfreq_1(i));
    Mfreq_2(i) = 1/abs(1+32*j*w);
    Mfreq_2(i) = mag2db(Mfreq_2(i));
end   

% Tm = 32;
% M = 1/(1+s*Tm);
% Mfreq = abs(freqresp(M,W));
% Mfreq = squeeze(Mfreq(1,1,:));

figure
semilogx(W, em, '--k', 'linewidth', 2)
hold on
semilogx(W, Mfreq_1', 'b', 'linewidth', 1.5)
hold on
semilogx(W, Mfreq_2', 'r', 'linewidth', 1.5)
grid on
axis tight
xlabel('Frequency, rad/s')
ylabel('Magnitude')
legend('Uncertainty, dP','Robustness index 22','Robustness index 32', 'location', 'best')

Kc = -0.73;
z1 = -0.02;
z2 = -0.027;
p = -0.2;
C_sp = Kc*((s-z1)*(s-z2))/(s*(s-p));
F = 1;
% 1 está para 5, logo, 1 está para 0.2
Tsim  = 6000;
Tinit = 100;
Tdist = 4000;
Ampdist = -2;
Tchange = 2000;
Ampchange = 0.02;

sim = sim('SsmithPredictor.slx');

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



    
