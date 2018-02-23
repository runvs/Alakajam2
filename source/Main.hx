package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.Lib;


class Main extends Sprite
{
	public function new()
	{
		
		super();
		//GAnalytics.startSession( "YOUR-UA-CODE" );
		addChild(new FlxGame(1024, 768, IntroState, 1, 60, 60, true));
	}
}