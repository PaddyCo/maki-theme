/* Contains all the config options that are shown in Attract-Mode for the layout */
class UserConfig {
    </ label="Wheel Artwork Type", help="The artwork the slider uses, Default: wheel" />
    wheel_artwork_type="wheel";

    // TODO: Actually get this from the config instead of having to configure it
    </ label="Wheel Artwork Path", help="The path to the artwork" />
    wheel_artwork_path=@"D:\Games\Mame\wheels";
}

// Include classes
fe.do_nut("file.nut");
fe.do_nut("wheel.nut");

local file = File();

local wheels = [
        Wheel(-1, 0, 100),
        Wheel(0, 500, 100),
        Wheel(1, 1000, 100)
    ];

fe.add_transition_callback("transition");

function transition(ttype, var, ttime) {
    foreach (wheel in wheels) {
        wheel.update();
    }
}
