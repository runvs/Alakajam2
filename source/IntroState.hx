package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class IntroState extends FlxState
{

	private var bg : FlxSprite;
	private var logo : FlxSprite;
	private var overlay : FlxSprite;
	
	private var nextState : Class<FlxState> = MenuState;
	public function new() 
	{
		super();
	}
	
	public override function create()
	{
		super.create();
		//FlxG.camera.bgColor = Palette.primary3();
		FlxG.mouse.visible = false;
		
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		bg.color = FlxColor.BLACK;
		add(bg);
		
		logo = new FlxSprite(0, 0);
		logo.loadGraphic(AssetPaths.runvs_logo__png, false, 800, 600);
		logo.color = Palette.color4;
		logo.origin.set();
		
		//logo.scale.set(0.5, 0.5);
		add(logo);
		
		overlay = new FlxSprite();
		overlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(overlay);
		
		FlxTween.tween(overlay, { alpha : 0 }, 0.5);
		logo.y = - 420;
		//FlxTween.tween(logo, { y : 0 }, 1.75, {startDelay:0.5 } );
		FlxTween.tween(logo, { y: -280 }, 0.45, { startDelay:0.5 , ease:FlxEase.circIn , onComplete:function(t) { FlxG.camera.shake(0.005, 0.125); }  } );
		FlxTween.tween(logo, { y: -140 }, 0.50, { startDelay:0.96, ease:FlxEase.circIn , onComplete:function(t) { FlxG.camera.shake(0.010, 0.15); }   } );
		FlxTween.tween(logo, { y: 0    }, 0.55, { startDelay:1.6, ease:FlxEase.circIn , onComplete:function(t) { FlxG.camera.shake(0.015, 0.19); }   } );
		
		FlxTween.tween(overlay, { alpha : 1 }, 0.75, { startDelay:2.5, 
		onComplete:function(t) 
		{
			FlxG.camera.bgColor = FlxColor.BLACK;
			FlxG.switchState(cast Type.createInstance(nextState, []));
			
		}} );
		
	}

	public override function update(elapsed : Float)
	{
		//MyInput.update();

		if(FlxG.keys.pressed.SPACE ||FlxG.keys.pressed.ESCAPE)
		{
			FlxG.switchState(cast Type.createInstance(nextState, []));
		}
	}
	
}