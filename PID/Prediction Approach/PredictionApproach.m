close all; clc; clear;
s = tf('s');
%To = T/(K1*Kp)
%Gn = planta sem atraso
%C = controle aplicado
%Pn = planta nominal com atraso = Kp*(e^(-L*s))/(1+T*s)
%Ce = C/(1+C*(Gn-Pn))
%substituindo os valores para uma planta de primeira ordem:
%Ce = K1(1+T*s)/(T*s+K1*Kp*(1-e^(-L*s)))
%Aproximando o controle para atraso = (1-s*L/2)/(1+s*L/2)
%Ce = Kc*(1+Ti*s)(1+Td*s)/((Ti*s)*(1+alpha*Td*s))
%alpha = 1/(1+(L/To))
%Kc = T/((L+To)*Kp)
%% Do preditor de smith temos:
%Exemplo: Tanque aquecido
P = 1/(1+1.5*s);
L = 0.5;
P.OutputDelay = L;
%constantes e ganhos
Kp = 1;
K1 = 3; %parametro de sintonia
T = 1.5;
%%Aplicando o controle PID equivalente ao preditor de smith temos:
Ti = T;
Td = 0.5*L;
To = T/(K1*Kp);
alpha = 1/(1+(L/To));
Kc = T/((L+To)*Kp);
%lei de controle
C = Kc*(1+Ti*s)*(1+Td*s)/((Ti*s)*(1+alpha*Td*s));
%% Simulation

% parameters
Tsim = 20;

sim = sim('SpredictionApproach.slx');


figure
plot(sim.y,'b', 'linewidth', 2)
grid on
axis tight
xlabel('Time, t')
legend('Output, y(t)', 'location', 'best')

figure
subplot(2,1,1)
plot(sim.ref, 'r', 'linewidth', 2)
hold on
plot(sim.y, 'b', 'linewidth', 1)
grid on
axis tight
legend('Output, r(t)','Output, y(t)', 'location', 'best')
subplot(2,1,2)
plot(sim.u, 'b', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t)', 'location', 'best')
