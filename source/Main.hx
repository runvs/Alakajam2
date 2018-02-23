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
		addChild(new FlxGame(800, 600, IntroState, 1, 60, 60, true));
	}
}