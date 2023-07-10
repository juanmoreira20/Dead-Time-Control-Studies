clear; clc; close all;
%% Concept:
% Using V = X'PX + integral(X'QX)_t-tal(t) -> t
% dtal(t)/dt = d <= 1 (slow varing delays)
% LMI taken from Emilia Fridman(2014) page 64, eq 3.31

%% Example taken from Emilia Fridman(2014)
% beta is our uncertainty in our delayed system and d = dtal(t)/dt
syms beta
beta = 0.5;
A = [-2 0; 0 -0.9];
A1 = beta*[-1 0; -1 -1];
d = 0.5;
[~,n] = size(A);
P = sdpvar(n,n);
Q = sdpvar(n,n);

%LMI formulation
a11 =  A'*P + P*A + Q;
a12 = -P*A1;
a21 = a12';
a22 = -(1-d)*Q;

LMI = [a11, a12;
       a21, a22];
LMI = [LMI <=0, P >=0, Q >= 0];

optimize(LMI,[]);

checkset(LMI)