class Label {

    object = null;
    underlineObject = null;
    x = null;
    y = null;
    height = null;

    constructor(string, startX, startY, width, startHeight, underlined = false) {
        x = startX;
        y = startY;
        height = startHeight;

        object = fe.add_text(string, x, y, width, height);
        object.font = "OpenSans-Bold.ttf";
        object.style = Style.Bold;
        object.align = Align.Left;

        if (underlined) {
            underlineObject = fe.add_text("", x, y+height, width, 1);
            underlineObject.set_bg_rgb(255,255,255);
        }
    }

    function update() {
        object.x = x;
        object.y = y;

        if (underlineObject != null) {
            underlineObject.x = x+11;
            underlineObject.y = y+height;
        }
    }
}
