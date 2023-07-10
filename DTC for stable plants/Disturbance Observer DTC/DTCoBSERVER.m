clc; close all; clear;
s = tf('s');
% For a disturbance based model Y(s) = P(s)(U(s)+Q(s)), we know that 
% Q(s) = P-1(s)Y(s) - U(s), thus, we have a equation with a exp(-Ls) term,
% knowing that we have to get rid of it, we can multiply the equation to
% form exp(-Ls)Q(s) = Gn-1(s)Y(s) - exp(-Ls)U(s), being that we can estimate
% Q in the form Qhat(s) = V(s)[(Gn-1(s)Y(s)-exp(Ls)U(s))], allowing a
% feedfoward action to be conceived, such we can create
%% 2DOF formulation:
% Define F, Gn, L, P, V
% Feq = F*Gn/(V);
% Ceqnum = V
% Ceqden = Gn*(1-V*exp(-Ls)
%% Robustness analysis
% for our model, we have 1+ (V(s)/Gn(s))*P(s)*delP(s) =
% = 1 + V(s)*exp(-L*s)*delP(s) = 0, thus, delP(s) = - 1/(V(s)*exp(-L*s)),
% meaning that dp = abs(delP(s)) = 1/abs(V(jw)) and V(s) must be tuned to
% compromise between robustness and disturbance rejection