package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class LocalScreenFlash
{
	static private var hasBeenInit : Bool = false;
	static private var list : AdministratedList<FlxSprite>;
	static private var glow : GlowOverlay;
	
	static private function init()
	{
		list = new AdministratedList<FlxSprite>();
		glow = new GlowOverlay( -1000, -1000, FlxG.camera, 400, 1, 0.5, false);
		glow.color = FlxColor.fromRGB(255, 255, 255, 75);
		hasBeenInit = true;
	}
	
	static public function draw ()
	{
		if (!hasBeenInit)
			init();
		for (s in list)
		{
			glow.setPosition(s.x, s.y);
			glow.color = s.color;
			glow.alpha = s.alpha;
			glow.draw();
		}
	}
	static public function  update (elapsed : Float )
	{
		if (!hasBeenInit)
			init();
		
		list.update(elapsed);
		for (g in list)
		{
			//trace(g.health);
			g.health -= elapsed;
			var v : Float = g.health / g.drag.x;
			if (v < 0) v = 0; if (v > 1) v = 1;
			g.alpha = 0.5*v;
			if (g.health <= 0) g.alive = false;
		}	
		//trace(list.getList().length);
	}
	
	static public function addFlash(x : Float, y: Float, time: Float, c : FlxColor)
	{
		//trace("adding");
		//var glow : GlowOverlay = new GlowOverlay(x, y, FlxG.camera, size, 1, 0.9, false);
		var spr : FlxSprite = new FlxSprite(x, y);
		
		spr.health = time;
		spr.drag.set(time, 0);
		spr.alpha = 0;
		spr.color = c;
		list.add(spr);
		
		//trace(list.length());
		//trace("added");
	}
}