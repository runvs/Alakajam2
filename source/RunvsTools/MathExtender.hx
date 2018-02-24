package;
import flixel.FlxObject;
import flixel.math.FlxPoint;

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
	
	public static function objectDir2Point ( dir : Int ) : FlxPoint
	{
		if (dir == FlxObject.LEFT) return new FlxPoint( -1, 0);
		if (dir == FlxObject.RIGHT) return new FlxPoint( 1, 0);
		if (dir == FlxObject.UP) return new FlxPoint(0, -1);
		if (dir == FlxObject.DOWN) return new FlxPoint(0, 1);
		// NONE/ANY
		return new FlxPoint(0, 0);
	}
	
}