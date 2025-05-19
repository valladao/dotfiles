#!/usr/bin/env bash

# Selecionar um wallpaper aleatório
NEW_WP=$(ls "$HOME/.config/backgrounds" | shuf -n 1)

# Caminho completo do wallpaper
WALLPAPER="$HOME/.config/backgrounds/$NEW_WP"

# Caminho do arquivo de configuração
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Limpar o arquivo de configuração do hyprpaper
echo "" > "$HYPRPAPER_CONF"
echo "preload = $WALLPAPER" >> "$HYPRPAPER_CONF"

# Pegar todos os monitores conectados
DISPLAYS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Aplicar o wallpaper em todos
for DISPLAY in $DISPLAYS; do
  echo "wallpaper = $DISPLAY,$WALLPAPER" >> "$HYPRPAPER_CONF"
done

# Desativa splash
echo "splash = false" >> "$HYPRPAPER_CONF"

# Reinicia o Hyprpaper
killall hyprpaper 2>/dev/null
hyprpaper &

