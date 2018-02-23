package;
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
	
	public function new(bi : BasicInput) 
	{
		Input = bi;
		
		text = new FlxText(100 , 50, 200, "Free Slot", 16);
		
	}
	
}