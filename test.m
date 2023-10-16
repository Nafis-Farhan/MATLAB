%%Model parameters
a  = 2*10^(-4);
m  = 0.4;
b1 = 4.44*10^(-5);
c  = 1.6*10^(-2);
f0 = 0.0399;
tau= 5*10^(-6);
a1 = 0.1;
a2 = 0.11;
k2 = 400;
b2 = 4*10^(-11);
%p  = 1900;

%%Time parameters
dt = 0.00001;
N = 5000;
%%Set-up figure and axes
figure;
ax(1) = subplot(4,1,1);
hold on
xlabel ('k1');
ylabel ('x');
ax(2) = subplot(4,1,2);
hold on
xlabel ('k1');
ylabel ('y');
ax(3) = subplot(4,1,3);
hold on
xlabel ('p');
ylabel ('x');
ax(4) = subplot(4,1,4);
hold on
xlabel ('p');
ylabel ('y');

%%Main loop
for p= 1852:50:2085
    for k1=0.16:0.05:0.52
        x = zeros(N,1);
        y = zeros(N,1);
        t = zeros(N,1);
        x(1) = 0.107;
        y(1) = 0;
        t(1) = 0;
        for i=1:N
            t(i+1) = t(i) + dt;
            x(i+1) = y(i)*dt;
            y(i+1) = (dt/m)*((-k1+k2*x(i)^2)*x(i)+f0 -(b1-b2*y(i)^2)*y(i)-c*x(i)^2*y(i)+a*p*((a1-a2)+2*tau*y(i))/(a1+x(i)+tau*y(i))) ;
        end
        plot(ax(1),k1,x,'color','blue','marker','.');
        plot(ax(2),k1,y,'color','blue','marker','.');
        plot(ax(3),p,x,'color','blue','marker','.');
        plot(ax(4),p,y,'color','blue','marker','.');
    end
end