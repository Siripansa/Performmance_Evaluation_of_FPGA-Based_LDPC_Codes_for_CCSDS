# UART Tx/Rx demo
import time
import tkinter as tk
from tkinter import ttk
import serial
import threading
from tkinter import filedialog as fd

# A simple Information Window
class InformWindow:
    def __init__(self,informStr):
        self.window = tk.Tk()
        self.window.title("Information")
        self.window.geometry("300x100")
        label = tk.Label(self.window, text=informStr)
        buttonOK = tk.Button(self.window,text="OK",command=self.processButtonOK)
        label.pack(side = tk.TOP)
        buttonOK.pack(side = tk.BOTTOM)
        self.window.mainloop()

    def processButtonOK(self):
        self.window.destroy()

class mainGUI:
    def __init__(self):
        window = tk.Tk()
        window.title("Based Performance Evaluation of FPGA-based LDPC codes for CCSDS standard")
        self.uartState = False # is uart open or not

        # a frame contains COM's information, and start/stop button
        frame_COMinf = tk.Frame(window)
        frame_COMinf.grid(row = 1, column = 0)

        labelCOM = tk.Label(frame_COMinf,text="COMx: ")
        self.COM = tk.StringVar(value = "COM7")
        ertryCOM = tk.Entry(frame_COMinf, textvariable = self.COM)
        labelCOM.grid(row = 1, column = 0, padx = 1, pady = 3)
        ertryCOM.grid(row = 1, column = 1, padx = 1, pady = 3)

        labelBaudrate = tk.Label(frame_COMinf,text="Baudrate: ")
        self.Baudrate = tk.IntVar(value = 115200)
        ertryBaudrate = tk.Entry(frame_COMinf, textvariable = self.Baudrate)
        labelBaudrate.grid(row = 2, column = 0, padx = 1, pady = 3)
        ertryBaudrate.grid(row = 2, column = 1, padx = 1, pady = 3)

        labelParity = tk.Label(frame_COMinf,text="Parity: ")
        self.Parity = tk.StringVar(value ="NONE")
        comboParity = ttk.Combobox(frame_COMinf, width = 17, textvariable=self.Parity)
        comboParity["values"] = ("NONE","ODD","EVEN","MARK","SPACE")
        comboParity["state"] = "readonly"
        labelParity.grid(row = 3, column = 0, padx = 1, pady = 3)
        comboParity.grid(row = 3, column = 1, padx = 1, pady = 3)

        labelStopbits = tk.Label(frame_COMinf,text="Stopbits: ")
        self.Stopbits = tk.StringVar(value ="1")
        comboStopbits = ttk.Combobox(frame_COMinf, width = 17, textvariable=self.Stopbits)
        comboStopbits["values"] = ("1","1.5","2")
        comboStopbits["state"] = "readonly"
        labelStopbits.grid(row = 4, column = 0, padx = 1, pady = 3)
        comboStopbits.grid(row = 4, column = 1, padx = 1, pady = 3)
        
        self.buttonSS = tk.Button(frame_COMinf, text = "Start", command = self.processButtonSS)
        self.buttonSS.grid(row = 5, column = 0, padx = 1, pady = 3, sticky = tk.E)

        # serial object
        self.ser = serial.Serial()
        # serial read threading
        self.ReadUARTThread = threading.Thread(target=self.ReadUART)
        self.ReadUARTThread.start()

        frameRecv = tk.Frame(window)
        frameRecv.grid(row = 1, column = 1)
        labelOutText = tk.Label(frameRecv,text="Bir Error Rate (BER) : ")
        labelOutText.grid(row = 2, column = 1, padx = 3, pady = 2, sticky = tk.W)
        frameRecvSon = tk.Frame(frameRecv)
        frameRecvSon.grid(row = 3, column =1)
        self.OutputText = tk.Text(frameRecvSon, wrap = tk.WORD, width = 10, height = 2)
        self.OutputText.grid(row = 4, column = 1)

        labelInText = tk.Label(frameRecv, text = "Set the variance of Gaussian noise")
        labelInText.grid(row = 0, column = 1,  padx = 3, pady = 2)
        self.send_var = tk.Entry(frameRecv, text = 'Send Variance', width = 10)
        self.send_var.grid(row=1, column=1,padx=1, pady=1)
        
        self.open_button = tk.Button(frameRecv, text='Enter', command = self.processButtonSend)
        self.open_button.grid(row=1, column=2,padx=10, pady=10)
        
        # self.clear_button=tk.Button(frameRecv, height=1, width=10, text="Clear", command = self.clearToTextInput)
        # self.clear_button.grid(row = 3, column = 2, padx = 5, pady = 3)
        
        window.mainloop()

    def processButtonSS(self):
        # print(self.Parity.get())
        if (self.uartState):
            self.ser.close()
            self.buttonSS["text"] = "Start"
            self.uartState = False
        else:
            # restart serial port
            self.ser.port = self.COM.get()
            self.ser.baudrate = self.Baudrate.get()
            
            strParity = self.Parity.get()
            if (strParity=="NONE"):
                self.ser.parity = serial.PARITY_NONE
            elif(strParity=="ODD"):
                self.ser.parity = serial.PARITY_ODD
            elif(strParity=="EVEN"):
                self.ser.parity = serial.PARITY_EVEN
            elif(strParity=="MARK"):
                self.ser.parity = serial.PARITY_MARK
            elif(strParity=="SPACE"):
                self.ser.parity = serial.PARITY_SPACE
                
            strStopbits = self.Stopbits.get()
            if (strStopbits == "1"):
                self.ser.stopbits = serial.STOPBITS_ONE
            elif (strStopbits == "1.5"):
                self.ser.stopbits = serial.STOPBITS_ONE_POINT_FIVE
            elif (strStopbits == "2"):
                self.ser.stopbits = serial.STOPBITS_TWO
            
            try:
                self.ser.open()
            except:
                infromStr = "Can't open "+self.ser.port
                InformWindow(infromStr)
            
            if (self.ser.isOpen()): # open success
                self.buttonSS["text"] = "Stop"
                self.uartState = True

    def processButtonSend(self):
        if (self.uartState):
            strToSend = self.send_var.get()
            #print(strToSend, type(strToSend))
            bytesToSend = strToSend[0:-1].encode(encoding='ascii')
            self.ser.write(bytesToSend)
            #print(bytesToSend)
    
    def processButtonSendfile(self):
        if (self.uartState):
            filetypes = (('text files', '*.txt'), ('All files', '*.*'))
    # show the open file dialog
            f = fd.askopenfile(filetypes=filetypes)
    # read the text file and show its content on the Text
            tx_in = str(f.read())
            bytesToSend = tx_in.encode(encoding='ascii')
            self.ser.write(bytesToSend)
            print(bytesToSend)
        else:
            infromStr = "Not In Connect!"
            InformWindow(infromStr)

    def clearToTextInput(self):
        if (self.uartState):
            self.OutputText.delete("1.0","end")


    def ReadUART(self):
        # print("Threading...")
        
        while True:
            if (self.uartState):
                try:
                    ch = self.ser.read(self.ser.inWaiting()).decode(encoding='ascii')
                    print(ch,end='')
                    self.OutputText.insert(tk.END,ch)
                    time.sleep(5)
                    self.OutputText.delete("1.0", "end")

                except:
                    infromStr = "Something wrong in receiving."
                    InformWindow(infromStr)
                    self.ser.close() # close the serial when catch exception
                    self.buttonSS["text"] = "Start"
                    self.uartState = False


mainGUI()