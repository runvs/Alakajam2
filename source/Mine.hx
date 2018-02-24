package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Mine extends FlxSprite
{
	private var _state : PlayState = null;
	var shouldExplode:Bool = false;

	public var id : Int = -1;
	public var mode : Int = 0;	// 0 flying, 1 laying and waiting for explosion

	public var tx : Int;
	public var ty : Int;
	
	public function new(px : Int, py: Int, _tx: Int, _ty: Int, pID:  Int, s : PlayState) 
	{
		super();
		_state = s;
		id = pID;
		this.makeGraphic(Std.int(GP.WorldTileSizeInPixel / 2), Std.int(GP.WorldTileSizeInPixel / 2));
		
		
		tx = _tx;
		ty = _ty;
		//trace(px, py, tx, ty);
		this.x = (px + 0.25)* GP.WorldTileSizeInPixel ;
		this.y = (py + 0.25) * GP.WorldTileSizeInPixel;
		
		FlxTween.tween(this, 
			{ x : (tx + 0.25) * GP.WorldTileSizeInPixel, y : (ty + 0.25) * GP.WorldTileSizeInPixel }, 
			GP.MineFlyTimer, 
			{ ease:FlxEase.quartOut, 
			onComplete: function (t) 
			{
				mode = 1;
				FlxTween.color(this, 0.3, FlxColor.WHITE, FlxColor.RED, {type:FlxTween.PINGPONG});
			} 
		} );
		
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//trace(x, y);
		if (mode == 1 && shouldExplode)
		ExplodeMe(true);
		
	}
	
	public function ExplodeMe(small:Bool = false)
	{
		if (mode == 0)
		{
			shouldExplode = true;
			return;
		}
		_state.ExplodeTile(tx, ty);
		if (!small)
		{
			_state.ExplodeTile(tx + 1, ty);
			_state.ExplodeTile(tx - 1, ty);
			_state.ExplodeTile(tx, ty +1);
			_state.ExplodeTile(tx, ty -1);
		}
		this.alive = false;
	}
	
}