
clc;
clear all;
close all;

T = 2*pi;
W = (2*pi)/T;
N = 20;

% Square wave
t = linspace(0,4*pi,100);
sq_wave = zeros(1,length(t));

for n = 1:2:N
    sq_wave = sq_wave + (4/(n*pi))*sin(n*W*t);
end

% Sawtooth wave
saw_wave = zeros(1,length(t));

for n = 1:N
    saw_wave = saw_wave + (2/(n*pi))*(-1)^(n+1)*sin(n*W*t);
end

% Triangular wave
tri_wave = zeros(1,length(t));

for n = 1:2:N
    tri_wave = tri_wave + (8/(n^2*pi^2))*(-1)^((n-1)/2)*sin(n*W*t);
end

% Plot all waveforms
figure;
plot(t,sq_wave,'r','LineWidth',1.5);
hold on;
plot(t,saw_wave,'b','LineWidth',1.5);
plot(t,tri_wave,'g','LineWidth',1.5);

grid on;
xlabel('Time (t)');
ylabel('Amplitude');
title('Fourier Series Waveforms');
legend('Square Wave','Sawtooth Wave','Triangular Wave');
hold off;
