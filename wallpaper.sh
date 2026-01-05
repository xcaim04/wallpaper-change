#!/bin/bash

# Carpeta con las imágenes
IMAGES_DIR="/home/xcaim04/Pictures/wallpaper"
INTERVAL=$((4*60))  # 30 minutos en segundos

# Obtiene todas las imágenes válidas
IMAGES=($(find "$IMAGES_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \)))

if [ ${#IMAGES[@]} -eq 0 ]; then
  echo "No se encontraron imágenes en $IMAGES_DIR"
  exit 1
fi

while true; do
  for IMG in "${IMAGES[@]}"; do
    # 1. Muestra la imagen con fade usando feh en overlay
    feh --bg-scale "$IMG"

    # 2. Aplica el fondo real con gsettings (GNOME)
    gsettings set org.gnome.desktop.background picture-uri "file://$IMG"

    # Espera el intervalo antes de cambiar
    sleep $INTERVAL
  done
done
