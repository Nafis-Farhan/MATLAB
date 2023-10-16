function dydt = model(t,x,k1)

%parameter
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
%p  = 1996;
%k1 = .42;

%ode function
dydt = [x(2);(1/m)*(-(k1+k2*x(1)^2)*x(1)+f0 -(b1+b2*x(2)^2)*x(2)-c*x(1)^2*x(2)+a*(1978+(55/sqrt(2*pi))*exp(-.5*((t-.25)/.4)^2))*((a1-a2)+2*tau*x(2))/(a1+x(1)+tau*x(2)))];