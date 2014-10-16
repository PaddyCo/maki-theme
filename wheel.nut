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

    targetX = null;
    targetY = null;

    /**
     * Params:
     *          startGameOffset: (int) Which games it should show, 0 is the active game while 1 is the next game.
     *          startX: (int) X position of the wheel
     *          startY: (int) Y position of the wheel
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
        textObject = fe.add_text(fe.game_info(Info.Title, gameOffset), x-128, y, 256, 256);
        textObject.charsize = 32;

        updateGame();
    }

    /**
     * Animates the Wheel to specified position.
     * Params:
     *          x: (int) The X position to animate to, `null` to not animate
     *          y: (int) The Y position to animate to, `null` to not animate
     */
    function moveTo(x, y) {
        targetX = x;
        targetY = y;
    }

    /**
     * Scrolls the Wheel the specified amount.
     * Params:
     *          var: (int) Which way to scroll and how much
     */
    function scroll(var) {
        local amount = abs(var);
        local direction = (var > 0) ? 1 : -1;
        local animate = true;

        if (amount == 1) {
            gameOffset += direction;

            if (abs(gameOffset) > 2) {
                gameOffset = (gameOffset > 0) ? -2 : 2;
                animate = false;
            }

            local targetX = 500 + (gameOffset * 500);

            if (animate) {
                moveTo(targetX, null);
            } else {
                x = targetX;
            }
        }

        updateGame();
    }

    /**
     * Updates the game the wheel is showing
     */
    function updateGame() {
        imageObject.alpha = (gameOffset == 0) ? 255 : 100;
        textObject.alpha = (gameOffset == 0) ? 255 : 100;

        textObject.msg = fe.game_info(Info.Title, gameOffset-1);
        imageObject.index_offset = gameOffset;

        local file = File();
        local config = fe.get_config();
        local imageExists = file.exists(config["wheel_artwork_path"] + "\\" + fe.game_info(Info.Name, gameOffset) + ".png");
        //textObject.visible = !imageExists;
        textObject.visible = false;
    }

    /**
     * This runs every tick, updates position etc.
     */
    function update() {

        if (targetX != null) {
            x += (targetX > x) ? 50 : -50;
            if (targetX == x) {
                targetX = null;
            }
        } else if (targetY != null) {
            y += 1
        }

        imageObject.x = x;
        imageObject.y = y;
        textObject.x = x;
        textObject.y = y;
    }
}
