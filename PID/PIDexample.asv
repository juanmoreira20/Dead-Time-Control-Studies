close all; clc; clear;
s = tf('s');
% %PID série com filtro passa baixa
% Ceq = Kc*(1+Ti*s/(Ti*s))*(Td*s+1/(alpha*Td*s+1));

% %PID paralelo com filtro passa baixa
% Ceq = Kp + (Ki/s) + Kd*s/(alpha*Kd*s+1);

%Exemplo: Tanque aquecido com controle PI
P = 1/(1+1.5*s);
L = 0.5;
P.OutputDelay = L;
Ti = 1.5;
Kc = 2.5;
% Td = 0.18;
% alpha = 0.1;
C = Kc*((1+Ti*s)/(Ti*s));
% P_Pi = feedback(P*C,1);
% C_Pi = feedback(P,C);
P_Pi = (C*P)/(1+C*P);
C_Pi = P/(1+P*C);
figure
step(P_Pi,10)
hold on
step(C_Pi)

%Exemplo: Tanque aquecido com controle PID com filtro passa baixa
P = 1/(1+1.5*s);
L = 0.5;
P.OutputDelay = L;
Ti = 1.5;
Kc = 2.5;
Td = 0.18;
%Td = 0.5;
alpha = 0.1;
C = Kc*((1+Ti*s)/(Ti*s))*(Td*s+1/(alpha*Td*s+1));
% P_Pi = feedback(P*C,1);
% C_Pi = feedback(P,C);
P_Pi = (C*P)/(1+C*P);
C_Pi = P/(1+P*C);
figure
step(P_Pi,10)
hold on
step(C_Pi)


