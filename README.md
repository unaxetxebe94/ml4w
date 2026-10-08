# ML4W (Omarchy)

Tema de Omarchy inspirado en ML4W (mylinuxforwork/dotfiles):

- Fondos de paisajes naturales tomados de los wallpapers de ML4W.
- Paleta derivada dinámicamente del fondo activo (`bin/derive-colors`).
- Decoración ML4W: blur (size 4 / passes 4 / xray), sombras, opacity 0.9 en
  ventanas inactivas y blur de la capa de la barra.
- Animaciones MD3 de ML4W (popin 60% para ventanas, slide para capas y
  workspaces).
- Launcher con la imagen del fondo (borrosa) gracias al marcador `menu-image`.
- Fuente FiraCode Nerd Font mientras el tema está activo (se revierte sola).

Componentes auxiliares (fuera de esta carpeta, inerte con otros temas):

- `~/.config/omarchy/hooks/theme-set.d/ml4w` -> `bin/on-theme-set`
- `~/.config/omarchy/hooks/post-boot.d/ml4w` -> `bin/on-theme-set`
- `~/.config/omarchy/plugins/<usuario>.menu` -> launcher con fondo
