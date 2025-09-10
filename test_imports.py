#!/usr/bin/env python3
import sys
print("Python version:", sys.version)
print("Python executable:", sys.executable)

try:
    import rembg
    print("✅ rembg imported successfully")
except Exception as e:
    print("❌ Error importing rembg:", str(e))

try:
    import onnxruntime
    print("✅ onnxruntime imported successfully")
except Exception as e:
    print("❌ Error importing onnxruntime:", str(e))

try:
    from PIL import Image
    print("✅ PIL imported successfully")
except Exception as e:
    print("❌ Error importing PIL:", str(e))

print("Test completed.")