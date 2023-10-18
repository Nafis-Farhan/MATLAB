function [t,x] = solve(k1)

[t,x] = ode45(@(time,x_pos) model(time,x_pos,k1),[0 .5],[0; 0]);
N = length(t);

dt= .5/N;

for i=1:N-1
    t_old = t(i+1);
    t(i+1) = t(i)+dt;
    x_old = x(i+1,:);
    x(i+1,1) = x(i,1)+((t(i+1)-t(i))*(x_old(1)-x(i,1))/(t_old-t(i)));
    x(i+1,2) = x(i,2)+((t(i+1)-t(i))*(x_old(2)-x(i,2))/(t_old-t(i)));
end

plot(t,x(:,1))

%sound(x(:,1),1/dt)