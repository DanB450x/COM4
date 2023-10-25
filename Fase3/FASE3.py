import pyaudio
import numpy as np
import math
from scipy.signal import butter, lfilter, hann
import time
import matplotlib.pyplot as plt # Importa la librería para graficar

# Funciones para el filtrado de banda
def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(order, [low, high], btype='band')
    return b, a

def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = lfilter(b, a, data)
    return y

# Función para calcular el punto 2
def calcular_punto (x1, y1, d, theta):
  # Convierte el rumbo de grados a radianes
  theta = theta * math.pi / 180
  # Calcula las coordenadas del punto 2
  x2 = x1 + d * math.cos (theta)
  y2 = y1 + d * math.sin (theta)
  # Devuelve el resultado como una tupla
  return (x2, y2)

# Configura PyAudio
p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paInt16, channels=1, rate=44100, input=True, frames_per_buffer=1024)

# Configura el filtro de banda
lowcut = 2000
highcut = 2600
fs = 44100
order = 6

# Define las coordenadas y el ángulo del punto 1 (fijos)
x1 = 200
y1 = 40
theta = 45

# Define el tiempo de medición en segundos
tiempo = 5

try:
    while True:
        # Inicia el tiempo de medición
        inicio = time.time()
        
        # Crea una lista vacía para almacenar los valores de distancia
        distancias = []
        
        # Crea una lista vacía para almacenar los datos del micrófono
        datos = []
        
        # Mientras no se supere el tiempo de medición
        while time.time() - inicio < tiempo:
            # Lee datos del micrófono
            data = np.frombuffer(stream.read(1024), dtype=np.int16)
            
            # Aplica el filtro de banda
            filtered_data = butter_bandpass_filter(data, lowcut, highcut, fs, order)
            
            # Aplica una ventana de Hann para reducir las fugas espectrales
            windowed_data = filtered_data * hann(len(filtered_data))
            
            # Calcula el RMS en la banda de frecuencia de interés
            band_rms = np.sqrt(np.mean(windowed_data**2))
            
            # Convierte el RMS a decibelios (dB)
            dB = 20 * np.log10(band_rms)
            
            # Calcula la distancia usando la fórmula dada
            distancia = math.sqrt(70/dB)
            
            # Añade la distancia a la lista de distancias
            distancias.append(distancia)
            
            # Añade los datos del micrófono a la lista de datos
            datos.extend(windowed_data)
        
        # Calcula el promedio de las distancias
        promedio_distancia = sum(distancias) / len(distancias)
        
        # Imprime la distancia promedio en metros
        print(f"Distancia promedio: {promedio_distancia:.2f} metros")
        
        # Llama a la función para calcular el punto 2 usando la distancia promedio obtenida
        x2, y2 = calcular_punto (x1, y1, promedio_distancia, theta)
        
        # Imprime las coordenadas del punto 2
        print ("Las coordenadas del punto 2 son:", x2, y2)
        
        # Calcula la transformada de Fourier de los datos del micrófono
        fft_data = np.fft.fft(datos)
        
        # Calcula la amplitud de cada componente de frecuencia
        amp_data = np.abs(fft_data)
        
        # Calcula la frecuencia de cada componente de frecuencia
        freq_data = np.fft.fftfreq(len(datos), 1/fs)
        
        # Crea una figura para mostrar la gráfica
        plt.figure()
        
        # Dibuja la amplitud en función de la frecuencia
        plt.plot(freq_data, amp_data)
        
        # Ajusta los límites del eje x para mostrar solo las frecuencias positivas
        plt.xlim(0, fs/2)
        
        # Añade etiquetas a los ejes
        plt.xlabel("Frecuencia (Hz)")
        plt.ylabel("Amplitud")
        
        # Muestra la gráfica en pantalla
        plt.show()
        
        # Rompe el bucle para detener el programa después del primer valor final
        break

except KeyboardInterrupt:
    pass

# Cierra la conexión
stream.stop_stream()
stream.close()
p.terminate()