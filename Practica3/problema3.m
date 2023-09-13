% Generar la secuencia X: onda senoidal muestreada a 10 ms de amplitud 1 y frecuencia 100 Hz
Fs = 1000; % Frecuencia de muestreo en Hz (1/0.01)
t = 0:0.01:1; % Vector de tiempo de 0 a 1 segundo con paso de 10 ms
frecuenciaX = 100; % Frecuencia de la onda senoidal en Hz
X = sin(2 * pi * frecuenciaX * t);

% Calcular la auto-correlación de X y mostrar el coeficiente máximo
autoCorrelacion = xcorr(X, 'coeff');
coeficienteMaximoAuto = max(autoCorrelacion);
fprintf('Coeficiente máximo en la auto-correlación: %.4f\n', coeficienteMaximoAuto);

% Generar la secuencia Y: senoidal muestreada a 10 ms de amplitud 1, frecuencias de 100 a 400 Hz en saltos de 100 Hz
frecuenciasY = 100:100:400; % Frecuencias de 100 a 400 Hz
coeficientesMaximos = zeros(1, length(frecuenciasY));

for i = 1:length(frecuenciasY)
    frecuenciaY = frecuenciasY(i);
    Y = sin(2 * pi * frecuenciaY * t);
    
    % Calcular la correlación cruzada entre X e Y y mostrar el coeficiente máximo
    correlacionCruzada = xcorr(X, Y, 'coeff');
    coeficienteMaximo = max(correlacionCruzada);
    coeficientesMaximos(i) = coeficienteMaximo;
    
    fprintf('Coeficiente máximo en la correlación cruzada para frecuencia %.0f Hz: %.4f\n', frecuenciaY, coeficienteMaximo);
end