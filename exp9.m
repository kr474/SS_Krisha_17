clc;
clear;
close all;
% Example sequence: x[n] = (0.5)^n u[n]
% Z-transform: X(z) = z/(z - 0.5), ROC: |z| > 0.5
syms z;
X = z/(z - 0.5);
disp('Z-transform X(z) = ');
pretty(X);
disp('ROC: |z| > 0.5');
theta = linspace(0,2*pi,400);
plot(cos(theta),sin(theta),'b--','LineWidth',1.2);
hold on;
plot(0.5,0,'rx','MarkerSize',10,'LineWidth',2);
plot(0,0,'ko');
axis equal; grid on;
xlabel('Real'); ylabel('Imaginary');
title('Pole and Unit Circle (ROC is outside radius 0.5)');
legend('Unit circle','Pole at z = 0.5','Origin');
