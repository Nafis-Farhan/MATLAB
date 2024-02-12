import tkinter as tk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import numpy as np
from scipy.integrate import odeint
from scipy.fft import fft, fftfreq
import matplotlib.gridspec as gridspec

class DataPointInputGUI:
    def __init__(self, master):
        self.master = master
        self.master.title("Data Point Input")

        self.fig= plt.figure()
        self.gs = gridspec.GridSpec(8,8)
        self.ax1 = plt.subplot(self.gs[:4, :])
        self.ax2 = plt.subplot(self.gs[5:6, :])
        self.ax3 = plt.subplot(self.gs[7:, :])
        self.ax1.set_title('P vs K')
        self.ax1.set_xlim(-1000, 3000)
        self.ax1.set_ylim(10**8, 10**9)
        self.ax3.set_ylim(0 ,.009)

        self.point = []
        self.ax1.scatter([], [], color='blue')

        self.ax2.set_title('Waveform')
        self.ax3.set_title('FFT')

        self.canvas = FigureCanvasTkAgg(self.fig, master=master)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)

        self.cid = self.fig.canvas.mpl_connect('button_press_event', self.onclick)

    def onclick(self, event):
        if event.inaxes == self.ax1:
            x = event.xdata
            y = event.ydata
            self.point = (x,y)
            self.update_plot()
            self.simulate()

    def update_plot(self):
        self.ax1.clear()
        self.ax1.set_title('P vs K')
        self.ax1.set_xlim(-1000, 3000)
        self.ax1.set_ylim(10**8, 10**9)
        if self.point:
            xs, ys = self.point
            self.ax1.scatter(xs, ys, color='blue')
        self.canvas.draw()

    def simulate(self):
        K=self.point[1]
        P = self.point[0]
        t, song = self.singSyllable(K, P)

        self.ax2.clear()
        self.ax3.clear()
        self.ax3.set_ylim(0 ,.009)
        self.ax2.plot(t, song)
        self.ax2.set_title('Waveform')

        Fs = 22050
        s_fft = fft(song)
        t_fft = fftfreq(len(t), 1/Fs)[0:len(t)//2]

        self.ax3.plot(t_fft, 2.0/len(t) * np.abs(s_fft[0:len(t)//2]))
        self.ax3.set_title('FFT')

        self.canvas.draw()

    def singSyllable(self, K, P):
        Fs = 22050  
        t = np.arange(0, 0.24, 1/Fs)  

        def syrinx(y, t, K, P):
            b = 1000
            d = 10**8
            yprime = np.zeros(2)
            yprime[0] = y[1]
            yprime[1] = (P - b) * y[1] - K * y[0] - d * (y[0]**2) * y[1]
            return yprime

        y0 = [0.01, 0.01]

        z = odeint(syrinx, y0, t, args=(K, P,))
        song = z[:, 0]

        return t, song

def main():
    root = tk.Tk()
    app = DataPointInputGUI(root)
    root.mainloop()  # Start the Tkinter event loop

if __name__ == "__main__":
    main()
