#!/usr/bin/env python3
"""
Script to optimize image sizes and layout in portfolio.md
- Reduce image max-width
- Ensure 2-3 images per row
- Make images more compact
"""
import re

def optimize_images_in_markdown(md_file_path):
    """Optimize image sizes and layout"""
    with open(md_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match the div with images
    div_pattern = r'\*\*Project Images\*\*\s*\n\n<div style="display: flex; flex-wrap: wrap; gap: 10px; margin: 20px 0;">\n(.*?)</div>'
    
    def optimize_images_section(match):
        section = match.group(1)
        # Find all images in this section
        img_pattern = r'<img src="([^"]+)" alt="([^"]+)" style="([^"]+)" />'
        images = re.findall(img_pattern, section)
        
        if not images:
            return match.group(0)
        
        # Create optimized HTML layout
        html_output = '**Project Images**\n\n<div style="display: flex; flex-wrap: wrap; gap: 8px; margin: 15px 0; justify-content: flex-start;">\n'
        
        total = len(images)
        for i, (data_uri, alt_text, old_style) in enumerate(images):
            # Determine width: prefer 3 per row, but adjust for last images
            remainder = total % 3
            
            if remainder == 1 and i == total - 1:
                # Last single image: make it 48% (2 per row equivalent)
                width = '48%'
            elif remainder == 2 and i >= total - 2:
                # Last two images: 48% each
                width = '48%'
            else:
                # Normal: 3 per row (32% each with gap)
                width = '32%'
            
            # Optimized style: smaller max-width, better spacing
            new_style = f'width: {width}; max-width: 300px; min-width: 180px; height: auto; border-radius: 6px; box-shadow: 0 1px 4px rgba(0,0,0,0.08); object-fit: contain; margin: 0;'
            
            html_output += f'  <img src="{data_uri}" alt="{alt_text}" style="{new_style}" />\n'
        
        html_output += '</div>\n'
        
        return html_output
    
    # Replace all project images sections
    new_content = re.sub(div_pattern, optimize_images_section, content, flags=re.MULTILINE | re.DOTALL)
    
    # Write back to file
    with open(md_file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"Done! Optimized images in {md_file_path}")

if __name__ == '__main__':
    md_file = '/Users/chenzilang/zilangchen.github.io/zilangchen.github.io/Materials/portfolio.md'
    optimize_images_in_markdown(md_file)

