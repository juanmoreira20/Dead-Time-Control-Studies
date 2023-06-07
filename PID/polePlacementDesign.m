close all; clc; clear;
s = tf('s');
%IMC can be described as Cimc = Gc/(1-(Gc*Pm))
%Y = Cimc*P/(1+Cimc*P)
%usando um filtro passa baixa e um Pm = Pe-1 aproximado temos: Gc = Fpb*Pm
%Cimc = (1+0.5*L*s)*T*(1+s*T)/((Tf+L)*Kp*s*T*(1+(0.5*Tf*L/(Tf+L)))
%Para aproximaçao Pm = Kp*(1-s*L/2)/((1+T*s)*(1+s*L/2))
P = 1/(1+1.5*s);
G = P;
L = 0.5;
P.OutputDelay = L;
%constantes e ganhos
Kp = 1;
T = 1.5;
Ti = T;
Td = 0.5*L;
%Tf = 0.6;%parametro de sintonia do controlador
To = 0.3;
Kx = 2*T/((L+4*To)*Kp);
alpha = 4*To^2/((L+4*To)*L);
C = Kx*(1+T*s)*(1+0.5*L*s)/(T*s*(1+0.5*alpha*L*s));
Pm = Kp*(1-s*L*0.5)/((1+s*T)*(1+0.5*s*L));
%Cimc = T*(1+s*T)*(1+0.5*s*L)/((Tf+L)*Kp*s*T*(1+(0.5*Tf*L*s/(Tf+L))));
Y = C*Pm/(1+Pm*C);
H = P*Y/(1+Y*P);
step(Y,10)