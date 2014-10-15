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
        Wheel(-2, -500, 100),
        Wheel(-1, 0, 100),
        Wheel(0, 500, 100),
        Wheel(1, 1000, 100),
        Wheel(2, 1500, 100)
    ];

fe.add_transition_callback("transition");

function transition(ttype, var, ttime) {
    if (ttype == Transition.ToNewSelection) {
        print("//////\n");
        foreach (wheel in wheels) {
            if (var == 1) {
                wheel.next();
            } else if (var == -1) {
                wheel.previous();
            }
            print(wheel.gameOffset + "\n");
        }
        print("//////\n");
    }
}

fe.add_ticks_callback("tick");

function tick(ttime) {
    foreach (wheel in wheels) {
        wheel.update();
    }
}
