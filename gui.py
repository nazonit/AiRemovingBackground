import tkinter as tk
from tkinter import filedialog, Label, Button
from PIL import Image, ImageTk
from utils.processor import remove_background

class BackgroundRemoverGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Приложение для удаления фона")
        self.root.geometry("700x600")
        
        self.img_label = Label(root, text="Загрузите изображение")
        self.img_label.pack()

        self.load_button = Button(root, text="Загрузить", command=self.load_image)
        self.load_button.pack()

        self.save_button = Button(root, text="Сохранить", command=self.save_image, state=tk.DISABLED)
        self.save_button.pack()

        self.original_img = None
        self.output_img = None

    def load_image(self):
        file_path = filedialog.askopenfilename()
        if not file_path:
            return
        self.original_img = Image.open(file_path)
        self.output_img = remove_background(self.original_img)
        self.display_image(self.output_img)

        self.save_button.config(state=tk.NORMAL)

    def display_image(self, img):
        img = img.resize((300, 300))
        tk_img = ImageTk.PhotoImage(img)
        self.img_label.config(image=tk_img)
        self.img_label.image = tk_img

    def save_image(self):
        file_path = filedialog.asksaveasfilename(defaultextension=".png")
        if file_path:
            self.output_img.save(file_path)