clear; clc; close all;
%% LMI for constant delay:
A = [0 1; -1 -2];
A1 = [0, 0; -1 1];
[~,n] = size(A);
P = sdpvar(n,n);
R = sdpvar(n,n);
S = sdpvar(n,n);
h = 100;
%LMI formulation
a11 = A'*P +P*A + S - R;
a12 = P*A1 + R;
a13 = h*A'*R;
a21 = a12';
a22 = -S-R;
a23 = h*A1'*R;
a31 = a13';
a32 = a23';
a33 = -R;
LMI = [a11, a12, a13;
       a21, a22, a23;
       a31, a32, a33];
LMI = [LMI <= 0; P>=0; S>=0; R>=0];
options = sdpsettings('solver','mosek');
optimize(LMI,h,options)
C = checkset(LMI)