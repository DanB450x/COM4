# Importar las librerías necesarias
import numpy as np
import scipy.signal as sig
import pyaudio as pa

# Definir las constantes del sistema
FS = 44100 # Frecuencia de muestreo en Hz
T = 1 # Tiempo de grabación en segundos
N = FS * T # Número de muestras
F = 1000 # Frecuencia del tono emitido por la fuente en Hz
THETA = 45 # Ángulo entre el eje x y la fuente en grados
D = 2 # Distancia entre el origen y la fuente en metros
C = 343 # Velocidad del sonido en el aire en m/s

# Crear un objeto de PyAudio para grabar el sonido
p = pa.PyAudio()
stream = p.open(format=pa.paInt16, channels=1, rate=FS, input=True)

# Crear un arreglo vacío para almacenar las muestras
samples = np.zeros(N)

# Grabar el sonido durante T segundos
for i in range(N):
    data = stream.read(1)
    samples[i] = np.frombuffer(data, dtype=np.int16)

# Cerrar el stream y el objeto de PyAudio
stream.stop_stream()
stream.close()
p.terminate()

# Aplicar una ventana de Hamming para reducir el efecto de fuga espectral
window = sig.windows.hamming(N)
samples = samples * window

# Calcular la transformada de Fourier para obtener el espectro de frecuencias
fft = np.fft.fft(samples)
freqs = np.fft.fftfreq(N, 1/FS)

# Buscar el índice del pico más alto en el espectro, que corresponde a la frecuencia del tono
peak_index = np.argmax(np.abs(fft))
peak_freq = freqs[peak_index]

# Calcular el ángulo entre el micrófono y la fuente usando la fórmula: f_m = f_s * (c + v_m) / (c + v_s)
# donde f_m es la frecuencia medida por el micrófono, f_s es la frecuencia emitida por la fuente,
# c es la velocidad del sonido, v_m es la velocidad del micrófono y v_s es la velocidad de la fuente.
# Como el micrófono y la fuente están fijos, sus velocidades son cero, y la fórmula se simplifica a:
# f_m = f_s * c / (c + v_s)
# Despejando v_s, tenemos que: v_s = c * (f_s - f_m) / f_m
# La velocidad de la fuente es igual a la componente x de su velocidad multiplicada por el coseno del ángulo,
# es decir: v_s = v_x * cos(theta)
# Despejando theta, tenemos que: theta = arccos(v_s / v_x)
# Como no conocemos v_x, podemos usar la relación: v_x = d * omega
# donde d es la distancia entre el origen y la fuente, y omega es la velocidad angular de la fuente.
# La velocidad angular se puede calcular como: omega = 2 * pi * f_s / c
# Sustituyendo estos valores en la fórmula anterior, tenemos que: theta = arccos(v_s / (d * omega))
v_s = C * (F - peak_freq) / peak_freq
omega = 2 * np.pi * F / C
theta = np.arccos(v_s / (D * omega))

# Convertir el ángulo de radianes a grados
theta = np.rad2deg(theta)

# Calcular la distancia entre el micrófono y la fuente usando la ley de senos:
# d_m / sin(alpha) = d / sin(beta)
# donde d_m es la distancia buscada, alpha es el ángulo opuesto a d_m, beta es el ángulo opuesto a d.
# Como conocemos el ángulo theta, podemos calcular alpha y beta como:
# alpha = 90 - theta
# beta = 180 - alpha - THETA
# Despejando d_m, tenemos que: d_m = d * sin(alpha) / sin(beta)
alpha = 90 - theta
beta = 180 - alpha - THETA
d_m = D * np.sin(np.deg2rad(alpha)) / np.sin(np.deg2rad(beta))

# Mostrar los resultados por pantalla
print(f"La frecuencia medida por el micrófono es {peak_freq:.2f} Hz")
print(f"El ángulo entre el micrófono y la fuente es {theta:.2f} grados")
print(f"La distancia entre el micrófono y la fuente es {d_m:.2f} metros")