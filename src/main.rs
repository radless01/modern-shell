use gtk4::prelude::*;

mod layers;
use layers::wallpaper::Wallpaper;
use layers::desktop::Desktop;
use layers::taskbar::Taskbar;
use layers::taskbar::TaskbarLocation;

fn main() {
    let modern_shell = 
        gtk4::Application::builder()
        .application_id("com.radless.modern-shell")
        .flags(gtk4::gio::ApplicationFlags::HANDLES_COMMAND_LINE)
        .build();

    modern_shell.connect_command_line(|modern_shell, _cmd_line| {
        modern_shell.activate();
        gtk4::glib::ExitCode::SUCCESS
    });

    modern_shell.connect_activate(|modern_shell: &gtk4::Application| {
        let mut wallpaper = Wallpaper::new(&modern_shell);
        let mut desktop = Desktop::new(&modern_shell);
        let mut taskbar = Taskbar::new(&modern_shell, TaskbarLocation::TaskbarBottom);

        wallpaper.show();
        desktop.show();
        taskbar.show();
    });

    modern_shell.run();
}