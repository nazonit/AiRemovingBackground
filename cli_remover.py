#!/usr/bin/env python3
# Command-line version of the background remover

import argparse
import os
from PIL import Image
from utils.processor import remove_background

def main():
    parser = argparse.ArgumentParser(description="Remove background from an image")
    parser.add_argument("input", help="Input image file path")
    parser.add_argument("output", help="Output image file path")
    
    args = parser.parse_args()
    
    # Check if input file exists
    if not os.path.exists(args.input):
        print(f"Error: Input file '{args.input}' not found.")
        return
    
    # Check if input file is a valid image
    try:
        input_image = Image.open(args.input)
        print(f"Processing image: {args.input}")
    except Exception as e:
        print(f"Error: Cannot open image file '{args.input}'. {str(e)}")
        return
    
    # Process the image
    try:
        output_image = remove_background(input_image)
        print("Background removal completed.")
    except Exception as e:
        print(f"Error: Failed to remove background. {str(e)}")
        return
    
    # Save the output image
    try:
        output_image.save(args.output)
        print(f"Result saved to: {args.output}")
    except Exception as e:
        print(f"Error: Failed to save output image. {str(e)}")
        return

if __name__ == "__main__":
    main()