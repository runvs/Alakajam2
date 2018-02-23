package ;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class InputKeyboard1 extends BasicInput
{
	
	public function new() 
	{
        name = "wasd + Shift";
    }	
	
	public override function update(elapsed : Float ) : Void
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.A)
		{
			xVal = -1;
			LeftJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.pressed.D)
		{
			xVal = 1;
			RightJustPressed = true;
			anyPressed = true;
		}
		
		if (FlxG.keys.pressed.W)
		{
			yVal = -1;
			UpJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.pressed.S)
		{
			yVal = 1;
			DownJustPressed = true;
			anyPressed = true;
		}
		
	
		if (FlxG.keys.justPressed.SHIFT)
		{
			ShootJustPressed  = true;
			anyPressed = true;
		}
		if (FlxG.keys.justReleased.SHIFT)
		{
			ShootJustReleased = true;
		}
	}
}
