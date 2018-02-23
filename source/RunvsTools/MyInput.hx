package;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * ...
 * @author 
 */
class MyInput
{

	public static var xVal : Float = 0;
	public static var yVal : Float = 0;
	
	public static var DashButtonJustPressed      : Bool;
	public static var JumpButtonJustPressed      : Bool;
	public static var InteractButtonPressed      : Bool;
	public static var InteractButtonJustPressed  : Bool;
	public static var SpecialButtonPressed       : Bool;
	public static var InventoryButtonJustPressed : Bool;

	public static var UpButtonJustPressed        : Bool;
	public static var DownButtonJustPressed      : Bool;
	
	public static var EnterButtonJustPressed     : Bool;
	public static var SpaceButtonJustPressed     : Bool;
	
	public static var GamePadConnected 			 : Bool;

	public static function reset()
	{
		xVal = 0;
		yVal = 0;

		DashButtonJustPressed      = false;
		JumpButtonJustPressed      = false;
		InteractButtonPressed      = false;
		InteractButtonJustPressed  = false;
		InventoryButtonJustPressed = false;
		GamePadConnected           = false;
		UpButtonJustPressed        = false;
		DownButtonJustPressed      = false;
		EnterButtonJustPressed     = false;
		SpaceButtonJustPressed     = false;
	}
	
	public static function update ()
	{
		reset();
		
		var gp : FlxGamepad = FlxG.gamepads.firstActive;
		if (gp != null)
		{
			GamePadConnected = true;
			xVal = gp.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK);
			yVal = gp.getYAxis(FlxGamepadInputID.LEFT_ANALOG_STICK);
			DashButtonJustPressed = gp.justPressed.X;
			JumpButtonJustPressed = gp.justPressed.B;
			InteractButtonPressed = gp.pressed.A;
			InteractButtonJustPressed = gp.justPressed.A;
			SpecialButtonPressed = gp.pressed.B;
			InventoryButtonJustPressed = gp.justPressed.Y;
			EnterButtonJustPressed = gp.justPressed.START;
			SpaceButtonJustPressed = gp.justPressed.START;

			var l : Float = Math.sqrt(xVal * xVal + yVal * yVal);
			if(l >= 25)
			{
				UpButtonJustPressed = yVal > 0;
				DownButtonJustPressed = yVal < 0;
			}
		}
		
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT)
		{
			xVal = 1;
		}
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)
		{
			xVal = -1;
		}
		if(FlxG.keys.pressed.W || FlxG.keys.pressed.UP)
		{
			yVal = -1;
		}
		if(FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)
		{
			yVal = 1;
		}
		
		if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP)
		{
			UpButtonJustPressed = true;
		}
		if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.DOWN)
		{
			DownButtonJustPressed = true;
		}
		if (FlxG.keys.justPressed.C)
		{
			DashButtonJustPressed = true;
		}
		if (FlxG.keys.justPressed.X)
		{
			JumpButtonJustPressed= true;
		}
		if (FlxG.keys.pressed.X)
		{
			InteractButtonPressed = true;
		}
		if (FlxG.keys.justPressed.X)
		{
			InteractButtonJustPressed = true;
		}
		if(FlxG.keys.justPressed.F)
		{
			InventoryButtonJustPressed = true;
		}
		if(FlxG.keys.justPressed.ENTER)
		{
			EnterButtonJustPressed = true;
		}
		if(FlxG.keys.justPressed.SPACE)
		{
			SpaceButtonJustPressed = true;
		}
	}
}