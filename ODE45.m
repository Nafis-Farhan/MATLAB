%ode45 solver
[t,x] = ode113(@(t,x) model(t,x,.42),[0 .5],[0; 0]);

%ploting
figure;
ax(1) = subplot(3,1,1);
hold on
title('Solution of model with ODE45');
xlabel ('t');
ylabel ('x');
ax(2) = subplot(3,1,2);
hold on
xlabel ('t');
ylabel ('y');
ax(3) = subplot(3,1,3);
hold on
title("Complex Magnitude of fft Spectrum")
xlabel("f (Hz)")
ylabel("|fft(X)|")
n=length(t);
fs = n/.5;
plot(ax(1),t,x(:,1),'color','blue','marker','.');
plot(ax(2),t,x(:,2),'color','blue','marker','.');
plot(ax(3),t,abs(fft(x(:,1))),'color','blue','marker','.');
fs=length(t);
sound(x(:,1),fs)