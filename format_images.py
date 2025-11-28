#!/usr/bin/env python3
"""
Script to format images in portfolio.md to display 2-3 per row with controlled size
"""
import re

def format_images_in_markdown(md_file_path):
    """Format images to display 2-3 per row with controlled size"""
    with open(md_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match markdown image syntax: ![alt](data:...)
    pattern = r'!\[([^\]]*)\]\((data:image/[^)]+)\)'
    
    def replace_images_section(match):
        section_start = match.start()
        section_end = match.end()
        
        # Find the end of this images section (next ## or ---)
        remaining = content[section_end:]
        next_section = re.search(r'\n---|\n## ', remaining)
        if next_section:
            section_text = content[section_start:section_end + next_section.start()]
        else:
            section_text = content[section_start:]
        
        # Find all images in this section
        images = re.findall(pattern, section_text)
        
        if not images:
            return match.group(0)
        
        # Group images into rows of 2-3
        html_output = '<div style="display: flex; flex-wrap: wrap; gap: 10px; margin: 20px 0;">\n'
        
        for i, (alt_text, data_uri) in enumerate(images):
            # Determine width: 3 per row (33%), but if last 1-2 images, make them larger
            if len(images) % 3 == 1 and i == len(images) - 1:
                # Last single image: make it 48% (2 per row equivalent)
                width = '48%'
            elif len(images) % 3 == 2 and i >= len(images) - 2:
                # Last two images: make them 48% each
                width = '48%'
            else:
                # Normal: 3 per row
                width = '32%'
            
            html_output += f'  <img src="{data_uri}" alt="{alt_text}" style="width: {width}; max-width: 400px; height: auto; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />\n'
        
        html_output += '</div>\n'
        
        # Replace the entire images section
        return html_output
    
    # Find all "**Project Images**" sections and replace them
    project_images_pattern = r'\*\*Project Images\*\*\s*\n\n(?:!\[[^\]]*\]\(data:image/[^)]+\)\s*\n?)+'
    
    def process_images_section(match):
        section = match.group(0)
        # Extract all images from this section
        images = re.findall(pattern, section)
        
        if not images:
            return match.group(0)
        
        # Create HTML layout
        html_output = '**Project Images**\n\n<div style="display: flex; flex-wrap: wrap; gap: 10px; margin: 20px 0;">\n'
        
        for i, (alt_text, data_uri) in enumerate(images):
            # Determine width based on total images and position
            total = len(images)
            remainder = total % 3
            
            if remainder == 1 and i == total - 1:
                # Last single image: make it wider
                width = '48%'
            elif remainder == 2 and i >= total - 2:
                # Last two images: 48% each
                width = '48%'
            else:
                # Normal: 3 per row (32% each with gap)
                width = '32%'
            
            html_output += f'  <img src="{data_uri}" alt="{alt_text}" style="width: {width}; max-width: 400px; min-width: 200px; height: auto; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); object-fit: contain;" />\n'
        
        html_output += '</div>\n'
        
        return html_output
    
    # Replace all project images sections
    new_content = re.sub(project_images_pattern, process_images_section, content, flags=re.MULTILINE)
    
    # Write back to file
    with open(md_file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"Done! Formatted images in {md_file_path}")

if __name__ == '__main__':
    md_file = '/Users/chenzilang/zilangchen.github.io/zilangchen.github.io/Materials/portfolio.md'
    format_images_in_markdown(md_file)




