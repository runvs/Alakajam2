package;

import flixel.FlxG;
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
	
	public var explosionSound: VarSound;
	
	public var underlay : GlowOverlay;
	
	public function new(px : Int, py: Int, _tx: Int, _ty: Int, pID:  Int, s : PlayState) 
	{
		super();
		_state = s;
		id = pID;
		//this.makeGraphic(Std.int(GP.WorldTileSizeInPixel / 2), Std.int(GP.WorldTileSizeInPixel / 2));
		this.loadGraphic(AssetPaths.mine__png, true, 16, 16);
		this.animation.add("fly", [for (i in 0...4) i], 13, true);
		
		this.animation.add("p0", [for (i in 4...9) i], 10, true);
		this.animation.add("p1", [for (i in 9...14) i], 10, true);
		this.animation.add("p2", [for (i in 15...19) i], 10, true);
		this.animation.add("p3", [for (i in 19...24) i], 10, true);
		
		this.animation.play("fly");
		this.origin.set();
		this.scale.set(2,2);
		
		tx = _tx;
		ty = _ty;
		//trace(px, py, tx, ty);
		this.x = (px )* GP.WorldTileSizeInPixel;
		this.y = (py ) * GP.WorldTileSizeInPixel;
		
		FlxTween.tween(this, 
			{ x : (tx ) * GP.WorldTileSizeInPixel, y : (ty ) * GP.WorldTileSizeInPixel }, 
			GP.MineFlyTimer, 
			{ ease:FlxEase.quartOut, 
			onComplete: function (t) 
			{
				mode = 1;
				FlxTween.tween(underlay, { alpha : 0.6 }, 0.25);
				this.animation.play("p" + Std.string(pID), true);
				//FlxTween.color(this, 0.3, FlxColor.WHITE, FlxColor.RED, {type:FlxTween.PINGPONG});
			} 
		} );
		
		
		explosionSound = new VarSound("assets/sounds/explo/");
		explosionSound.volume = 0.8;
		underlay = new GlowOverlay( -500, -500, FlxG.camera, Std.int(1.8 * GP.WorldTileSizeInPixel), 1, 0.3, true);
		underlay.color = FlxColor.BLACK;
		underlay.alpha = 0;
	}
	
	override public function draw():Void 
	{
		underlay.draw();
		super.draw();
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//trace(x, y);
		if (mode == 1 && shouldExplode)
			ExplodeMe(true);
		
		underlay.setPosition(x + 16, y + 16);
		
		
	}
	
	public function ExplodeMe(small:Bool = false)
	{
		if (mode == 0)
		{
			shouldExplode = true;
			return;
		}
		
		if (alive)
		{
			_state.ExplodeTile(tx, ty);
			
			if (!small)
			{
				_state.ExplodeTile(tx + 1, ty);
				_state.ExplodeTile(tx - 1, ty);
				_state.ExplodeTile(tx, ty +1);
				_state.ExplodeTile(tx, ty -1);
			}
			this.alive = false;
			explosionSound.play(true);
		}
	}
	
}