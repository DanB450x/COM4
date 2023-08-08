clear;
clc; 

#Parametros iniciales
x = 5;
f = 10*x;
w = 2*pi*f;
n= -20:1:20;

# Se establece la secuecnia y[n] = A*Cos(w*n+c)
y_c = cos(w*n/1000); #Correción de escala /1000

#Se establece la secuecnia y[n] = A*Sin(w*n+c)
y_s = sin(w*n/1000); #Correción de escala /1000

#Demostración gráfica de secuencias

subplot(2,1,1); p1 = stem(n, y_c, 'r');
title('Secuencia Cosenoidal');
xlabel('x[n]');
ylabel('y[n]')

subplot(2,1,2); p2 = stem(n, y_s, 'b');
title('Secuencia Senoidal');
xlabel('x[n]');
ylabel('y[n]')