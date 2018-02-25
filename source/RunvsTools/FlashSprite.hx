package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import openfl.display.BlendMode;

/**
 * ...
 * @author Laguna
 * This Class is a Sprite that can be used as an FlxSprite, but can be flashed (e.g. when an enemy takes damage).
 * This is computationally expensive, as two unique sprites have to be hold in memory.
 */
class FlashSprite extends FlxSprite
{
	public var _flashOverlay : FlxSprite;
	private var _flashTimer : Float = -1;
	private var _flashTimerMax : Float = 1;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		_flashOverlay = new FlxSprite();
		_flashOverlay.alpha = 0;
#if flash
		_flashOverlay.blend = BlendMode.MULTIPLY;
#end

	}
	override public function loadGraphic(Graphic:FlxGraphicAsset, Animated:Bool = false, Width:Int = 0, Height:Int = 0, Unique:Bool = false, ?Key:String):FlxSprite 
	{
		_flashOverlay.loadGraphic(Graphic, Animated, Width, Height, true, Key);
		SpriteFunctions.shadeSpriteWithBorder(_flashOverlay, FlxColor.WHITE, FlxColor.WHITE);
		return super.loadGraphic(Graphic, Animated, Width, Height, true, Key);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		_flashOverlay.update(elapsed);
		_flashOverlay.offset = this.offset;
		_flashOverlay.setPosition(x, y);
		_flashOverlay.scale.set(scale.x, scale.y);
		_flashOverlay.origin.set(origin.x, origin.y);
		if (_flashTimer >= 0)
		{
			_flashOverlay.animation.frameIndex = this.animation.frameIndex;
			
			
			
			_flashOverlay.angle = this.angle;
			
			_flashTimer -= elapsed;
			
			if (_flashTimerMax <= 0 ) _flashTimerMax = 0.01;
			if (_flashTimer > _flashTimerMax) _flashTimer = _flashTimerMax;

			_flashOverlay.alpha = _flashTimer / _flashTimerMax;
		}
		else
		{
			_flashOverlay.alpha = 0;
		}
	}
	
	override public function draw():Void 
	{
		super.draw();
		//trace("_flashOverlay");
		_flashOverlay.draw();
	}
	
	/**
	 * Flash the sprite
	 * Uses _flashOverlay
	 * 
	 * @param	time			How long the flash will last 
	 * @param	col				The color of the flashing overlay.
	 */
	public function Flash(time:Float, col : FlxColor = FlxColor.WHITE) : Void
	{
		_flashOverlay.color = col;
		_flashTimer = _flashTimerMax = time;
	}
	
}