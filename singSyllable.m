function [t,song] = singSyllable(rho2)
Fs = 22050; %sampling
t = 0:1/Fs:0.24;
%[t1, y] = ode15s('birdBrain',t,[0.01 0.01 0.01],[],rho2);
kt=4*power(10,8)*cos(4*3.14*t+ rho2) + 9 * power(10,8);
pt=1005+ 1000*cos(4*3.14*t);
[m ,z1] = ode15s('syrinx',t,[0.01 0.01],[],t,pt,kt);
song=z1(:,1);