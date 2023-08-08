clear;clc;
frecuencia = 50;
amplitud = 1;
fase = 0;
tiempo = 0:0.001:0.1;
xc = amplitud * sin(2 * pi * frecuencia * tiempo + fase);

figure;
plot(tiempo, xc, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
title('Señal Senoidal en Tiempo Continuo');
grid on;


