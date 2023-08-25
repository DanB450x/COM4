#Muestro de una señal
clear;
clc;
f=300; #Frecuencia
T=0.010; #Tiempo
w = 2*pi*f; #Frecuencia angular
t=0:T:1; #Intervalo de tiempo
x=sin((w*t)/100); #Función senoidal
fs=8000; #freuencia de muestreo
Ts=1/fs; #Tiempo de muestreo
n=0:1:100; #Intervalo de muestreo
x_n=sin(w*n*Ts); #Secuencia x[n]
 
 
#Gráfica de función y secuencia
subplot(2,1,1);
plot(t,x,'r')
title("Señal senoidal x(t) en tiempo continuo")
xlabel('Tiempo (s)');
ylabel('Amplitud');
 
subplot(2,1,2);
stem(n,x_n,'b')
title("Secuencia x[n] en tiempo discreto")
xlabel('Muestra [n]');
ylabel('Salida y[n]');


#Inciso A
freqs_a = 100:125:475; # Frecuencias desde 100 Hz hasta 475 Hz en saltos de 125 Hz

#Crear una nueva figura
figure;

# Iterar a través de las frecuencias
for i = 1:length(freqs_a)
    f_a = freqs_a(i);
    w_a= 2*pi*f_a;
    x_a = sin((w_a * t)/100);
    x_na=sin(w_a*n*Ts); #Secuencia x[n]
    
    % Crear un subplot
    subplot(length(freqs_a), 2, 2*i-1);
    plot(t, x_a, 'r');
    title(['f = ' num2str(f_a) ' [Hz]']);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');  

    % Crear un subplot
    subplot(length(freqs_a), 2, 2*i);
    stem(t, x_na, 'b');
    title(['f = ' num2str(f_a) ' [Hz]']);
    xlabel('Muestra [n]');
    ylabel('Salida y[n]'); 
end

#Inciso B
freqs_b = 7525:125:7900; # Frecuencias desde 100 Hz hasta 475 Hz en saltos de 125 Hz

#Crear una nueva figura
figure;

# Iterar a través de las frecuencias
for i = 1:length(freqs_b)
    f_b = freqs_b(i);
    w_b= 2*pi*f_a;
    x_b = sin((w_b * t)/100);
    x_nb=sin(w_b*n*Ts); #Secuencia x[n]
    
    % Crear un subplot
    subplot(length(freqs_b), 2, 2*i-1);
    plot(t, x_b, 'r');
    title(['f = ' num2str(f_b) ' [Hz]']);
    xlabel('Tiempo (s)');
    ylabel('Amplitud');  

    % Crear un subplot
    subplot(length(freqs_b), 2, 2*i);
    stem(t, x_nb, 'b');
    title(['f = ' num2str(f_b) ' [Hz]']);
    xlabel('Muestra [n]');
    ylabel('Salida y[n]'); 
end

