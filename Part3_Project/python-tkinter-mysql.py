from tkinter import *
import tkinter as tk
import tkinter.messagebox as MessageBox
import mysql.connector as mysql


class HomePage():
    def __init__(self,root):
        self.root = root

        self.root.geometry("800x700")
        self.root.title("Car Rental System")

        homeFrame  = Frame(self.root, bd =5 , width = 770, height = 700, relief = GROOVE )
        homeFrame.grid(row = 0, column =0)

        window = Frame(homeFrame, bd =1 , width = 500, height = 700, relief = GROOVE )
        window.pack(side=LEFT)

        input_frame = Frame(window, bd=10, width=500, height=350,padx=2, relief=GROOVE)
        input_frame.pack()
        query_info = Frame(homeFrame, bd=10, width=295, height=695,padx=1, pady=1, relief=GROOVE)
        query_info.pack(side = LEFT,padx=0, pady=0)
        view_frame = Frame(window, bd=10, width=500, height=345, padx=2, relief=GROOVE)
        view_frame.pack(side=BOTTOM)

        # ----------------------------------------------------------------------------------------------------
        def quit():
            end_gui = tk.messagebox.askyesno("Car Rental System", "Are you sure you want to exit")
            if end_gui > 0:
                root.destroy()
                return

        def insertCustomerInfo():
            if (self.name_entry.get() == "" or self.phone_entry.get() == ""):
                MessageBox.showinfo("CURRENT STATUS", "All fields are required to enter")
            else:

                mydb = mysql.connect(host="localhost", user="root", password="Miracle177636$", database="car_rental")
                mycursor = mydb.cursor()
                mycursor.execute("INSERT INTO CUSTOMER(Name, Phone) VALUES (%s,%s)",
                                 (self.name_entry.get(), self.phone_entry.get()))
                mydb.commit()
                MessageBox.showinfo("STATUS", "Data Stored sucessfully")
                self.name_entry.delete(0, 'end')
                self.phone_entry.delete(0, 'end')
                mydb.close()

        def insertVehicleInfo():
            print("Hello")
        #--------------------------------------------------------------------------------------------------



        #---------------------------------------------------------------------------------------------------
        def customerEntry():
            self.heading = Label(input_frame, text="Please fill out the following information", font=('bold', 15))
            self.heading.place(x=1,y=1)
            self.name = Label(input_frame, text='Name', font=('bold', 12))
            self.name.place(x=5,y=50)
            self.name_entry = Entry(input_frame, width=50)
            self.name_entry.place(x=70, y=50)

            self.phone = Label(input_frame, text='Phone', font=('bold', 12))
            self.phone.place(x=5, y=90)
            self.phone_entry = Entry(input_frame, width=50)
            self.phone_entry.place(x=70, y=90)

            self.done_button = Button(input_frame, text="DONE", font=("bold", 10), bg='white', width=10, command=insertCustomerInfo)
            self.done_button.place(x=5, y=130)

        def vehicleEntry():
            self.heading = Label(input_frame, text="Please fill out the following information", font=('bold', 15))
            self.heading.place(x=1, y=1)

            self.vin = Label(input_frame, text='VehicleID', font=('bold', 12))
            self.vin.place(x=5, y=50)
            self.vin_entry = Entry(input_frame, width=50)
            self.vin_entry.place(x=95, y=50)

            self.vehicle = Label(input_frame, text='Description', font=('bold', 12))
            self.vehicle.place(x=5, y=80)
            self.vehicle_entry = Entry(input_frame, width=50)
            self.vehicle_entry.place(x=95, y=80)

            self.year = Label(input_frame, text='Year', font=('bold', 12))
            self.year.place(x=5, y=110)
            self.year_entry = Entry(input_frame, width=50)
            self.year_entry.place(x=95, y=110)

            self.type = Label(input_frame, text='Type', font=('bold', 12))
            self.type.place(x=5, y=140)
            self.type_entry = Entry(input_frame, width=50)
            self.type_entry.place(x=95, y=140)

            self.category = Label(input_frame, text='Category', font=('bold', 12))
            self.category.place(x=5, y=170)
            self.category_entry = Entry(input_frame, width=50)
            self.category_entry.place(x=95, y=170)

            self.done_button = Button(input_frame, text="DONE", font=("bold", 10), bg='white', width=10,
                                      command=insertVehicleInfo)
            self.done_button.place(x=5, y=210)

        self.buttona = Button(query_info,font = ("bold", 15, ), text = "CustomerEntry", bd=5, pady=10,padx=20,width=20,
                             height = 2,command = customerEntry).grid(row=0,column=0,padx=1,pady=8)
        self.buttonb = Button(query_info, font=("bold", 15,), text="VehicleEntry", bd=5, pady=10, padx=20, width=20,
                             height=2,command = vehicleEntry).grid(row=1, column=0, padx=1,pady=8)
        self.buttonc = Button(query_info, font=("bold", 15,), text="Rental", bd=5, pady=5, padx=20, width=20,
                             height=2).grid(row=2, column=0, padx=1,pady=8)
        self.buttond = Button(query_info, font=("bold", 15,), text="Query1", bd=5, pady=5, padx=20, width=20,
                             height=2).grid(row=3, column=0, padx=1,pady=8)
        self.buttone = Button(query_info, font=("bold", 15,), text="Query2", bd=5, pady=10, padx=20, width=20,
                             height=2).grid(row=4, column=0, padx=1,pady=8)
        self.buttonf = Button(query_info, font=("bold", 15,), text="Query3", bd=5, pady=5, padx=20, width=20,
                             height=2).grid(row=5, column=0, padx=1,pady=8)
        self.buttong = Button(query_info, font=("bold", 15,), text="Exit", bd=5, pady=5, padx=20, width=20,
                             height=2, command = quit).grid(row=6, column=0, padx=1,pady=8)

if __name__ == '__main__':
    root = Tk()
    homePage = HomePage(root);
    root.mainloop();



