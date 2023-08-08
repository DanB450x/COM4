clear;clc;
A = 1.5;
omega = pi/3;
phi = pi/4;
n = -5:5;
x = A * exp(1j * (omega * n + phi));
real_part = real(x);
imag_part = imag(x);

figure;
subplot(2,1,1);
stem(n, real_part, 'b', 'filled');
xlabel('Longitud');
title('Parte Real');
subplot(2,1,2);
stem(n, imag_part, 'r', 'filled');
xlabel('Longitud');
title('Parte Imaginaria');

subplot(2,1,1);
ylim([min(real_part) - 0.5, max(real_part) + 0.5]);
subplot(2,1,2);
ylim([min(imag_part) - 0.5, max(imag_part) + 0.5]);
subplot(2,1,1);
pos = get(gca, 'Position');
pos(4) = pos(4) + 0.05;
set(gca, 'Position', pos);

