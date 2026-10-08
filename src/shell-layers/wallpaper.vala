using GLib;
using Gtk;
using GtkLayerShell;

public class Wallpaper : ApplicationWindow {
    private static Wallpaper? instance;
    public static Wallpaper Instance {
        get {
            if (instance == null) {
                instance = new Wallpaper();
            }
            return instance;
        }
    }

    private Picture Background = new Picture();

    public Wallpaper() {
        Object(application: ModernShell.Instance);
        
        GtkLayerShell.init_for_window(this);
        GtkLayerShell.set_layer(this, GtkLayerShell.Layer.BACKGROUND);
        GtkLayerShell.set_namespace(this, "wallpaper");
        GtkLayerShell.set_exclusive_zone(this, -1);

        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.TOP, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.BOTTOM, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.LEFT, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.RIGHT, true);

        Background.set_filename(Environment.get_home_dir() + "/Pictures/Wallpaper.png");
        Background.set_content_fit(Gtk.ContentFit.FILL);

        this.set_child(Background);
    }

    public void ChangeWallpaper(string imagePath) {
        Background.set_filename(imagePath);
    }
}