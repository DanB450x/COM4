% Cargar archivo de audio ".wav"
[x, Fs_audio] = audioread('Crazy-GnarlsBarkley.wav');

% Criterios de diseño para filtro Kaiser
Fs = 44.1;  % Frecuencia de muestreo del filtro
Fpass = 2;  % Frecuencia de paso del filtro
Fstop = 3;  % Frecuencia de parada del filtro
Dpass = 0.057501127785;  % Rizado en la banda de paso
Dstop = 0.001;           % Atenuación en la banda de parada
flag  = 'scale';         % Bandera de muestreo

% Calcular el orden del filtro utilizando KAISERORD
[N, Wn, BETA, TYPE] = kaiserord([Fpass Fstop]/(Fs/2), [1 0], [Dstop Dpass]);

% Calcular los coeficientes del filtro utilizando FIR1
b = fir1(N, Wn, TYPE, kaiser(N+1, BETA), flag);
Hd = dfilt.dffir(b);

% Aplicar el filtro a la señal de audio
y = filter(Hd, x);

% Crear un vector de tiempo para la señal original
t_original = (0:length(x)-1) / Fs_audio;

% Graficar la señal original
subplot(3,1,1);
plot(t_original, x);
title('Audio Original');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');

% Aplicar la Transformada de Fourier a la señal original
Y_original = fft(x);

% Calcular el vector de frecuencias
N_original = length(Y_original);
frequencies_original = (0:N_original-1) * (Fs_audio / N_original);

% Graficar el espectro de frecuencias en escala lineal
subplot(3, 1, 2); % Seleccionar el segundo sub-gráfico
plot(frequencies_original, real(Y_original));
title('Espectro de Frecuencias (Escala Lineal)');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');

% Guardar la señal filtrada en un nuevo archivo de audio
audiowrite('Crazy_Kaiser.wav', y, Fs_audio);

% Mensaje de confirmación
disp('Filtro aplicado... señal filtrada.');

% Realizar la transformada de Fourier
Y = fft(y);

% Calcular el vector de frecuencias
N = length(Y);
frequencies = (0:N-1) * (Fs / N);

% Graficar el espectro de frecuencias
subplot(3,1,3);
plot(frequencies, real(Y));
title('Espectro de Frecuencias');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');