# 🧼 Background Removal App (Local GUI with rembg)

🎯 A lightweight desktop application to remove image backgrounds using AI (U-2-Net).  
Built with Python, Tkinter, and the `rembg` library. Works offline on CPU – no GPU required.

This README includes **all steps**, **folder structure**, **tools**, and **errors I faced**, documented for my future reference.

---

## 📁 Folder Structure

Background Extractor/
│
├── assets/ # Optional: image files for testing
├── docs/ # Technical documentation
│ ├── technical_specification_ru.md # Technical specification (Russian)
│ ├── user_guide_ru.md # User guide (Russian)
│ ├── developer_guide_ru.md # Developer guide (Russian)
│ ├── changelog_ru.md # Changelog (Russian)
│ └── README.md # Documentation README
├── utils/
│ └── processor.py # Uses rembg to remove background
├── cli_remover.py # Command-line version of the tool
├── CLI_README.md # Documentation for CLI version
├── gui.py # Tkinter GUI logic
├── main.py # Entry point for launching app
├── setup_and_run.bat # Complete setup and run script
├── install.bat # Installation script for Windows
├── run.bat # Launch script for Windows
├── requirements.txt # Python dependencies
├── requirements_RU.txt # Russian version of Python dependencies
├── venv/ # Virtual environment (excluded from Git)
├── .gitignore # Ignore virtualenv, pycache, etc.
├── README.md # English documentation
└── README_RU.md # Russian documentation

---

## 🌍 Language Versions

- [English README](README.md) - English documentation
- [Russian README](README_RU.md) - Документация на русском языке

---

## 🚀 Quick Start (Windows)

### Complete Setup and Run (Recommended)
Double-click `setup_and_run.bat` to:
1. Check Python installation
2. Create virtual environment
3. Install all dependencies
4. Verify installation
5. Optionally launch the application

### Manual Setup
1. **Install the application:**
   Double-click `install.bat` or run it from the command line:
   ```bash
   install.bat
   ```

2. **Run the application:**
   Double-click `run.bat` or run it from the command line:
   ```bash
   run.bat
   ```

### CLI Version
For command-line usage:
```bash
python cli_remover.py input.jpg output.png
```

See [CLI_README.md](CLI_README.md) for detailed CLI usage instructions.

---

## 📚 Technical Documentation

Detailed technical documentation is available in the [docs](docs) directory:
- [Technical Specification (RU)](docs/technical_specification_ru.md)
- [User Guide (RU)](docs/user_guide_ru.md)
- [Developer Guide (RU)](docs/developer_guide_ru.md)
- [Changelog (RU)](docs/changelog_ru.md)

---

## ⚙️ Manual Setup Instructions

### 1. Create project folder

```bash
cd "D:\Models"
mkdir "Background Extractor"
cd "Background Extractor"
```

Or clone this repo if it's on GitHub:

```bash
git clone https://github.com/your-username/background-removal-app.git
cd background-removal-app
```

### 2. Create and activate virtual environment

```bash
python -m venv venv
venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install rembg onnxruntime pillow
```

Or using the requirements.txt file:

```bash
pip install -r requirements.txt
```

For Russian version:
```bash
pip install -r requirements_RU.txt
```

---

## 🧠 U-2-Net Model: u2net.onnx

The rembg library needs to download the U-2-Net model (u2net.onnx) on the first run.

However, I kept facing network errors like:

```
IncompleteRead(X bytes read, Y more expected)
ChunkedEncodingError
WinTLS: Failed to encrypt a message! Error: The context has expired
```

✅ FIX: Manual Download via aria2

🔧 Step 1: Download Aria2 (Portable)
I downloaded:
aria2-1.19.0-win-32bit-build1.zip
→ Unzipped it at:
C:\Users\HP\Downloads\aria2-1.19.0-win-32bit-build1\aria2-1.19.0-win-32bit-build1\aria2c.exe

🔧 Step 2: Run Aria2 to Download the Model

```bash
"C:\Users\HP\Downloads\aria2-1.19.0-win-32bit-build1\aria2-1.19.0-win-32bit-build1\aria2c.exe" -x 16 -s 16 https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx
```

It will download:

```
C:\Users\HP\u2net.onnx
```

⚠️ The model must be placed at:

```
C:\Users\HP\.u2net\u2net.onnx
```

If .u2net doesn't exist, create the folder manually.

---

## ▶️ Run the App

### GUI Version
Using the launch script:
```bash
run.bat
```

Or manually:
```bash
python main.py
```

A Tkinter window will open. You can:

- Upload a .png or .jpg image
- Click the button to remove the background
- View and save the output

### CLI Version
```bash
python cli_remover.py input.jpg output.png
```

---

## ⚠️ Personal Notes – Errors I Faced

❌ IncompleteRead / ChunkedEncodingError — Happens during model download. Solved using aria2.

❌ WinTLS: Failed to encrypt a message! — Network timeout or TLS errors while downloading large files. aria2 handles it better.

⚠️ onnxruntime_providers_cuda.dll missing —

```
Error loading onnxruntime_providers_cuda.dll: cublasLt64_12.dll is missing
```

This is related to GPU acceleration (CUDA). Safe to ignore. It runs on CPU just fine.

---

## 💡 To-Do (for future)

- Add threading to GUI to prevent freeze during processing
- Convert app to standalone .exe with pyinstaller
- Add image preview for uploaded and processed image
- Drag-and-drop support

---

## 📦 Libraries Used

- rembg – AI-powered background remover
- onnxruntime – For running U-2-Net
- pillow – Image loading and saving
- tkinter – GUI framework
- aria2 – Fast multi-connection model downloader (manual fix)

---

## 🧠 Reference (for model)

Official U-2-Net used by rembg:
📦 https://github.com/danielgatis/rembg
📄 Model URL:
https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx

---

## 🛠️ Built for Local Use Only

No cloud processing, no user tracking — just a fast and local AI tool for background removal.