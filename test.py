import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
from scipy.fft import fft, fftfreq
from ipywidgets import interact

def singSyllable(rho):
    Fs = 22050  # sampling frequency
    t = np.arange(0, 0.24, 1/Fs) #time sample points
    
    #spring constant function
    def kt(t,rho):
        return 4 * 10**8 * np.cos(2 * np.pi * t/.24 + rho) + 9 * 10**8
        #return 5*10**8
    
    #presure diff function
    def pt(t,rho):
        return 1005 + 1000 * np.cos(2 * np.pi * t/.24)
        #return 2500
    
    #main diff equation
    def syrinx(y, t,rho):
        b = 1000
        d = 10**8
        yprime = np.zeros(2)
        yprime[0] = y[1]
        yprime[1] = (pt(t,rho) - b) * y[1] - kt(t,rho) * y[0] - d * (y[0]**2) * y[1]
        return yprime
    
    #init condition
    y0 = [0.01, 0.01]
    
    #ode solver
    z = odeint(syrinx, y0, t, args=(rho,))
    song = z[:, 0]
    
    return t, song

def plot_wave_and_fft(rho):
    t, song = singSyllable(rho)
    
    #plt.figure(figsize=(12, 6))
    fig,(ax1,ax2,ax3) = plt.subplots(nrows=3)
    # Plot wave
    #plt.subplot(3, 1, 1)
    ax1.plot(t, song)
    ax1.set_title('Waveform')
    ax1.set_xlabel('Time')
    ax1.set_ylabel('Amplitude')
    
    # Calculate FFT
    Fs = 22050
    s_fft = fft(song)
    t_fft = fftfreq(len(t), 1/Fs)[0:len(t)//2]
    
    # Plot FFT
    #plt.subplot(3, 1, 2)
    ax2.plot(t_fft, 2.0/len(t) * np.abs(s_fft[0:len(t)//2]))
    ax2.set_title('FFT')
    ax2.set_xlabel('Frequency (Hz)')
    ax2.set_ylabel('Amplitude')
    
    
    
    # Plot FFT
    #plt.subplot(3, 1, 2)
    ax3.specgram(song,Fs=Fs,Fc=0)
    ax3.set_title('sonogram')
    ax3.set_ylabel('Frequency (Hz)')
    ax3.set_xlabel('time')
    ax3.set_ylim(0, 6000)
    plt.tight_layout()
    plt.show()
# Add slider for rho
interact(plot_wave_and_fft, rho=(0, 2*np.pi, 0.01))
