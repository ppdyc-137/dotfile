#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path
from configparser import ConfigParser



def get_config_home() -> Path:
    """Returns the XDG config directory or defaults to ~/.config"""
    xdg_config_home = os.environ.get('XDG_CONFIG_HOME')
    if xdg_config_home:
        return Path(xdg_config_home)
    return Path.home() / '.config'


def get_current_theme() -> str:
    """Get current theme from gsettings"""
    try:
        result = subprocess.run([
            "gsettings", "get", "org.gnome.desktop.interface", "gtk-theme"
        ], capture_output=True, text=True, check=True)

        # gsettings returns quoted strings, so strip quotes
        current_theme = result.stdout.strip().strip("'\"")

        return current_theme
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(f"Warning: Could not get theme from gsettings: {e}")
        exit(1)


def apply_gsettings(theme_name: str) -> None:
    """Apply GTK theme settings via gsettings"""
    try:
        subprocess.run([
            "gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", theme_name
        ], check=True, capture_output=True, text=True)
    except subprocess.CalledProcessError as e:
        print(f"Warning: gsettings failed: {e}")
    except FileNotFoundError:
        print("Warning: gsettings command not found")


def update_gtk_theme_in_ini(config_file: Path, theme_name: str) -> None:
    """Update only the gtk-theme-name in an INI file while preserving other settings"""
    config = ConfigParser()
    config.optionxform = str  # Preserve case of option names

    # Read existing file if it exists
    if config_file.exists():
        try:
            config.read(config_file)
        except Exception as e:
            print(f"Warning: Failed to load INI file {config_file}: {e}")

    # Ensure [Settings] section exists
    if not config.has_section('Settings'):
        config.add_section('Settings')

    # Update gtk-theme-name
    config.set('Settings', 'gtk-theme-name', theme_name)

    # Create directory if it doesn't exist
    config_file.parent.mkdir(parents=True, exist_ok=True)

    # Save the file
    try:
        with open(config_file, 'w') as f:
            config.write(f, space_around_delimiters=False)
    except Exception as e:
        print(f"Error: Failed to save INI file {config_file}: {e}")


def apply_theme(theme_name: str) -> None:
    """Apply theme to gsettings and INI files"""
    print(f"Applying theme: {theme_name}")

    # Apply via gsettings
    apply_gsettings(theme_name)

    # Update GTK 3.0 config
    gtk3_config = get_config_home() / 'gtk-3.0' / 'settings.ini'
    update_gtk_theme_in_ini(gtk3_config, theme_name)

    # Update GTK 4.0 config
    gtk4_config = get_config_home() / 'gtk-4.0' / 'settings.ini'
    update_gtk_theme_in_ini(gtk4_config, theme_name)


def main():
    themes = [
        "Adwaita",
        "Adwaita-dark",
    ]
    current = get_current_theme()
    if current in themes:
        current_index = themes.index(current)
        next_index = (current_index + 1) % len(themes)
    else:
        next_index = 0
    next_theme =  themes[next_index]

    print(f"Switching: {current} -> {next_theme}")
    apply_theme(next_theme)

if __name__ == "__main__":
    main()

