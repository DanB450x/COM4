clear;clc;
frecuencia_original = 50;
amplitud = 1;
fase = 0;
omega_original = 2 * pi * frecuencia_original;

fs = 100;                 % Frecuencia de muestreo
Ts = 1 / fs;              % Período de muestreo
omega_muestreo = 2 * pi * fs;
n = 0:Ts:1

x_n = amplitud * sin(omega_muestreo * n + fase);
stem(n, x_n, 'r', 'filled');
xlabel('Índice de tiempo discreto (n)');
title('Secuencia Muestreada x[n]');
grid on;

