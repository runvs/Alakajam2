package ;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class InputKeyboard2 extends BasicInput
{
	
	public function new() 
	{
        name = "arrows + K";		
	}
	
		public override function update(elapsed : Float ) : Void
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.LEFT)
		{
			xVal = -1;
			LeftJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			xVal = 1;
			RightJustPressed = true;
			anyPressed = true;
		}
		
		if (FlxG.keys.pressed.UP)
		{
			yVal = -1;
			UpJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			yVal = 1;
			DownJustPressed = true;
			anyPressed = true;
		}
		
	
		if (FlxG.keys.justPressed.K)
		{
			trace("K");
			ShootJustPressed  = true;
			anyPressed = true;
		}
		if (FlxG.keys.justReleased.K)
		{
			ShootJustReleased = true;
		}
	}
	
}
