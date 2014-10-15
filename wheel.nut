/**
 * A Wheel is an image representing a game (usually the logo) which is scrolled
 * when changing game.
 */
class Wheel {

    imageObject = null;
    textObject = null;

    x = 0;
    y = 0;
    gameOffset = 0;

    /**
     * startGameOffset: Which games it should show, 0 is the active game while 1 is the next game.
     * startX: X position of the wheel
     * startY: Y position of the wheel
     */
    constructor(startGameOffset, startX, startY)
    {
        local config = fe.get_config();

        gameOffset = startGameOffset;
        x = startX;
        y = startY;

        // Setup image object
        imageObject = fe.add_artwork(config["wheel_artwork_type"]);
        imageObject.preserve_aspect_ratio = true;
        imageObject.video_flags = Vid.ImagesOnly;
        imageObject.index_offset = gameOffset;

        // Setup text object
        textObject = fe.add_text(fe.game_info(Info.Title, gameOffset), x, y, 256, 256);
        textObject.charsize = 32;
        textObject.word_wrap = true;

        update();
    }

    function update() {
        imageObject.x = x;
        imageObject.y = y;
        textObject.x = x;
        textObject.y = y;

        imageObject.alpha = (gameOffset == 0) ? 255 : 100;
        textObject.alpha = (gameOffset == 0) ? 255 : 100;

        textObject.msg = fe.game_info(Info.Title, gameOffset);

        local file = File();
        local config = fe.get_config();
        local imageExists = file.exists(config["wheel_artwork_path"] + "\\" + fe.game_info(Info.Name, gameOffset) + ".png");
        imageObject.visible = imageExists;
        textObject.visible = !imageExists;
    }
}
