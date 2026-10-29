%Even and Odd Signals
clc;
clear all;
close all;
% To determine even and odd component
x1=[1,1,-1,2,-2,3];
xe=(x1+x1(end:-1:1))/2; % x(n)+x(-n)/2
xo=(x1-x1(end:-1:1))/2; % x(n)-x(-n)/2
subplot(1,2,1);
stem(xe);
subplot(1,2,2);
stem(xo);