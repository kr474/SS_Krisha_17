%Energy Signal
clc;
clear all;
close all;
% Compute the energy of a given signal
x=[1,-1,2,-2,3];
E=sum(x.^2); % E=sigma|x|^2
disp("Energy of a given signal is");
disp(E);
