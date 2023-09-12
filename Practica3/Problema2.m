#Problema 2 - Luis Paniagua
#Transformada de Fourier en Tiempo Discretro

clear;
clc;

#Parámetros de la señal
fs = 1000; #Frecuencia de muestreo en Hz
t = 0:1/fs:1; #Vector de tiempo de 1 segundo

#Señal senoidal 1
A1= 1;
f1 = 100;
S1 = A1*sin(2*pi*f1*t);

#Señal senoidal 2
A2 = 0.8;
f2 = 300;
S2 = A2*sin(2*pi*f2*t);

#Generando ruido aleatorio con media de cero
med = 0;
desv = 0.2; #Ajuste según la cantidad de ruido deseado
R = desv*randn(size(t)) + med;

#Generando señal compuesta con ruido
S_Comp = S1+S2 +R;

#Calculando la Transformada Discreta de Fourier utilizando fft
TDF = fft(S_Comp);

#Calcular el eje de frecuencia correspondiente
f = fs*(0:(length(TDF)-1)) / length(TDF);

#Señal generada en el dominio del tiempo
subplot(2, 1, 1);
plot(t, S_Comp);
title('Señal Compuesta con Ruido');
xlabel('Tiempo[s]');
ylabel('Amplitud');

#Grafica de TDF en el domino de la frecuencia
subplot(2, 1, 2);
plot(f, abs(TDF));
title('Transformada Discreta de Fourier (TDF)');
xlabel('Frecuencia[Hz]');
ylabel('Magnitud');

# Ajustar los límites del eje x en la segunda subtrama para mostrar solo frecuencias positivas
xlim([0, fs/2]);
