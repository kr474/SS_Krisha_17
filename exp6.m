
clc;
clear;
close all;
clc;
clear;
close all;

x = input('Enter the sequence of x: ');
h = input('Enter the sequence of h: ');

N1 = length(x);
N2 = length(h);

L = N1 + N2 - 1;

y = zeros(1, L);

for i = 1:L
    for j = 1:N1
        if (i-j+1 > 0) && (i-j+1 <= N2)
            y(i) = y(i) + x(j) * h(i-j+1);
        end
    end
end

disp('The length of the convolution is:');
disp(L);

disp('The convolution result y:');
disp(y);

figure;
stem(0:L-1, y, 'filled');
grid on;
xlabel('n');
ylabel('y(n)');
title('Linear Convolution of x(n) and h(n)');


x = input("Enter the sequence of x: ");
h = input("Enter the sequence of h: ");

n1 = input("Enter the index of x: ");
n2 = input("Enter the index of h: ");

N1 = length(x);
N2 = length(h);

L = N1 + N2 - 1;

y = zeros(1, L);

for i = 1:L
    for j = 1:N1
        if (i-j+1 > 0) && (i-j+1 <= N2)
            y(i) = y(i) + x(j) * h(i-j+1);
        end
    end
end

disp("The length of the convolution is:");
disp(L);

disp("The convolution result y:");
disp(y);
figure;
stem(0:L-1, y, 'filled');
grid on;
xlabel('n');
ylabel('y(n)');
title('Linear Convolution of x(n) and h(n)');

figure;
stem(0:L-1, y, 'filled');
grid on;
xlabel('n');
ylabel('y(n)');
title('Linear Convolution of x(n) and h(n)');
