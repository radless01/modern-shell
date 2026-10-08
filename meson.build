project('ModernShell', 'vala', version: '1.0.0')

deps = [
    dependency('gtk4'), # gtk4
    dependency('gtk4-layer-shell-0'), # gtk4-layer-shell
    dependency('webkitgtk-6.0'), # webkitgtk-6.0
    dependency('glib-2.0'), # glib2
    dependency('json-glib-1.0') # json-glib
]

sources = files(
    'src/main.vala',
    'src/config-manager.vala',
    'src/shell-layers/wallpaper.vala',
    'src/shell-layers/desktop.vala',
    'src/shell-layers/taskbar.vala'
)

executable(
    'modern-shell',
    dependencies: deps,
    sources: sources,
    
    install: true,
    install_dir: get_option('bindir')
)

install_data(
    'config.json',
    install_dir: get_option('sysconfdir') / 'modern-shell'
)