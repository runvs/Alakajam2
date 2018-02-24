package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Level extends FlxSpriteGroup
{

	public var spawnPositions : Array<FlxPoint>;
	private var collisionArray : Array<Int> = [];
	
	public function new() 
	{
		super();
		spawnPositions = new Array<FlxPoint>();
		for (i in 0 ... 4)
		{
			spawnPositions.push(new FlxPoint(3,3));
		}
	}
	
	public function loadLevel ( fileName : String)
	{
		var img : FlxSprite = new FlxSprite();
		img.loadGraphic(fileName, false, GP.WorldSizeX, GP.WorldSizeY, true);
		
		
		for (i in 0 ... GP.WorldSizeX* GP.WorldSizeY)
		{
			collisionArray.push(0);
		}
		
		for (i in 0...GP.WorldSizeX)
		for (j in 0...GP.WorldSizeY)
		{
			var c : FlxColor = img.pixels.getPixel32(i, j);			
			//trace(i, j, c.red, c.green, c.blue, c.alpha);
			
			if (c == FlxColor.WHITE)
			{
				var w : FlxSprite = new FlxSprite();
				w.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel), FlxColor.YELLOW);
				w.setPosition(i * GP.WorldTileSizeInPixel, j * GP.WorldTileSizeInPixel);
				add(w);
				collisionArray[i + j * GP.WorldSizeX] = 1;
			}
			if (c.red == 255 && c.green == 0)
			{
				var idx : Int = c.blue;
				if (idx >= 4) idx = 3;
				trace(idx);
				spawnPositions[idx].set(i, j);
			}
			
		}
		
		
	}
	
	public function isTileFree(X:Int, Y:Int)
	{
		if (X < 0 || Y < 0 || X >= GP.WorldSizeX || Y >= GP.WorldSizeY) return false;
		
		var idx : Int = X + Y * GP.WorldSizeX;
		trace("isTileFree ", X, Y, idx);
		if (idx <0 || idx >= GP.WorldSizeX*GP.WorldSizeY)
			return false;
		
		return (collisionArray[idx] == 0);
	}
	
	override public function draw():Void 
	{
		super.draw();
	
	}
	
}