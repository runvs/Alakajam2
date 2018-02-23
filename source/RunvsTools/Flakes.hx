package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Flakes extends ScreenWrappingSpriteGroup
{

	// encoded as frequency and phase
	var _individualVelocity:Array <FlxPoint>;
	
	public var _globalVelocityX : Float= 0;
	public var _globalVelocityY : Float = 0;
	
	var _timer : Float = 0;
	
	
	public function new(cam:FlxCamera, padding:Float=10, N : Int = 50, sf: Int, c : FlxColor) 
	{
		super(cam, padding);
		_individualVelocity = new Array<FlxPoint>();
		for (i in 0 ... N)
		{
			var s : FlxSprite = new FlxSprite( FlxG.random.float(-_padding, _cam.width + _padding), FlxG.random.float(_padding, _cam.height + _padding));
			s.cameras = [_cam];
			s.makeGraphic(sf, sf);
			s.color = c;
			add(s);
			
			_individualVelocity.push(new FlxPoint(FlxG.random.floatNormal(1.0, 0.25), FlxG.random.float(0,Math.PI)));
		}	
	}
	
	public override function update (elapsed : Float ): Void 
	{
		super.update(elapsed);
		_timer  += elapsed;
		//_globalVelocityX = 2* Math.sin( _timer * 0.5);	
		//_globalVelocityY = 2* Math.sin( _timer* 0.3 + 1.234);
		//
		for (i in 0...members.length)
		{
			var s = members[i];
			var vx : Float = _globalVelocityX + 4* Math.sin( _timer * _individualVelocity[i].x + _individualVelocity[i].y);
			var vy : Float = _globalVelocityY + 2 * Math.sin( _timer * _individualVelocity[i].x + Math.PI / 4 + _individualVelocity[i].y);
			s.velocity.set(vx, vy);
		}
		
	}
	
}