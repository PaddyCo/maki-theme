class KeyValue {

    keyObject = null;
    valueObject = null;
    width = null;
    height = null;
    y = 0;
    x = 0;

    constructor(keyString, valueString, totalWidth, totalHeight) {
        width = totalWidth;
        height = totalHeight;

        keyObject = fe.add_text(keyString, x, y, width*0.25, height);
        keyObject.font = "OpenSans-Bold.ttf";
        keyObject.style = Style.Bold;
        keyObject.align = Align.Left;

        valueObject = fe.add_text(valueString, x+(width*0.25), y, width*0.75, height);
        valueObject.font = "OpenSans-Regular.ttf";
        valueObject.align = Align.Left;
    }

    function update() {
        keyObject.x = x;
        keyObject.y = y;
        valueObject.x = x+(width*0.25);
        valueObject.y = y;
    }

}
