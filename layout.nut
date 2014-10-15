/* Contains all the config options that are shown in Attract-Mode for the layout */
class UserConfig {
    </ label="Wheel Artwork Type", help="The artwork the slider uses, Default: wheel" />
    wheel_artwork_type="wheel";
}

// Include classes
fe.do_nut("file.nut");
fe.do_nut("wheel.nut");

local file = File();

local wheels = [
        Wheel(-1, 100, 100),
        Wheel(0, 200, 100),
        Wheel(1, 300, 100)
    ];

fe.add_transition_callback("transition");

function transition() {
    foreach (wheel in wheels) {
        wheel.update();
    }
}
