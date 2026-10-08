using WebKit;
using Gtk;
using GtkLayerShell;

public static WebKit.WebContext? SharedContext;

public class ModernShell : Gtk.Application {
    private static ModernShell? instance;
    public static ModernShell Instance {
        get {
            if (instance == null) {
                instance = new ModernShell();
            }
            return instance;
        }
    }

    public ModernShell() {
        Object(
            application_id: "com.radless01.ModernShell", 
            flags: GLib.ApplicationFlags.DEFAULT_FLAGS | GLib.ApplicationFlags.HANDLES_COMMAND_LINE
        );
    }

    protected override void activate() {
        var cssProvider = new CssProvider();
        cssProvider.load_from_string("window, window.background { background: unset; background-color: transparent; }");
        
        StyleContext.add_provider_for_display(
            Gdk.Display.get_default(), 
            cssProvider, 
            STYLE_PROVIDER_PRIORITY_USER // STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        SharedContext = new WebKit.WebContext();

        Wallpaper.Instance.present();
        Desktop.Instance.present();
        Taskbar.Instance.present();

        ConfigManager.Instance.onConfigChanged.connect(() => {

        });
    }

    protected override int command_line(GLib.ApplicationCommandLine command_line) {
        string[] args = command_line.get_arguments ();

        if (args.length > 1) {
            string command = args[1];
            
            if (command == "brightness" && args.length > 2) {
                string level = args[2];
                message ("Took brightness change level command: %s", level);
            }
        }
        return 0;
    }
}

int main(string[] args) {
    return ModernShell.Instance.run(args);
}