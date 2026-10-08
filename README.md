# modern-shell
A complete Shell, which is GTK4 based and Wayfire targeted, written in Vala programming language.
## Dependencies
### Arch Linux
```bash
sudo pacman -S --needed \
gtk4
gtk4-layer-shell \
webkitgtk-6.0 \
glib2 \
json-glib
```
## Build & Install
```bash
meson setup build --prefix=/usr --buildtype=release
meson compile -C build
sudo meson install -C build
```
