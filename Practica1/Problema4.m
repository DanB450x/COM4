clear; clc;

x = 5;
c = x/10;  % Ajustamos el ciclo de trabajo
f = x*10;
w = 2*pi*f;
n = -10:1:10;

y = sign(sin(w*n + c));

stem(n, y, 'b', 'linewidth', 2);
title('Secuencia Cuadrada Periódica');
xlabel('n');
ylabel('Amplitud');
