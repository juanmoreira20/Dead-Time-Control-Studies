clear; clc; close all;
%% Concept:
% Using V = X'PX
% as it does not depend on systems delay, it works for fast varing delays
% LMI taken from Emilia Fridman(2014) page 65, eq 3.33

%% Example taken from Emilia Fridman(2014)
% beta is our uncertainty in our delayed system and q is auxiliar variable
syms beta
beta = 0.899;
A = [-2 0; 0 -0.9];
A1 = beta*[-1 0; -1 -1];
[~,n] = size(A);
P = sdpvar(n,n);
Q = sdpvar(n,n);
q = 0.9;

%LMI formulation
a11 =  A'*P + P*A + q*P;
a12 = P*A1;
a21 = a12';
a22 = -q*P;

LMI = [a11, a12;
       a21, a22];
LMI = [LMI <=0, P >=0, Q >= 0];

optimize(LMI,[]);

checkset(LMI)