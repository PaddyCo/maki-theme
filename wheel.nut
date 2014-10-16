/**
 * A Wheel is an image representing a game (usually the logo) which is scrolled
 * when changing game.
 */
class Wheel {

    imageObject = null;
    textObject = null;

    x = 0;
    y = 0;
    baseY = 0;
    gameOffset = 0;

    width = null;
    margin = null;

    targetX = null;
    targetY = null;

    /**
     * Params:
     *          startGameOffset: (int) Which games it should show, 0 is the active game while 1 is the next game.
     *          startY: (int) Y position of the wheel
     */
    constructor(startGameOffset, startY)
    {
        local config = fe.get_config();

        width = fe.layout.width/4;
        margin = fe.layout.width/10;

        gameOffset = startGameOffset;
        y = startY - (width/4);
        x = calculateX();

        // Setup image object
        imageObject = fe.add_artwork(config["wheel_artwork_type"]);
        imageObject.preserve_aspect_ratio = true;
        imageObject.video_flags = Vid.ImagesOnly;
        imageObject.index_offset = gameOffset;
        imageObject.width = width;

        // Setup text object
        textObject = fe.add_text(fe.game_info(Info.Title, gameOffset), x-128, y, 256, 256);
        textObject.charsize = 32;

        updateGame();
    }

    function calculateX() {
        return (((fe.layout.width/2) - width/2) + (gameOffset * (width+margin))).tointeger();
    }

    /**
     * Animates the Wheel to specified position.
     * Params:
     *          xPosition: (int) The X position to animate to, `null` to not animate
     *          yPosition: (int) The Y position to animate to, `null` to not animate
     */
    function moveTo(xPosition, yPosition) {
        if (targetX != null) {
            x = targetX;
        }
        if (targetY != null) {
            y = targetY;
        }

        targetX = xPosition;
        targetY = yPosition;
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

            if (animate == true) {
                moveTo(calculateX(), null);
            } else {
                x = calculateX();
                targetX = null;
            }
        } else {
            x = calculateX();
            targetX = null;
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

        local speed = 40;

        if (targetX != null) {
            local direction = (targetX > x) ? 1 : -1;

            if ((direction == 1 && (x + speed) > targetX) || (direction == -1 && (x - speed) < targetX)) {
                x = targetX;
            } else {
                x += speed * direction;
            }

            if (targetX == x) {
                targetX = null;
            }
        } else if (targetY != null) {
            y += 1
        }

        imageObject.x = x.tointeger();
        imageObject.y = y.tointeger();
        textObject.x = x.tointeger();
        textObject.y = y.tointeger();
    }
}
