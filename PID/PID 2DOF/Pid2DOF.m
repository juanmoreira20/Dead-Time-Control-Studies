close all; clc; clear;
s = tf('s');
% add independent reference filter in PID formulation such:
% U(s) = Kc((b*R(s)-Y(s))+(E(s)/(ti*s))+(Td*s)*(c*R(s)-Y(s)))*(1+Tf*s)e-1;
%C(s) = (Kc/Ti)*(1+Ti*s+Ti*Td*s*s)/(s*(1+s*Tf)); F(s) =
%+(1+b*Ti*s+c*Ti*Td*s*s)/(1+Ti*s+Ti*Td*s*s)