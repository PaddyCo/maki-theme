fe.do_nut("keyvalue.nut");
fe.do_nut("label.nut");

class InfoPane {

    background = null;
    titleText = null;
    developerText = null;

    playLabel = null;
    playKeyValues = null;

    infoLabel = null;
    infoKeyValues = null;
    infoImage = null;

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

        playLabel = Label("STATISTICS", titleText.x, y+headerHeight+padding, fe.layout.width/2, headerHeight/3, true);
        playKeyValues = [
            KeyValue("Times started", "[PlayedCount]", fe.layout.width/2, headerHeight/3),
            KeyValue("Time played", "[PlayedTime]", fe.layout.width/2, headerHeight/3)
        ];

        infoLabel = Label("INFORMATION", titleText.x, playLabel.y+padding, fe.layout.width/2, headerHeight/3, true);
        infoKeyValues = [
            KeyValue("Players", "[Players]", fe.layout.width/2, headerHeight/3),
            KeyValue("Genre", "[Category]", fe.layout.width/2, headerHeight/3),
            KeyValue("Controls", "[Control]", fe.layout.width/2, headerHeight/3)
        ];

        local config = fe.get_config();

        infoImage = fe.add_artwork(config["info_artwork_type"], fe.layout.width/2 + padding, (y + headerHeight) + padding,
        fe.layout.width/2 - (padding*2), fe.layout.height - (padding*2) - headerHeight);
        infoImage.preserve_aspect_ratio = true;
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

        // Update Play section
        playLabel.y = y+headerHeight+padding;
        playLabel.update();

        local index = 0;
        foreach (keyValue in playKeyValues) {
            index += 1;
            keyValue.y = playLabel.y + (keyValue.height*index) + padding
            keyValue.update();
        }

        // Update Information Section
        infoLabel.y = playKeyValues[playKeyValues.len()-1].y+playKeyValues[playKeyValues.len()-1].height+padding;
        infoLabel.update();

        index = 0;
        foreach (keyValue in infoKeyValues) {
            index += 1;
            keyValue.y = infoLabel.y + (keyValue.height*index) + padding
            keyValue.update();
        }

        infoImage.y = (y + headerHeight) + padding;
    }
}
