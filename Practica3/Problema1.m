#Problema 1 - Luis Paniagua
#Transformada de Fourier en Tiempo Discretro

clear;
clc;

n = -pi:0.5:pi; %Creamos vector n
y = zeros(size(n)); %Matriz de ceros igual a n
y(n >= -pi & n <= pi) = 1; %Asigna el valor 1 a los elementos de 'y' donde 'n' está dentro del rango [-pi, pi]

subplot(2,1,1);
stem(n, y, 'r');  % Grafica en tiempo discreto
title('Señal h[n]');
xlim([-pi, pi])

w = -pi:0.1:pi;
x = 1 + 2*cos(w) + 2*cos(2*w);
subplot(2,1,2);
stem(w, x, 'b'); % Grafica en tiempo discreto
xlim([-pi, pi]);
title('Vector H');


