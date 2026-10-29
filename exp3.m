clc;
clear;
close all;

% Sine and cosine signals
t = 0:0.0001:1;
f = 5;
x1 = cos(2*pi*f*t);
x2 = sin(2*pi*f*t);
figure;
plot(t, x1, 'r', t, x2, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Cosine and Sine Waves');
grid on;
legend('Cosine', 'Sine');

% Sinc Function
t1 = -5:0.001:5;
x1 = sin(pi*t1)./(pi*t1);
x1(t1 == 0) = 1;
figure;
plot(t1, x1, 'b', 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Sinc Function');
grid on;
legend('sinc function');

% Triangular function
t2 = -2:0.01:2*pi;
x2 = abs(2*(t2/pi - floor(t2/pi + 0.5)));
figure;
plot(t2, x2);
xlabel('Time');
ylabel('Amplitude');
title('Triangular signal');
grid on;
legend('Triangular signal');

% Exponential signal
t3 = 0:0.001:1;
x3 = exp(-0.5*t3);
figure;
plot(t3, x3);
xlabel('Time');
ylabel('Amplitude');
title('Exponential signal');
grid on;
legend('Exponential signal');

% Rectangular pulse waveform
t4 = -1:0.001:1;
x4 = double(abs(t4) <= 0.5);
figure;
plot(t4, x4);
xlabel('Time');
ylabel('Amplitude');
title('Rectangular pulse signal');
grid on;
axis([-1 1 -0.2 1.2]);
legend('Rectangular pulse signal');
