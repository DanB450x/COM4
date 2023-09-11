% Definir los coeficientes de la ecuación en diferencias
a = [1 -1.143 0.4128];
b = [0.0675 0.1349 0.0675];

% Crear un vector x = δ[n] de longitud 50
x = zeros(1,50);
x(1) = 1;

% Calcular la salida del filtro y = h[n]
y = filter(b,a,x);

% Graficar las primeras 20 muestras de h[n]
stem(0:19,y(1:20));
xlabel('n');
ylabel('h[n]');
title('Respuesta impulso del filtro');
