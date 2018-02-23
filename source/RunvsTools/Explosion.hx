package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author 
 */
class Explosion extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, sz : Int = 0) 
	{
		super(X, Y);
		
		if (sz == 0)
			sz = FlxG.random.int(16, 32);
		this.makeGraphic(sz, sz, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawCircle(this, -1, -1, -1, FlxColor.WHITE);
		
		this.scale.set(0.75, 0.75);
		
		this.color = FlxColor.BLACK;
		
		var t : FlxTimer = new FlxTimer();
		t.start(0.175, function (t) { this.color = FlxColor.WHITE; } );
		FlxTween.tween(this.scale, { x:3, y: 3 }, 0.35, { startDelay:0.2 } );
		FlxTween.tween(this, { alpha : 0 }, 0.355, { startDelay:0.225, onComplete: function(t) { alive = false; } });
		
		FlxG.camera.shake(0.0025, 0.15);
		FlxG.camera.flash(FlxColor.fromRGB(255, 255, 255, 75), 0.1);
	}
	
}