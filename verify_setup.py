#!/usr/bin/env python3
# Verification script for the Background Removal App

import os
import sys

def check_files():
    """Check if all required files exist"""
    required_files = [
        "main.py",
        "gui.py",
        "requirements.txt",
        "utils/processor.py",
        "cli_remover.py"
    ]
    
    missing_files = []
    for file in required_files:
        if not os.path.exists(file):
            missing_files.append(file)
    
    return missing_files

def check_dependencies():
    """Check if dependencies can be imported"""
    try:
        import tkinter
        import PIL
        # We won't actually import rembg here as it might not be installed yet
        return True
    except ImportError as e:
        return False

def main():
    print("Verifying Background Removal App Setup")
    print("=" * 40)
    
    # Check files
    print("Checking required files...")
    missing = check_files()
    if missing:
        print(f"❌ Missing files: {', '.join(missing)}")
        return 1
    else:
        print("✅ All required files present")
    
    # Check dependencies
    print("Checking basic dependencies...")
    if check_dependencies():
        print("✅ Basic dependencies available")
    else:
        print("❌ Some basic dependencies missing")
        return 1
    
    print("\n🎉 Setup verification completed successfully!")
    print("You can now run setup_and_run.bat to install all dependencies and run the application.")
    return 0

if __name__ == "__main__":
    sys.exit(main())