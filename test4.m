%ode45 solver
[t,x] = ode45(@(t,x) model(t,x,.36),[0 .5],[0; 0]);
plot(x(:,1),x(:,2))
xlabel('x');
ylabel('x dot');
%plot(t,(1978+(55/sqrt(2*pi))*exp(-.5*((t.*t-t*.5+.25^2)/.16))))