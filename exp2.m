clc;
close all;
clear all;

n=-10:1:10;
x1=1*(n==0);
subplot(2,3,1);
stem(n,x1); 
xlabel("Samples");
ylabel("Amplitude");
title("Unit Impluse Signal");

x2=1*(n>=0);
subplot(2,3,2);
stem(n,x2); 
xlabel("Samples");
ylabel("Amplitude");
title("Unit Step Signal");

x3=n.*(n>=0);
subplot(2,3,3);
stem(n,x3); 
xlabel("Samples");
ylabel("Amplitude");
title("Unit Ramp Signal");

x4=(n.^2/2).*(n>=0);
subplot(2,3,4);
stem(n,x4); 
xlabel("Samples");
ylabel("Amplitude");
title("Unit Parabolic Signal");

x5=2*exp(n).*(n>=0);
subplot(2,3,5);
stem(n,x5); 
xlabel("Samples");
ylabel("Amplitude");
title("Unit Exponential Signal");

x6=1*(n>=5);
subplot(2,3,6);
stem(n,x6);
xlabel("Samples");
ylabel("Amplitude");
title("Delayed Unit Step Signal");