function  solve(k1)

[t,x] = ode45(@(time,x_pos) model(time,x_pos,k1),[0 .5],[0; 0]);
n = length(t);
dt=1;
for i = 1:n-1
    if t(i+1)-t(i)<dt
        dt = t(i+1)-t(i);
    end
end
N = fix(.5/dt);
t_new = linespace(0,.5,N);
x_new = zeros(N,1);
j=2;
x_new(1)=x(0,1);
for i=1:N-1
    if t_new(i)>t(j) && j < n
        j=j+i;
        continue;
    end
    x_new(i+1) = x_new(i) + m*
        
end

%plot(t,x(:,1))

%sound(x(:,1),1/dt)