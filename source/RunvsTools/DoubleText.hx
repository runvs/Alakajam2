package;

import flixel.math.FlxPoint;
import flixel.text.FlxText;

/**
 * ...
 * @author 
 */
class DoubleText extends FlxText
{

	public var back : FlxText;
	
	public var backOffset : FlxPoint = new FlxPoint(4, 4);
	
	public function new(X:Float=0, Y:Float=0, FieldWidth:Float=0, ?Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		back = new FlxText(X, Y, FieldWidth, Text, Size, EmbeddedFont);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		back.setPosition(x + backOffset.x, y + backOffset.y);
		back.angle = angle;
		back.scale = this.scale;
		back.alignment = this.alignment;
		back.text = this.text;
		back.update(elapsed);
	}
	
	override public function draw():Void 
	{
		back.draw();
		super.draw();
	}
	
}