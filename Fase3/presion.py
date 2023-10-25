import pyaudio
import numpy as np
from scipy.signal import butter, lfilter, hann

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

# Configura PyAudio
p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paInt16, channels=1, rate=44100, input=True, frames_per_buffer=1024)

# Configura el filtro de banda
lowcut = 2000
highcut = 2600
fs = 44100
order = 6

try:
    while True:
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
        
        print(f"Nivel de presión sonora en la banda 2000-2600 Hz: {dB:.2f} dB")

except KeyboardInterrupt:
    pass

# Cierra la conexión
stream.stop_stream()
stream.close()
p.terminate()
