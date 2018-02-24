package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Tile extends FlxSprite
{
	public var tx : Int;
	public var ty : Int;
	
	// 0 empty
	// 1 wall
	// 2 breakable
	
	public var tileType : Int = 0;	

	public function new(_x: Int, _y:Int, type : Int) 
	{
		tx = _x;
		ty = _y;
		super(tx * GP.WorldTileSizeInPixel, ty * GP.WorldTileSizeInPixel);
		
		setTileType(type);
	}
	
	public function setTileType(type:Int) 
	{
		if (type == 0 )
		{
			//makeGraphic(Std.int(GP.WorldTileSizeInPixel/2), Std.int(GP.WorldTileSizeInPixel/2), FlxColor.fromRGB(50, 50, 50), true);
			loadGraphic(AssetPaths.tile__png, false, 16, 16);
		}
		else if (type == 1)
		{
			//makeGraphic(Std.int(GP.WorldTileSizeInPixel / 2), Std.int(GP.WorldTileSizeInPixel / 2), FlxColor.fromRGB(200, 200, 200), true);
			loadGraphic(AssetPaths.wall__png, true, 16, 16);
			
		}
		else if (type == 2)
		{
			//makeGraphic(Std.int(GP.WorldTileSizeInPixel / 2), Std.int(GP.WorldTileSizeInPixel / 2), FlxColor.fromRGB(100, 100, 100), true);
			loadGraphic(AssetPaths.breakable__png, false, 16, 16);
		}
		else if (type == 3)
		{
			loadGraphic(AssetPaths.water__png, true, 16, 16);
			this.animation.add("idle", [0, 1, 2, 3], 4, true);
			animation.play("idle");
		}
		
		var v : Int = FlxG.random.int(200, 255);
		this.color = FlxColor.fromRGB(v, v, v);
		origin.set();
		scale.set(2, 2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}