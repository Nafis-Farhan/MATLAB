%ode45 solver
[t,x] = ode113(@(t,x) model(t,x,.42),[0 .5],[0; 0]);

%ploting
figure;
ax(1) = subplot(2,1,1);
hold on
title('Solution of model with ODE45');
xlabel ('t');
ylabel ('x');
ax(2) = subplot(2,1,2);
hold on
xlabel ('t');
ylabel ('y');
n=length(t);
plot(ax(1),t,x(:,1),'color','blue','marker','.')
plot(ax(2),t,x(:,2),'color','blue','marker','.')
fs=length(t);
sound(x(:,1),fs)