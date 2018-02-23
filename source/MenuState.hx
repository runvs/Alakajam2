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
	

	public static var Instructions : String = "...";
	public static var Controls : String = "...";
	
	
	public static var HighScore : Int = 0;
	public static var LastScore : Int = 0;
	
	private var overlay : FlxSprite;
	private var overlayTween : FlxTween;
	
	private var started : Bool = false;
	
	private var age : Float = 0;
	
		
#if(flash)
	public static var kongregate : KongregateApi = null;
#end
	
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
		backgroundSprite.color = FlxColor.BLACK;
		add(backgroundSprite);
		
		var title : FlxText = new FlxText(100, 45, 0, MyName, 24);
		title.screenCenter();
		title.y = 45;
		title.alignment = "CENTER";
		title.color = Palette.color5;
		add(title);
		title.offset.set(0, 150);
		FlxTween.tween(title.offset, { y:0 }, 0.5, {ease : FlxEase.bounceOut, startDelay: 0.2});
		
		
		
		var t1 : FlxText = new FlxText (100, 150, 500, "" , 14);
		t1.text = Instructions + "\n\n";
		t1.text += Controls + "\nPress [SPACE] to start \n\n";
		t1.text += "Last Score: " + Std.string(LastScore) + "    HighScore: " + Std.string(HighScore);
		t1.color = Palette.color3;
		add(t1);
		t1.offset.set(950,0);
		FlxTween.tween(t1.offset, { x:0 }, 0.5, { ease : FlxEase.bounceOut, startDelay: 0.55 } );
		
		
		
		var t2 : FlxText = new FlxText (20, 300, 600, "", 10);
		t2.text = "created by " + Authors + " for " + MyJam + "\n";
		t2.text += MyDate + "\n"; 
		t2.text += "visit us at https://runvs.io";
		t2.y = FlxG.height - t2.height - 20;
		t2.color = Palette.color3;
		add(t2);
		t2.offset.set(0, -100);
		FlxTween.tween(t2.offset, { y:0 }, 0.5, { ease : FlxEase.bounceOut, startDelay: 1.0 } );
		
		
		overlay = new FlxSprite(0, 0);
		overlay.makeGraphic(FlxG.width, FlxG.height);
		overlay.color = Palette.color1;
		add(overlay);
		
		overlayTween = FlxTween.tween(overlay, { alpha :0 }, 0.3);


		
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