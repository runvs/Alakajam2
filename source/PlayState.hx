package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var backgroundSprite : FlxSprite;
	public var overlay : FlxSprite;
	private var ending : Bool;
	
	public var Score : Int = 0;
	private var scoreText : FlxText;
	
	private var timer : Float;
	private var timerText : FlxText;
	
	
	
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		backgroundSprite = new FlxSprite();
		backgroundSprite.makeGraphic(FlxG.width, FlxG.height);
		backgroundSprite.color = Palette.color1;
		add(backgroundSprite);
		
		
		// add stuff here
		
		//var spr : FlxSprite = new FlxSprite(100, 100);
		//SpriteFunctions.createRoundedCornerBox(spr, 100, 100, 4);
		////SpriteFunctions.shadeSpriteWithBorder(spr, Palette.color3, Palette.color5);
		//add(spr);
		
		
		ending = false;
		overlay = new FlxSprite();
		overlay.makeGraphic(FlxG.width, FlxG.height);
		overlay.color = Palette.color1;
		overlay.alpha = 1;
		add(overlay);
	
		FlxTween.tween (overlay, { alpha : 0 }, 0.25);
		
		timer = 25;
		timerText = new FlxText(10, 10, 0, "0", 16);
		timerText.color = Palette.color5;
		add(timerText);
		scoreText = new FlxText(10, 32, 0, "0", 16);
		scoreText.color = Palette.color5;
		add(scoreText);
		
	}
	
	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function draw() : Void
	{
		super.draw();
		
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{
		super.update(elapsed);
		scoreText.text = "Score: " + Std.string(Score);
		
		var dec: Int = Std.int((timer * 10) % 10);
		if (dec < 0) dec *= -1;
		timerText.text = "Timer: " + Std.string(Std.int(timer) + "." + Std.string(dec));
		
		if (!ending)
		{
			
			if (timer <= 0)
			{
				EndGame();
			}
			timer -= FlxG.elapsed;
		}
	}	
	

	
	function EndGame() 
	{
		if (!ending)
		{
			ending = true;
			
			
			
			FlxTween.tween(overlay, {alpha : 1.0}, 0.9);
			
			var t: FlxTimer = new FlxTimer();
			t.start(1,function(t:FlxTimer): Void {MenuState.setNewScore(Score); FlxG.switchState(new MenuState()); } );
		}
		
	}
	
}