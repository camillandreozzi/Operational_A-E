"""
Script to replace Italian text with English throughout the repository
"""

import os
import re
import json
from pathlib import Path

# Dictionary of Italian to English translations
TRANSLATIONS = {
    # Common Italian words to English
    "Population:": "Population:",
    "Area:": "Area:",
    "Density:": "Density:",
    "inhabitants/km²": "inhabitants/km²",
    "Exploration": "Exploration", 
    "Analysis": "Analysis",
    "Loading": "Loading",
    "Data": "Data",
    "Visualization": "Visualization",
    "Creation": "Creation",
    "Generation": "Generation",
    "Filtering": "Filtering",
    "Import": "Import",
    "Explore": "Explore",
    "Analyze": "Analyze",
    "Load": "Load",
    "Visualize": "Visualize",
    "Create": "Create",
    "Generate": "Generate",
    "Filter": "Filter",
    "Import": "Import",
    "charts": "charts",
    "map": "map",
    "city": "city",
    "hospital": "hospital",
    "hospitals": "hospitals",
    "patients": "patients",
    "zone": "zone",
    "region": "region",
    "population": "population",
    # Specific Italian phrases to English
    "This notebook explores": "This notebook explores",
    "Import all the libraries": "Import all the libraries",
    "Load the data": "Load the data",
    "Analyze the structure": "Analyze the structure",
    "Extract and analyze": "Extract and analyze",
    "Create visualizations": "Create visualizations",
    "for analysis": "for analysis",
    "of the data": "of the data",
    "and visualization": "and visualization",
    "necessary for": "necessary for",
    "available for": "available for",
    "loaded successfully": "loaded successfully",
    "not available": "not available",
    "file not found": "file not found",
    "general information": "general information",
    "unique values": "unique values",
    "numerical columns": "numerical columns",
    "potential coordinates": "potential coordinates"
}

def translate_text(text):
    """Replace Italian text with English translations"""
    for italian, english in TRANSLATIONS.items():
        text = text.replace(italian, english)
    return text

def process_file(file_path):
    """Process a single file to replace Italian text"""
    try:
        # Skip binary files
        if file_path.suffix.lower() in ['.png', '.jpg', '.jpeg', '.gif', '.pdf', '.xlsx', '.rdata', '.npz', '.pkl']:
            return False
            
        # Read file content
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        # Apply translations
        original_content = content
        content = translate_text(content)
        
        # Write back if changes were made
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
            
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
    
    return False

def main():
    """Main function to process all files in the repository"""
    repo_path = Path("c:/Users/glauc/Desktop/PHS/Operational_A-E")
    
    processed_files = []
    
    # Walk through all files in the repository
    for file_path in repo_path.rglob("*"):
        if file_path.is_file():
            # Skip .git files and other system files
            if '.git' in str(file_path) or file_path.name.startswith('.'):
                continue
                
            if process_file(file_path):
                processed_files.append(str(file_path))
                print(f"Processed: {file_path}")
    
    print(f"\nTotal files processed: {len(processed_files)}")
    for file_path in processed_files:
        print(f"  - {file_path}")

if __name__ == "__main__":
    main()
