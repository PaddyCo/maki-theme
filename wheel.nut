/**
 * A Wheel is an image representing a game (usually the logo) which is scrolled
 * when changing game.
 */
class Wheel {

    object = null;

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

        object = fe.add_artwork(config["wheel_artwork_type"]);
        object.preserve_aspect_ratio = true;
        object.video_flags = Vid.ImagesOnly;
        object.index_offset = gameOffset;
        update();
    }

    function update() {
        object.x = x;
        object.y = y;
    }
}
