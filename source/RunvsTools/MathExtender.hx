package;

/**
 * ...
 * @author 
 */
class MathExtender
{
	public static function Rad2Deg (v: Float) : Float
	{
		return v * 180 / Math.PI;
	}
	
	public static function Deg2Rad (v:Float) : Float
	{
		return v * Math.PI / 180;
	}
	
	public static function roundForDisplay(input : Float) : String
    {
        var dec = Std.int((input * 10) % 10);
		if (dec < 0) dec *= -1;
		return '${Std.string(Std.int(input))}.${Std.string(dec)}';
    }
	
}