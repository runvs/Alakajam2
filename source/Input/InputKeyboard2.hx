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
		if (FlxG.keys.justPressed.LEFT)
		{
			xVal = -1;
			LeftJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.justPressed.RIGHT)
		{
			xVal = 1;
			RightJustPressed = true;
			anyPressed = true;
		}
		
		if (FlxG.keys.justPressed.UP)
		{
			yVal = -1;
			UpJustPressed = true;
			anyPressed = true;
		}
		if (FlxG.keys.justPressed.DOWN)
		{
			yVal = 1;
			trace("down");
			DownJustPressed = true;
			anyPressed = true;
		}
		
	
		if (FlxG.keys.justPressed.K)
		{
			ShootJustPressed  = true;
			anyPressed = true;
		}
		if (FlxG.keys.justReleased.K)
		{
			ShootJustReleased = true;
		}
	}
	
}
