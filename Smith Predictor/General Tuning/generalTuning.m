clc; close all; clear;
s = tf('s');
%% General tuning strategies:
% First step consists in tuning C for the highest bandwidth for the nominal
% disturbance response maintaing the robustnesse condition
% Second step: Tune F to improve closed-loop set point response
% C is defined with one or two integrador in order to cope with step or
% ramp disturbances or set point changes.
Gn = -12/((1+60*s)*(1+120*s));
P = Gn;
Ln = 330;
P.OutputDelay = Ln;
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
    Mfreq(i) = 1/abs(1+22*j*w);
    Mfreq(i) = mag2db(Mfreq(i));
end   

% Tm = 32;
% M = 1/(1+s*Tm);
% Mfreq = abs(freqresp(M,W));
% Mfreq = squeeze(Mfreq(1,1,:));

figure
semilogx(W, em, '--k', 'linewidth', 2)
hold on
semilogx(W, Mfreq, 'b', 'linewidth', 1.5)
grid on
axis tight
xlabel('Frequency, rad/s')
ylabel('Magnitude')
legend('Uncertainty, dP','Robustness index', 'location', 'best')


    
