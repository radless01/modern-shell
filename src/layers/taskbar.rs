use gtk4::prelude::*;

use crate::layers::taskbar::TaskbarLocation::{TaskbarBottom, TaskbarLeft};

pub enum TaskbarLocation {
    TaskbarBottom,
    TaskbarRight,
    TaskbarLeft,
    TaskbarUp
}

pub struct Taskbar {
    window: gtk4::ApplicationWindow,
}

impl Taskbar {
    pub fn new(app: &gtk4::Application, taskbar_location: TaskbarLocation) -> Self {
        let window = gtk4::ApplicationWindow::new(app);

        gtk4_layer_shell::LayerShell::init_layer_shell(&window);
        gtk4_layer_shell::LayerShell::set_namespace(&window, Some("taskbar"));
        gtk4_layer_shell::LayerShell::set_layer(&window, gtk4_layer_shell::Layer::Top);

        gtk4_layer_shell::LayerShell::set_exclusive_zone(&window, -1);

        match taskbar_location {
            TaskbarLocation::TaskbarBottom => {
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Bottom, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Left, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Right, true);
            }
            TaskbarLocation::TaskbarRight => {
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Top, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Bottom, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Right, true);
            }
            TaskbarLocation::TaskbarLeft => {
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Top, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Bottom, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Left, true);
            }
            TaskbarLocation::TaskbarUp => {
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Top, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Left, true);
                gtk4_layer_shell::LayerShell::set_anchor(&window, gtk4_layer_shell::Edge::Right, true);
            }
        }

        Self { window }
    }

    pub fn window(&self) -> &gtk4::ApplicationWindow {
        &self.window
    }

    pub fn focus(&self) {
        self.window.present();
    }

    pub fn show(&self) {
        self.window.set_visible(true);
    }

    pub fn hide(&self) {
        self.window.set_visible(false);
    }
}