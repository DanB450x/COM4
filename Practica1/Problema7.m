clear;
clc;

#Parametros iniciales
x = 5;
f = 10*x;
w = 2*pi*f;
n= -20:1:20;
A = 2;

#Se establece la secuecnia senoidal amortiguada creciente

y_c = A*exp(n).*sin(w*n/1000); #Correción de escala /1000
 
#Se establece la secuecnia senoidal amortiguada dreciente

y_d = A*exp(-n).*sin(w*n/1000); #Correción de escala /1000



#Demostración gráfica de secuencias

subplot(2,1,1); p1 = stem(n, y_c, 'r');
title('Secuencia senoidal amortiguada creciente');
xlabel('x[n]');
ylabel('y[n]');

subplot(2,1,2); p2 = stem(n, y_d, 'b');
title('Secuencia decreciente');
xlabel('x[n]');
ylabel('y[n]');