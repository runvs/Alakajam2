package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Level extends FlxTypedSpriteGroup<Tile>
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
			var spawned : Bool = false;
			
			if (c == FlxColor.WHITE)
			{
				var w : Tile= new Tile(i,j,1);
				add(w);
				spawned = true;
				collisionArray[i + j * GP.WorldSizeX] = 1;
			}
			else if (c.red == 100 && c.green == 100 && c.blue == 100)
			{
				var w : Tile = new Tile(i, j, 2);
				add(w);
				spawned = true;
				collisionArray[i + j * GP.WorldSizeX] = 2;
			}
			else if (c.red == 255 && c.green == 0)
			{
				
				var idx : Int = c.blue;
				if (idx >= 4) idx = 3;
				//trace(idx);
				spawnPositions[idx].set(i, j);
			}
			else if (c.red == 0 && c.green == 255 && c.blue == 0)
			{
				//trace("water");
				var w : Tile= new Tile(i,j,3);
				add(w);
				spawned = true;
				collisionArray[i + j * GP.WorldSizeX] = 3;
			}
			
			if (!spawned)
			{
				var w : Tile = new Tile(i, j, 0);
				add(w);
			}
			
		}
		
		
	}
	
	public function isTileDetection (X:Int, Y:Int) : Bool
	{
		if (X < 0 || Y < 0 || X >= GP.WorldSizeX || Y >= GP.WorldSizeY) return false;
		
		var idx : Int = X + Y * GP.WorldSizeX;
		//trace("isTileFree ", X, Y, idx);
		if (idx <0 || idx >= GP.WorldSizeX*GP.WorldSizeY)
			return false;
		
		trace(X, Y, idx, collisionArray[idx]);
		return ( collisionArray[idx] == 3);
	}

	public function isTileBreakable(X:Int, Y:Int) : Bool
	{
		if (X < 0 || Y < 0 || X >= GP.WorldSizeX || Y >= GP.WorldSizeY) return false;
		
		var idx : Int = X + Y * GP.WorldSizeX;
		//trace("isTileFree ", X, Y, idx);
		if (idx <0 || idx >= GP.WorldSizeX*GP.WorldSizeY)
			return false;
		
		return ( collisionArray[idx] == 2);
	}
	
	public function isTileShootable(X:Int, Y:Int) : Bool
	{
		if (X < 0 || Y < 0 || X >= GP.WorldSizeX || Y >= GP.WorldSizeY) return false;
		
		var idx : Int = X + Y * GP.WorldSizeX;
		//trace("isTileFree ", X, Y, idx);
		if (idx <0 || idx >= GP.WorldSizeX*GP.WorldSizeY)
			return false;
		
		return (collisionArray[idx] == 0 || collisionArray[idx] == 2 || collisionArray[idx] == 3);
	}
	
	
	public function isTileWalkable(X:Int, Y:Int) : Bool
	{
		if (X < 0 || Y < 0 || X >= GP.WorldSizeX || Y >= GP.WorldSizeY) return false;
		
		var idx : Int = X + Y * GP.WorldSizeX;
		//trace("isTileFree ", X, Y, idx);
		if (idx <0 || idx >= GP.WorldSizeX*GP.WorldSizeY)
			return false;
		
		return (collisionArray[idx] == 0 || collisionArray[idx] == 3);
	}
	
	
	
	override public function draw():Void 
	{
		super.draw();
	}
	
	public function BreakBreakableTile(X:Int, Y:Int)
	{
		var idx : Int = X + Y * GP.WorldSizeX;
		collisionArray[idx] = 0;
		
		for (t in this)
		{
			if (t.tx == X && t.ty == Y)
				t.setTileType(0);
		}
		
	}
	
}