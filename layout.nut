/* Contains all the config options that are shown in Attract-Mode for the layout */
class UserConfig {
    </ label="Wheel Artwork Type", help="The artwork the slider uses, Default: wheel" />
    wheel_artwork_type="wheel";

    </ label="Background Artwork Type", help="The artwork to show in the background, Default: movie" />
    background_artwork_type="movie";

    </ label="Background Artwork Keep Aspect Ratio", help="Specify if background artwork should keep aspect ratio, Default: Yes"
    options="Yes,No" />
    background_artwork_aspect_ratio="Yes";

    // TODO: Actually get this from the config instead of having to configure it
    </ label="Wheel Artwork Path", help="The path to the artwork" />
    wheel_artwork_path=@"D:\Games\Mame\wheels";
}

local config = fe.get_config();

// Include classes
fe.do_nut("file.nut");
fe.do_nut("wheel.nut");

local file = File();

local background = fe.add_artwork(config["background_artwork_type"], 0, 0, fe.layout.width, fe.layout.height);
background.preserve_aspect_ratio = (config["background_artwork_aspect_ratio"] == "Yes") ? true : false;

local wheelY = (fe.layout.height / 2);
local wheels = [
        Wheel(-2, wheelY),
        Wheel(-1, wheelY),
        Wheel(0, wheelY),
        Wheel(1, wheelY),
        Wheel(2, wheelY)
    ];

fe.add_transition_callback("transition");

function transition(ttype, var, ttime) {
    if (ttype == Transition.ToNewSelection) {
        foreach (wheel in wheels) {
            wheel.scroll(-var);
        }
    }
}

fe.add_ticks_callback("tick");

function tick(ttime) {
    foreach (wheel in wheels) {
        wheel.update();
    }
}
