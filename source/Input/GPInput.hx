package ;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * ...
 * @author 
 */
class GPInput extends BasicInput
{

	private var _gamepad : FlxGamepad = null;
	private var _id : Int = 0;
	public function new(ID : Int = 0) 
	{
		_gamepad = FlxG.gamepads.getByID(ID);
		_id = ID;
        name = "gp " +  Std.string(ID);
	}
	
	public override function update(elapsed : Float ) : Void
	{
		super.update(elapsed);
		_gamepad = FlxG.gamepads.getByID(_id);
		if (_gamepad == null)
			return;
		
		xVal = _gamepad.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK);
		yVal = _gamepad.getYAxis(FlxGamepadInputID.LEFT_ANALOG_STICK);

		if (_gamepad.pressed.DPAD_LEFT)
		{
			LeftJustPressed = true;
		}
		else if (_gamepad.pressed.DPAD_RIGHT)
		{
			RightJustPressed = true;
		}
		
		if (_gamepad.pressed.DPAD_UP)
		{
			UpJustPressed = true;
		}
		else if (_gamepad.pressed.DPAD_DOWN)
		{
			DownJustPressed = true;
		}
		
		if (_gamepad.justPressed.A)
		{
			ShootJustPressed = true;
		}
		if (_gamepad.justReleased.A)
		{
			ShootJustReleased = true;
		}
		if (_gamepad.pressed.A)
		{
			ShootPressed = true;
		}
		
		
		if (Math.abs(xVal) > 0.1 || Math.abs(yVal) > 0.1 || ShootJustPressed)
		{
			anyPressed = true;
		}

	}
}
