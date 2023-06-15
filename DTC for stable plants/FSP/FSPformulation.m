clc; close all; clear;
s = tf('s');
% For FSP, we have the same formulation of SP with a filter on the
% predicted error, meaning that we have:
% dFSP = abs(1+C*Gn)/abs(C*Gn*Fr), meaning that:
% dFSP = dSP/abs(Fr)
% if q(t) = 0, the nominal performance of the system is not altered
% Y/Q = Gn*exp(-L*s)*(1 - exp(-L*s)*(Fr*C*Gn)/(1+C*Gn))
% Meaning that FSP has a slower response compared to the SP
%% Controller procedure:
% Compute C and F for the desired closed loop response for nominal plant
% Estimate your uncertainties and compute the filter Fr in order to obtain
% robust stability or performance. 
