package;
import flixel.FlxSprite;
import flixel.text.FlxText;

/**
 * ...
 * @author 
 */
class JoinEntity
{
	public var Input : BasicInput;
	public var text : FlxText;
	public var alreadyJoined : Bool = false;
	public var image : FlxSprite;
	
	public function new(bi : BasicInput) 
	{
		Input = bi;
		
		text = new FlxText(100 , 50, 200, "Free Slot\n" + bi.name, 16);
		
		text.alignment = FlxTextAlign.CENTER;
		
		image = new FlxSprite(0, 0);
		image.loadGraphic(AssetPaths.flying_mine__png, true, 16, 16);
		
		image.animation.add("fly", [for (i in 0...4) i], 13, true);
		
		image.animation.play("fly");
		image.origin.set();
		image.scale.set(2,2);
		
	}
}