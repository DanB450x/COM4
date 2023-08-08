clear; 
clc;

#Parametros iniciales

A = 2;
n = -20:1:20;

#Secuencia exponecial creciente

y_c = A*exp(n);

#Secuencia exponecial decreciente

y_d = A*exp(-n);


#Demostración gráfica de secuencias

subplot(2,1,1); p1 = stem(n, y_c, 'r');
title('Secuencia creciente');
xlabel('x[n]');
ylabel('y[n]');

subplot(2,1,2); p2 = stem(n, y_d, 'b');
title('Secuencia decreciente');
xlabel('x[n]');
ylabel('y[n]');