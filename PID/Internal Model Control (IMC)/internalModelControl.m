close all; clc; clear;
s = tf('s');
%IMC can be described as Cimc = Gc/(1-(Gc*Pm))
%Y = Cimc*P/(1+Cimc*P)
%usando um filtro passa baixa e um Pm = Pe-1 aproximado temos: Gc = Fpb*Pm
%Cimc = (1+0.5*L*s)*T*(1+s*T)/((Tf+L)*Kp*s*T*(1+(0.5*Tf*L/(Tf+L)))
%Para aproximaçao Pm = Kp*(1-s*L/2)/((1+T*s)*(1+s*L/2))
t = 0:0.1:20;
P = 1/(1+1.5*s);
L = 0.5;
P.OutputDelay = L;
%constantes e ganhos
Kp = 1;
T = 1.5;
Ti = T;
Td = 0.5*L;
Tf = 0.6;%parametro de sintonia do controlador
% Kx = 2*T/((L+4*To)*Kp);
% alpha = 4*To^2/((L+4*To)*L);
% C = Kx*(1+T*s)*(1+0.5*L*s)
Cimc = T*(1+s*T)*(1+0.5*s*L)/((Tf+L)*Kp*s*T*(1+(0.5*Tf*L*s/(Tf+L))));
Y = Cimc*P/(1+P*Cimc);
figure
[y,t1] = step(Y,10);
plot(t1,y)
%Series PID design:
Kc = T/(Kp*(L+Tf));
alpha = (Tf/(L+Tf));
C = Kc*((1+Ti*s)/(Ti*s))*(Td*s+1/(alpha*Td*s+1));
H = C*P/(1+C*P);
figure
[h,t2] = step(H,10);
plot(t2,h)


