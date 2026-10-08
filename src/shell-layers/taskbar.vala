using GLib;
using Gtk;
using GtkLayerShell;

public class Taskbar : ApplicationWindow {
    private static Taskbar? instance;
    public static Taskbar Instance {
        get {
            if (instance == null) {
                instance = new Taskbar();
            }
            return instance;
        }
    }

    public Taskbar() {
        Object(application: ModernShell.Instance);
        
        GtkLayerShell.init_for_window(this);
        GtkLayerShell.set_layer(this, GtkLayerShell.Layer.TOP);
        GtkLayerShell.set_namespace(this, "taskbar");
        GtkLayerShell.auto_exclusive_zone_enable (this);

        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.LEFT, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.RIGHT, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.BOTTOM, true);

        var webView = (WebKit.WebView) Object.new(
            typeof (WebKit.WebView),
            "web-context", SharedContext
        );
        Gdk.RGBA transparentBG = Gdk.RGBA() {red = 0.0f, green = 0.0f, blue = 0.0f, alpha = 0.0f};
        webView.set_background_color(transparentBG);
        webView.load_uri("file://" + GLib.Environment.get_home_dir() + "/.config/modern-shell/" + 
                                  "taskbar.html");

        this.realize();
        var surface = this.get_surface ();
        var monitor = surface.get_display ().get_monitor_at_surface (surface);
        var geometry = monitor.get_geometry ();

        int width = (int) (geometry.width * 0.05);
        int height = (int) (geometry.height * 1.0);

        // this.set_default_size (width, height);
        this.set_size_request(45, -1);
        this.set_child(webView);
    }
}