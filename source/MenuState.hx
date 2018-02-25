package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxState;
import flixel.text.FlxText;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	public static var MyDate : String = "2018-02-25";
	public static var MyJam : String = "2nd Alakajam";
	public static var MyName : String = "InvisiMineSweeper";
	public static var Authors: String = "@Laguna_999, @Thunraz";
	
	
	public static var HighScore : Int = 0;
	public static var LastScore : Int = 0;
	
	private var overlay : FlxSprite;
	private var overlayTween : FlxTween;
	
	private var started : Bool = false;
	
	private var age : Float = 0;
	
	
	
	public static function setNewScore (s: Int)
	{
		LastScore = s;
		if (s > HighScore)
		{
			HighScore = s;
		}
	}
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
	
		var backgroundSprite : FlxSprite = new FlxSprite();
		backgroundSprite.makeGraphic(FlxG.width, FlxG.height);
		backgroundSprite.color = Palette.BLACK;
		add(backgroundSprite);
		
		var title : DoubleText = new DoubleText (100, 45, 0, MyName, 48);
		title.screenCenter();
		title.y = 45;
		title.alignment = "CENTER";
		title.color = Palette.color8;
		title.back.color = Palette.color15;
		add(title);
		title.offset.set(0, 150);
		FlxTween.tween(title.offset, { y:0 }, 0.5, {ease : FlxEase.bounceOut, startDelay: 0.2});
		
		
		
		var t1 : FlxText = new FlxText (512 + 30, 150, 512 - 30 - 30, "" , 20);
		t1.text = "Players are invisible unless:\n";
		t1.text += "\t\tthrowing a mine\t\t\n";
		t1.text += "\t\tdetonating a mine\t\t\n";
		t1.text += "\t\tbumping into walls\t\t\n";
		t1.text += "\t\twalking on water\t\t\n";
		t1.color = Palette.color3;
		t1.alignment = FlxTextAlign.RIGHT;
		add(t1);
		t1.offset.set(-950,0);
		FlxTween.tween(t1.offset, { x:0 }, 0.5, { ease : FlxEase.bounceOut, startDelay: 0.55 } );
		
		var t3 : FlxText = new FlxText (30, 150, 512-30-30, "" , 20);
		
		t3.text += "Be the last man standing!\n";
		t3.text += "Pick up PowerUps!\n\n";
		t3.text += "Controls:\n";
		t3.text += "\t\tHold [THROW] to adjust distance\n";
		t3.text += "\t\tRelease to throw a mine\n";
		t3.color = Palette.color3;
		
		add(t3);
		t3.offset.set(950,0);
		FlxTween.tween(t3.offset, { x:0 }, 0.5, { ease : FlxEase.bounceOut, startDelay: 0.55 } );
		
		
		
		var tx : DoubleText = new DoubleText(0, 0, 500, "Pres [SPACE] to start!", 48);
		tx.screenCenter();
		tx.y += 50;
		tx.alignment = "CENTER";
		tx.color = Palette.color8;
		tx.back.color = Palette.color15;
		add(tx);
		tx.alpha = 0;
		FlxTween.tween(tx, { alpha : 1 }, 0.6, { startDelay: 1.2 } );
		FlxTween.tween(tx.scale, { x:1.2, y:1.2 }, 1.75, { ease : FlxEase.bounceOut, type: FlxTween.PINGPONG } );
		
		
		var t2 : DoubleText = new DoubleText (20, 300, 768-40, "", 20);
		t2.text = "created by " + Authors + " for\n";
		t2.text += MyJam + " " + MyDate + "\n"; 
		t2.text += "visit us at https://runvs.io";
		t2.y = FlxG.height - t2.height - 20;	
		t2.color = Palette.color6;
		t2.back.color = Palette.color15;
		add(t2);
		t2.offset.set(0, -200);
		FlxTween.tween(t2.offset, { y:0 }, 0.5, { ease : FlxEase.bounceOut, startDelay: 1.0 } );
		
		
		overlay = new FlxSprite(0, 0);
		overlay.makeGraphic(FlxG.width, FlxG.height);
		overlay.color = Palette.color1;
		add(overlay);
		
		overlayTween = FlxTween.tween(overlay, { alpha :0 }, 0.3);


		FlxG.sound.playMusic(AssetPaths.ost__ogg,0.5);
		
	}
	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{	
		super.update(elapsed );
		age += elapsed;
		if (age > 0.5)
		{
			if (FlxG.keys.justPressed.SPACE)
			{
				StartGame();
			}
		}
	}	
	
	function StartGame():Void 
	{
		if (!started)
		{
			started = true;
			overlayTween.cancel();
			overlayTween = FlxTween.tween(overlay, { alpha : 1 }, 0.5, { onComplete: function (t) {FlxG.switchState(new JoinState());} } );
		}
	}
}