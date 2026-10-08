using GLib;
using Json;

public class ConfigManager : GLib.Object {
    private static ConfigManager? instance;
    public static ConfigManager Instance {
        get {
            if (instance == null) {
                instance = new ConfigManager();
            }
            return instance;
        }
    }
    private int64 lastUpdateTime = 0;

    public signal void onConfigChanged();

    public string? wallpaperPath { get; private set; }
    public Json.Array? pinnedApps { get; private set; }

    private ConfigManager() {
        loadConfig();
        
        Timeout.add_seconds(1, () => {
            var file = File.new_for_path(GLib.Environment.get_user_config_dir() + "/example-shell/config.json");
            try {
                var info = file.query_info("time::modified", FileQueryInfoFlags.NONE);
                var mtime = info.get_modification_time().tv_sec;

                if (this.lastUpdateTime != 0 && mtime != this.lastUpdateTime) {
                    loadConfig();
                }
                this.lastUpdateTime = mtime;
            } catch (Error e) {
            }
            return true;
        });
    }

    public void loadConfig() {
        var file = File.new_for_path(GLib.Environment.get_user_config_dir() + "/example-shell/config.json");
        if (!file.query_exists()) return;

        var parser = new Json.Parser();
        try {
            parser.load_from_file(file.get_path());
            var root = parser.get_root().get_object();
            
            this.wallpaperPath = root.get_string_member("wallpaper");
            this.pinnedApps = root.get_array_member("pinnedApps");
            
            onConfigChanged();
        } catch (Error e) {
        }
    }
}