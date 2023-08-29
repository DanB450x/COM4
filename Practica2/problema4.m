clc;
clear;
pkg load signal;

% señal senoidal con f0 = 300 Hz
f0 = 300; % Frecuencia en Hz
phase = 0; % Fase en radianes
amp = 1; % Amplitud
fs = 8000; % Frecuencia de muestreo en Hz
Ts = 1/fs; % Periodo de muestreo en segundos
tmin = 0; % Tiempo mínimo en segundos
tmax = 0.01; % Tiempo máximo en segundos
t = tmin:Ts:tmax;
x = amp*sin(2*pi*f0*t + phase); % Señal senoidal continua
n = 0:length(t)-1; % Vector de índices discretos
xn = subsref(x,struct('type','()','subs',{{n+1}})); % Señal senoidal discreta

% Aplicar la función decimate para obtener una secuencia diezmada
r = 2; % Factor de diezmado
xd = decimate(xn,r); % Secuencia diezmada

% Aplicar la función interp para obtener una secuencia interpolada
r = 3; % Factor de interpolación
xi = interp(xn,r); % Secuencia interpolada

% Aplicar la función resample para obtener una secuencia remuestreada
p = 5; % Factor de numerador del remuestreo
q = 4; % Factor de denominador del remuestreo
xr = resample(xn,p,q); % Secuencia remuestreada

% Graficar las secuencias originales y remuestreadas
figure(1);
subplot(2,2,1);
plot(t,x,'b');
hold on;
stem(n*Ts,xn,'r');
hold off;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal original');

subplot(2,2,2);
plot(t,x,'b');
hold on;
stem((0:length(xd)-1)*r*Ts,xd,'r');
hold off;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal diezmada');

subplot(2,2,3);
plot(t,x,'b');
hold on;
stem((0:length(xi)-1)*Ts/r,xi,'r');
hold off;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal interpolada');

subplot(2,2,4);
plot(t,x,'b');
hold on;
stem((0:length(xr)-1)*q*Ts/p,xr,'r');
hold off;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal remuestreada');


