package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class PowerUp extends FlashSprite
{
	
	public var powerUpType : Int;	// 0 shield
							// 1 More Mines
							// 2 Explode all Mines at once

	public var tx : Int = 0;
	public var ty : Int = 0;
	
	private var flashTimer : Float = 1;
	
	public function new(_x : Int, _y : Int) 
	{
		super();
		//this.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel));
		//_flashOverlay.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel));
		
	
		
		
		powerUpType = FlxG.random.int(0, 3);
		if (powerUpType == 3) powerUpType = 1;
		setTilePosition(_x, _y);
		
		if (powerUpType == 0)
			this.loadGraphic(AssetPaths.pickup_shield__png, false, 16, 16);
		else if (powerUpType == 1)
			this.loadGraphic(AssetPaths.pickup_mines__png, false, 16, 16);
		else if (powerUpType == 2)
			this.loadGraphic(AssetPaths.pickup_megaexplode__png, false, 16, 16);
			
		this.origin.set();
		//this.angularVelocity = 45;
		
		
		scale.set(5,5);
		
		
		
		FlxTween.tween(this, { alpha: 1 }, 1, 
		{ onComplete: function(t) 
		{
			//FlxG.camera.shake(0.001, 0.25); 
			LocalScreenFlash.addFlash(x + GP.WorldTileSizeInPixel / 2, y + GP.WorldTileSizeInPixel / 2, 0.25, FlxColor.WHITE); 
			
			
		} 
		} );
		FlxTween.tween(this.scale, { x: 2, y:2 } );
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		flashTimer -= elapsed;
		if (flashTimer <= 0)
		{
			flashTimer = GP.WorldPowerFlashTimer;
			Flash(0.2);
			LocalScreenFlash.addFlash(x + GP.WorldTileSizeInPixel / 2, y + GP.WorldTileSizeInPixel / 2, 0.25, FlxColor.WHITE);
		}
	}
	
	public function setTilePosition ( px : Int, py : Int)
	{
		//trace(px, py);
		this.setPosition(px * GP.WorldTileSizeInPixel, py * GP.WorldTileSizeInPixel);
		tx = px;
		ty = py;
	}
	
	public function pickUp()
	{
		this.alive = false;
	}
	
	
}