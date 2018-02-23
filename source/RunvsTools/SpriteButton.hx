package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class SpriteButton extends FlxSprite
{
    private var _callback : Void->Void;

    public override function new(xPos : Float, yPos : Float, path : String, callback : Void->Void)
    {
        super(xPos, yPos);

        _callback = callback;
        
        loadGraphic(path, true, 16, 16);
        animation.add("normal",  [1], 1, false);
        animation.add("hover",   [0], 1, false);
        animation.add("clicked", [2], 1, false);
        animation.play("normal");
    }


    public override function update(elapsed: Float)
    {
        super.update(elapsed);

        var mousePosition : FlxPoint = FlxG.mouse.getScreenPosition();
        if(mousePosition.x >= x && mousePosition.x < x + width
        && mousePosition.y >= y && mousePosition.y < y + height)
        {
            if(FlxG.mouse.pressed)
            {
                animation.play("clicked");
            }
            else
            {
                animation.play("hover");
            }

            if(FlxG.mouse.justReleased)
            {
                _callback();
            }
        }
        else
        {
            animation.play("normal");
        }
    }
}