%% Simulation Example:
Gn = 1/(1+s);
Ln = 2.1
L = 2;
T = 1;
P = Gn;
P.OutputDelay = Ln;
Pn = P;
C_sp = 0.172*(1+0.9*s)/(0.9*s);
Gm = (1 + (1-exp(L/T))*s)/(1+s);
C_fastsp = 3*(1+0.5*s)/s;
Tsim = 12;
Tdist = 2;
Ampdist = -0.1;
F = 1;
Tinit = 0;

sim1 = sim('SfastModel.slx');

sim2 = sim("S2DOFSP.slx");

figure
subplot(2,1,1)
plot(sim1.y, 'r', 'linewidth', 2)       
hold on
plot(sim1.ref, '--k', 'linewidth', 1)
hold on
plot(sim2.y, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, y(t) sp','Reference', 'location', 'best')
subplot(2,1,2)
plot(sim1.u, 'b', 'linewidth', 1)
hold on
plot(sim1.ref, '--k', 'linewidth', 1)
hold on
plot(sim2.u, '--k', 'linewidth', 1)
grid on
axis tight
legend('Output, u(t) sp','Reference', 'location', 'best') 