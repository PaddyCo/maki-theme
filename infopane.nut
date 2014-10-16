class InfoPane {

    background = null;
    titleText = null;
    developerText = null;

    y = null;

    isOpen = false;
    keyJustPressed = true;

    headerHeight = 64;
    padding = 10;

    constructor() {
        y = fe.layout.height - headerHeight;

        background = fe.add_text("", 0, y, fe.layout.width, fe.layout.height);
        background.set_bg_rgb(0,0,0);
        background.bg_alpha = 128;

        titleText = fe.add_text("[Title]", (-11)+padding, y+padding, fe.layout.width, headerHeight/3);
        titleText.font = "OpenSans-Bold.ttf";
        titleText.style = Style.Bold;
        titleText.align = Align.Left;

        developerText = fe.add_text("© [Year] [Manufacturer]", (-20+8)+padding, (y+headerHeight)-padding-(headerHeight/3), fe.layout.width, headerHeight/3);
        developerText.set_rgb(146,214,252);
        developerText.font = "OpenSans-Regular.ttf";
        developerText.align = Align.Left;
    }

    function open() {
        y = 0;
        isOpen = true;
    }

    function close() {
        y = fe.layout.height - headerHeight;
        isOpen = false;
    }

    function update() {
        local config = fe.get_config();

        if (fe.get_input_state(config["toggle_info_key"])) {
            if (keyJustPressed) {
                if (isOpen) {
                    close();
                } else {
                    open();
                }
            }

            keyJustPressed = false;
        } else {
            keyJustPressed = true;
        }

        background.y = y;
        titleText.y = y+padding;
        developerText.y = (y+headerHeight)-padding-(headerHeight/3);
    }
}
