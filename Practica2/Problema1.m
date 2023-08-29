clear; clc;
n = 1:1:25;
b = 0.8;
x = b.^n;
h = b.^-n;  % Corregido el error en la generación de h

y = conv(x, h);  % Utilizamos 'conv' en lugar de 'conv2'
n1 = length(x) + length(h) - 1;
n2 = 1:n1;

subplot(3,1,1);
stem(n, x, 'b')
title("x[n]")
subplot(3,1,2);
stem(n, h, 'g')  % Corregido el nombre de la variable
title("h[n]")
subplot(3,1,3);
stem(n2, y, 'r')
title("y[n], convolución")
