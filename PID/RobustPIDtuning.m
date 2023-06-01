clear; close all; clc;
s = tf('s');
%Processo da forma
%P = (Kp/(1+T*s))*exp(-L*s) tal que L >= 2T
%C = Kc*(1+T*s)*(1+0.5*L*s)/(T*s*(1+0.5*alpha*L*s))
% max OS = 10%, sem osicilaçao
% projete Kc e alpha tal que os polos sao s = -1/To no modelo aproximado
%To = ((alpha*alpha+alpha)e(1/2) + alpha)*0.5*L

P = 1/((1+s)*(1+0.5*s)*(1+0.25*s)*(1+0.125*s));
L = 9.7;
P.OutputDelay = L;
alpha = 0.1;
To = ((alpha*alpha+alpha)^(1/2) + alpha)*0.5*L;
Ti = 1.5;
Td = 5;
Kc = 0.166;
% C = Kc*(1+T*s)*(1+0.5*s)/((T*s)*(alpha*L*s+1));
C = Kc*((1+Ti*s)/(Ti*s))*((Td*s+1)/(alpha*Td*s+1));
H = C*P/(1+C*P);
figure
step(H)

alpha = 0.3;
To = ((alpha*alpha+alpha)^(1/2) + alpha)*0.5*L;
Ti = 1.5;
Td = 5;
Kc = 0.1086;
% C = Kc*(1+T*s)*(1+0.5*s)/((T*s)*(alpha*L*s+1));
C = Kc*((1+Ti*s)/(Ti*s))*((Td*s+1)/(alpha*Td*s+1));
H = C*P/(1+C*P);
figure
step(H)

alpha = 0.5;
To = ((alpha*alpha+alpha)^(1/2) + alpha)*0.5*L;
Pn = 1/((1+s)*(1+0.5*s)*(1+0.25*s)*(1+0.125*s));
Pn.OutputDelay = 10;
Ti = 1.5;
Td = 5;
Kc = 0.0829;
% C = Kc*(1+T*s)*(1+0.5*s)/((T*s)*(alpha*L*s+1));
C = Kc*((1+Ti*s)/(Ti*s))*((Td*s+1)/(alpha*Td*s+1));
H = C*P/(1+C*P);
figure
step(H)


