using GLib;
using Gtk;
using GtkLayerShell;

public class Desktop : ApplicationWindow {
    private static Desktop? instance;
    public static Desktop Instance {
        get {
            if (instance == null) {
                instance = new Desktop();
            }
            return instance;
        }
    }

    public Desktop() {
        Object(application: ModernShell.Instance);

        GtkLayerShell.init_for_window(this);
        GtkLayerShell.set_layer(this, GtkLayerShell.Layer.BOTTOM);
        GtkLayerShell.set_namespace(this, "desktop");
        GtkLayerShell.set_exclusive_zone(this, -1);

        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.TOP, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.BOTTOM, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.LEFT, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.RIGHT, true);

        var webView = (WebKit.WebView) Object.new(
            typeof (WebKit.WebView),
            "web-context", SharedContext
        );
        Gdk.RGBA transparentBG = Gdk.RGBA() {red = 0.0f, green = 0.0f, blue = 0.0f, alpha = 0.0f};
        webView.set_background_color(transparentBG);
        webView.load_uri("file://" + GLib.Environment.get_home_dir() + "/.config/modern-shell/" + 
                                  "desktop.html");

        this.set_child(webView);
    }
}