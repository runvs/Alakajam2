package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;

/**
 * ...
 * @author 
 */
class CoordinateGrid extends FlxSprite
{
	public var numbers : FlxSpriteGroup;
	
	public var xtics : Int;
	public var ytics : Int;

	public function new(size : Int, xt: Int, yt: Int) 
	{
		super();
		xtics = xt;
		ytics = yt;
		SpriteFunctions.DrawGrid(this, size,xt,yt);
		
		createNumbers();
		
	}
	
	function createNumbers() 
	{
		numbers = new FlxSpriteGroup();
		var center : Int = Std.int(this.width / 2);
		////////////////////////////////////////
		// xvalues
		////////////////////////////////////////
		var shift : Int = 0;
		while (true)
		{
			var posx : Int = center + 3  + xtics * shift;
			{	
				var num : FlxText = new FlxText(0, 0, 0, Std.string(shift), 10);
				num.offset.set(-posx, -center + 20);
				numbers.add(num);
				
			}
			{
				var posnx : Int = center + 3  - xtics * shift;
				var num : FlxText = new FlxText(0, 0, 0, Std.string(-shift), 10);
				num.offset.set(-posnx, -center + 20);
				numbers.add(num);
				
			}
			if (posx + xtics >= this.width)
				break;
			shift++;
		}
		////////////////////////////////////////
		// yvalues
		////////////////////////////////////////
		var shift : Int = 0;
		while (true)
		{
			var posy : Int = center + 3  + ytics * shift;
			
			{
				
				var posny : Int = center + 3  - ytics * shift;
				var num : FlxText = new FlxText(0, 0, 0, Std.string(shift), 10);
				num.offset.set( -center + 12, -posny);
				numbers.add(num);
				
			}
			{	
				if (shift == 0)
				{
					shift++;
					continue;
				}
				var num : FlxText = new FlxText(0, 0, 0, Std.string(-shift), 10);
				num.offset.set(-center + 18, -posy);
				numbers.add(num);
				
			}
			if (posy + ytics >= this.height)
				break;
			shift++;
		}
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		numbers.update(elapsed);
		for (n in numbers)
		{
			n.setPosition(x, y);
		}
	}
	
	override public function draw():Void 
	{
		super.draw();
		numbers.draw();
	}
	
	
	public function convertXGlobal2Grid(xin : Float ) : Float
	{
		xin -= this.x;
		var center : Int = Std.int(this.width / 2);
		xin -= center;
		return xin / xtics;
	}
	public function convertYGlobal2Grid(yin : Float ) : Float
	{
		yin -= this.y;
		var center : Int = Std.int(this.width / 2);
		yin -= center;
		return yin / ytics;
	}
	
	public function convertXGrid2Global(xin:Float) : Float
	{
		xin *= xtics;
		var center : Int = Std.int(this.width / 2);
		return xin + center +  this.x;
	}
	public function convertYGrid2Global(yin:Float) : Float
	{
		yin *= ytics;
		var center : Int = Std.int(this.width / 2);
		return yin + center +  this.y;
	}
	
}