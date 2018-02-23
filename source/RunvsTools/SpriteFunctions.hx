package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class SpriteFunctions
{
	
	static public function DrawGrid (s : FlxSprite, size: Int = 500, xtics: Int = 100, ytics : Int  = 100, bgColor : FlxColor = FlxColor.BLACK, lineColor : FlxColor = FlxColor.WHITE)
	{
		s.makeGraphic(size, size, bgColor, true);
		var center : Int = Std.int( size / 2);
		
		s.pixels.lock();
		for (i in 0...size)
		{
			s.pixels.setPixel32(i, center, lineColor);
			s.pixels.setPixel32(i, center-1, lineColor);
			s.pixels.setPixel32(i, center+1, lineColor);
			
			s.pixels.setPixel32(center, i, lineColor);
			s.pixels.setPixel32(center-1, i, lineColor);
			s.pixels.setPixel32(center+1, i, lineColor);
		}
		var shift : Int = 0;
		var xover : Bool = false;
		var yover : Bool = false;
		while (true)
		{
			shift += 1;
			var posx : Int = center + shift * xtics;
			if (posx >= size)
				xover = true;
			if (!xover)
			{
				for (i in 0 ... size)
				{
					s.pixels.setPixel32(posx, i, lineColor);
				}
				posx = center - shift * xtics;
				for (i in 0 ... size)
				{
					s.pixels.setPixel32(posx, i, lineColor);
				}
			}
				
			
			
			var posy : Int = center + shift * ytics;
			if (posy >= size)
				yover = true;
			if (!xover)
			{
				for (i in 0 ... size)
				{
					s.pixels.setPixel32(i, posy, lineColor);
				}
				posy = center - shift * ytics;
				for (i in 0 ... size)
				{
					s.pixels.setPixel32( i, posy, lineColor);
				}
			}
				
			if (xover && yover)
				break;
		}
		
		
		
		s.pixels.unlock();
		
	}
	
	static public function shadeSpriteWithBorder (s:FlxSprite, centerColor:FlxColor = FlxColor.WHITE, borderColor : FlxColor = FlxColor.GRAY)
	{
		//trace("shadesprite");
		s.pixels.lock();
		for (i in 0... Std.int(s.pixels.width))
		{
			for (j in 0... Std.int(s.pixels.height))
			{
				var ci : Int = s.pixels.getPixel32(i, j);
				var c : FlxColor = FlxColor.fromInt(ci);
				
				if (c.alpha == 0)
				{
					s.pixels.setPixel32(i, j, FlxColor.fromRGBFloat(0,0,0, 0));
				}
				else 
				{
					var border : Bool = false;
					if (i != 0)
					{
						var cil : Int = s.pixels.getPixel32(i - 1, j);
						var cl : FlxColor = FlxColor.fromInt(cil);
						if (cl.alpha == 0) 
							border = true;
					}
					if(i != Std.int(s.width))
					{
						var cir : Int = s.pixels.getPixel32(i + 1, j);
						var cr : FlxColor = FlxColor.fromInt(cir);
						if (cr.alpha == 0) 
							border = true;
					}
				
					if (j != 0)
					{
						var ciu : Int = s.pixels.getPixel32(i, j-1);
						var cu : FlxColor = FlxColor.fromInt(ciu);
						if (cu.alpha == 0) 
							border = true;
					}
					if(i != Std.int(s.width))
					{
						var cid : Int = s.pixels.getPixel32(i , j + 1);
						var cd : FlxColor = FlxColor.fromInt(cid);
						if (cd.alpha == 0) 
							border = true;
					}
				
					
					if (border)
					{
						s.pixels.setPixel32(i, j, borderColor);
					}
					else
					{
						s.pixels.setPixel32(i, j, centerColor);
					}
				}
			}
		}
		s.pixels.unlock();
	}
	
	public static function createHorizontalBar(spr:FlxSprite, w:Int, h: Int, pad:Int, col : FlxColor, shading : Float = 0.2)
	{
		var darkerColor : FlxColor = col.getDarkened(shading);
		var brighterColor : FlxColor = col.getLightened(shading);
		spr.makeGraphic(w, h, col, true);
		spr.pixels.lock();
		for (i  in 0 ... w)
		{
			for (jp in 0 ... pad)
			{
				var j = jp;
 				if (j > h) j = h;
				
				spr.pixels.setPixel32(i, j, brighterColor);
				spr.pixels.setPixel32(i, h - j, darkerColor);
				spr.pixels.setPixel32(i, h - j - 1, darkerColor);
			}
		}
		spr.pixels.unlock();
	}
	
	
	public static function createVerticalBar(spr:FlxSprite, w:Int, h: Int, pad:Int, col : FlxColor, shading : Float = 0.2)
	{
		var darkerColor : FlxColor = col.getDarkened(shading);
		var brighterColor : FlxColor = col.getLightened(shading);
		spr.makeGraphic(w, h, col, true);
		spr.pixels.lock();
		for (i  in 0 ... h)
		{
			for (jp in 0 ... pad)
			{
				var j = jp;
 				if (j > w) j = h;
				
				spr.pixels.setPixel32(j, i, brighterColor);
				spr.pixels.setPixel32(j, h - i, darkerColor);
				spr.pixels.setPixel32(j, h - i - 1, darkerColor);
			}
		}
		spr.pixels.unlock();
	}
	
	public static function createRoundedCornerBox(spr:FlxSprite, w : Int, h : Int, radius : Int = 4)
	{
		spr.makeGraphic(w, h, FlxColor.WHITE, true);
		spr.pixels.lock();
	
		for (i in 0 ... radius)
		{
			var dx : Float = radius - i;
			for (j in 0 ... radius)
			{
				
				var dy : Float = radius - j; 
				var r : Float = dx * dx + dy * dy;
				if (r > radius * radius)
					spr.pixels.setPixel32(i, j, FlxColor.TRANSPARENT);
			}
			for (j in (h-radius-1) ... h )
			{
				var dy : Float = (h-radius-1) - j; 
				var r : Float = dx * dx + dy * dy;
				if (r > radius * radius)
					spr.pixels.setPixel32(i, j, FlxColor.TRANSPARENT);
			}
		}
		
		for (i in (w-radius-1)... w)
		{
			var dx : Float = (w-radius-1)- i;
			for (j in 0 ... radius)
			{
				
				var dy : Float = radius - j; 
				var r : Float = dx * dx + dy * dy;
				if (r > radius * radius)
					spr.pixels.setPixel32(i, j, FlxColor.TRANSPARENT);
			}
			for (j in (h-radius-1) ... h )
			{
				var dy : Float = (h-radius-1) - j; 
				var r : Float = dx * dx + dy * dy;
				if (r > radius * radius)
					spr.pixels.setPixel32(i, j, FlxColor.TRANSPARENT);
			}
		}
		
		spr.pixels.unlock();
	}
	
	public static function createUpGlowArea(spr:FlxSprite, w:Int, h : Int, ease : EaseFunction, l : Float = (1.0/4.0), r : Float = (3.0/4.0) )
	{
		spr.makeGraphic(w, h, FlxColor.TRANSPARENT, true);
		spr.pixels.lock();
		for (j in 0 ... w)
		{
			var maxh : Float = h;
			
			if (j < w*l)
			{
				maxh *= j / (w *l);
			}
			else if (j > w *r)
			{
				var k : Float = (j - w*r)  / ((1.0-r) * w); 
				maxh *= (1.0 - k);
			}
			else
			{
				maxh *= FlxG.random.float(0.95, 1);
			}
			
			for (i  in 0 ... h)
			{
				if (i < h - maxh)
					continue;
				
				var fi : Float = h-i;
				var d : Float = (maxh);
				
				var v : Float = (1 - (fi / d)) * FlxG.random.float(0.90, 1);
				
				var c :FlxColor = FlxColor.fromRGBFloat(1, 1, 1, ease(v));
				
				spr.pixels.setPixel32(j, i, c);
			}
		}
		spr.pixels.unlock();
		
	}
}