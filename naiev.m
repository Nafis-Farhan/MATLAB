function  [x_new,t] = naiev(k1)
[t,x] = ode45(@(time,x_pos) model(time,x_pos,k1),[0 .5],[0; 0]);
n = length(t);
N = 100000;
t_new = linspace(0,.5,N);
x_new = zeros(N,1);
j=2;
x_new(1)=x(1,1);
for i=1:N-1
    if  j < n && t_new(i)>t(j) 
        j=j+1;
    end
    x_new(i+1) = x_new(i) + ((x(j,1)-x(j-1,1))/(t(j)-t(j-1)))*(t_new(i+1)-t_new(i));
        
end
ax(1) = subplot(2,1,1);
%hold on
plot(ax(1),t,x(:,1),'color','blue','marker','.')
title('Solution of model with ODE45');
xlabel ('t');
ylabel ('x');
ylim([-0.04 0.01]);
ax(2) = subplot(2,1,2);
%hold on
plot(ax(2),2*(-50000:50000-1),abs(fftshift(fft(x_new))),'color','blue','marker','.')
xlabel ('f');
ylabel ('fft(x)');
xlim([0 3500]);
ylim([0 50]);
drawnow
end

