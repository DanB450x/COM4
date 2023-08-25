clear; clc;

x = 11;  %  impulso en n = 5
n = 0:x-1;
y = [zeros(1, 5) 0.5 0 zeros(1, x-7)];

subplot(1, 1, 1);
stem(n, y, 'r', 'linewidth', 2);
title('Impulso unitario centrado en n = 5');
xlabel('n');
ylabel('y[n]');
axis([-1 x -0.1 0.6]);  % limites del eje
