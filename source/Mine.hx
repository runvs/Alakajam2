package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author 
 */
class Mine extends FlxSprite
{
	public var mode : Int = 0;	// 0 flying, 1 laying and waiting for explosion

	private var tx : Int;
	private var ty : Int;
	
	public function new(px : Int, py: Int, _tx: Int, _ty: Int, pID:  Int) 
	{
		super();
		
		tx = _tx;
		ty = _ty;
		//trace(px, py, tx, ty);
		this.x = px * GP.WorldTileSizeInPixel;
		this.y = py * GP.WorldTileSizeInPixel;
		
		FlxTween.tween(this, 
			{ x : tx * GP.WorldTileSizeInPixel, y : ty * GP.WorldTileSizeInPixel }, 
			GP.MineFlyTimer, 
			{ ease:FlxEase.quartOut, 
			onComplete: function (t) 
			{
				mode = 1;
			} 
			} );
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//trace(x, y);
		
		
	}
	
}