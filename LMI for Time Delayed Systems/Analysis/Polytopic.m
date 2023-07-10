clear; clc; close all;
%% Concept:
% Using V = X'PX + integral(X'QX)_t-tal(t) -> t
% dtal(t)/dt = d <= 1 (slow varing delays)
% LMI taken from Emilia Fridman(2014) page 64, eq 3.31

%% Example taken from Emilia Fridman(2014)
% beta is our uncertainty in our delayed system and d = dtal(t)/dt
syms beta 
beta = 0.4;
A = [-2 0; 0 -0.9];
A1 = beta*[-1 0; -1 -1];
%polytopic uncertainties modeling
E = [1, 1;
     1, 1];
E1 = [1, 0;
      0, -1];
H = 0.1*eye(2);
d = 0.5;
[~,n] = size(A);
P = sdpvar(n,n);
Q = sdpvar(n,n);
eta = sdpvar(1,1);


%LMI formulation
a11 =  A'*P + P*A + Q;
a12 = P*A1;
a13 = P*H;
a14 = eta*E';
a21 = a12';
a22 = -(1-d)*Q;
a23 = 0*eye(2);
a24 = eta*E1';
a31 = a13';
a32 = a23';
a33 = -eta*eye(2);
a34 = 0*eye(2); 
a41 = a14';
a42 = a24';
a43 = a34';
a44 = -eta*eye(2);

LMI = [a11, a12, a13, a14;
       a21, a22, a23, a24;
       a31, a32, a33, a34;
       a41, a42, a43, a44];
LMI = [LMI <=0, P >=0, Q >= 0, eta>=0];

optimize(LMI,[]);

checkset(LMI)