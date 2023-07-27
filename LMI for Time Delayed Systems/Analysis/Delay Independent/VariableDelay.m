clear; clc; close all;
%% LMI for variable delay
A = [-2 0; 0 -0.9];
A1 = [-1 0; -1 -1];
[~,n] = size(A);
P = sdpvar(n,n);
R = sdpvar(n,n);
S = sdpvar(n,n);
Q = sdpvar(n,n);
h = 4.47; %delay
d = 0; % delay variation
% LMI formulation
a11 = A'*P +P*A + S + Q - R;
a12 = 0*A;
a13 = P*A1 + R;
a14 = h*A'*R;
a21 = a12';
a22 = -S-R;
a23 = R;
a24 = 0*A;
a31 = a13';
a32 = a23';
a33 = -(1-d)*Q-2*R;
a34 = h*A1'*R;
a41 = a14';
a42 = a24';
a43 = a34';
a44 = -R;
LMI = [a11, a12, a13, a14;
       a21, a22, a23, a24        ;
       a31, a32, a33, a34;
       a41, a42, a43, a44];
LMI = [LMI <= 0; P>=0; S>=0; R>=0, Q>=0];
options = sdpsettings('solver','mosek');
optimize(LMI,h,options)
C = checkset(LMI)