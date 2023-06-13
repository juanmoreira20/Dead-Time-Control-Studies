%%Tuning rules:
% Set Gn as the fast model, such as Gn = Kp/(1+T*s)
% C = Kc(1+(1/(s*Ti))), such as Ti = T and To is the closed loop time
% constant and Kc = Ti/(Kp*To) and F = (1+s*To)/(1+s*T1), such that
% Y(s)/R(s) = exp(-L*s)/(1+T*s)
% Y(s)/Q(s) = Kp*exp(-L*s)/(1+T*s)*[1 - (exp(-L*s)/(1+To*s))]
% with that, we have dP = abs(1+j*w*To)
%% Predictive PI:
% If the process is time-dominant, than To = Ti = T1 = T, Kc = 1/Kp
%% Robust tuning: when only dealing with dead time estimation errors we have
% dP > abs(1-exp(-dL*j*w)) such as for max(dL) = Ld, we have:
% abs(1-exp(Ld*j*w)) = abs(1+j*w*To) which means that min(To) = 0.69*Ld
% Rule of thumb: same as before, T1 e [T,To]