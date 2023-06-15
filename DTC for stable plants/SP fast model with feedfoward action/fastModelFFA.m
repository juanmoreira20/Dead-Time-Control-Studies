clc; close all; clear;
s = tf('s');

%%Simulation:
Gm = 1/((1+5*s)*(1+2*s));
Pn = Gm;
L = 12;
Pn.OutputDelay = L;
Pnq1 = 0.5*Pn;
Pnq2 = 0.5/(1+2*s);
Pnq2.OutputDelay = 5;
C_ffsp = 12*(s+0.4)*(s+0.45)/(s*(s+5));
Cff = 0.5;
Cff2 = 0.5*(1+5*s)/(1+0.5*s);
P = Pn;
F = 1;
