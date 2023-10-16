%%Model parameters
a  = 2*10^(-4);
m  = 0.4*10^(-9);
b1 = 4.44*10^(-5);
c  = 1.6*10^(-2);
f0 = 0.0399;
tau= 5*10^(-6);
a1 = 0.1;
a2 = 0.11;
k2 = 400;
b2 = 4*10^(-11);
h  = 0.000001;
p  = 1996;
k1 = .33;

t_i = 0;
t_f = .5;


x0= .107;
y0= 0;


F_tx=@(t,y,x)(y);
F_txy=@(t,y,x)((1/m)*(-(k1+k2*x^2)*x+f0 -(b1+b2*y^2)*y-c*x^2*y+a*(1978+(55/sqrt(2*pi))*exp(-.5*((t-.25)/.4)^2))*((a1-a2)+2*tau*y)/(a1+x+tau*y)));

t=t_i:h:t_f;
x=zeros(1,length(t));
x(1)=x0;
y=zeros(1,length(t));
y(1)=y0;

 for i=1:(length(t)-1)
    k1 = F_tx(t(i),x(i),y(i));
    L1 = F_txy(t(i),x(i),y(i));
    k2 = F_tx((t(i)+h/2),(x(i)+0.5*h*k1),(y(i)+0.5*h*L1));
    L2 = F_txy((t(i)+h/2),(x(i)+0.5*h*k1),(y(i)+0.5*h*L1));
    k3 = F_tx((t(i)+h/2),(x(i)+0.5*h*k2),(y(i)+0.5*h*L2));
    L3 = F_txy(t(i)+h/2,(x(i)+0.5*h*k2),(y(i)+0.5*h*L2));
    k4 = F_tx((t(i)+h),(x(i)+k3*h),(y(i)+L3*h));
    L4 = F_txy((t(i)+h),(x(i)+k3*h),(y(i)+L3*h));
    
    x(i+1) = x(i) + (1/6)*(k1+2*k2+2*k3+k4)*h; 
    y(i+1) = y(i) + (1/6)*(L1+2*L2+2*L3+L4)*h;
    
    
 end
% plot(y,y)
figure;
ax(1) = subplot(2,1,1);
hold on
xlabel ('t');
ylabel ('x');
ax(2) = subplot(2,1,2);
hold on
xlabel ('t');
ylabel ('y');

plot(ax(1),t,x,'color','blue','marker','.');
plot(ax(2),t,y,'color','blue','marker','.');