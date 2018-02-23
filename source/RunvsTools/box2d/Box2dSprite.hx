package;

import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Box2dSprite extends FlxSprite
{
	
	public var b2b : B2Body = null;

	public function new() 
	{
		super();
	}
	
	override public function makeGraphic(Width:Int, Height:Int, Color:FlxColor = FlxColor.WHITE, Unique:Bool = false, ?Key:String):FlxSprite 
	{
		var rect : B2PolygonShape = new B2PolygonShape();
		rect.setAsBox(Width/2, Height/2);
		var fix : B2FixtureDef = new B2FixtureDef();
		fix.shape = rect;
		fix.density = 1;
		fix.friction = 0.1;
		fix.restitution = 0.1;
		b2b.createFixture(fix);
		//b2d.setPosition(new B2Vec2(Width/2, Height/2));
		return super.makeGraphic(Width, Height, Color, Unique, Key);
	}
	
	override public function update(elapsed:Float):Void 
	{
		this.offset.set(Std.int(this.width / 2), Std.int(this.height / 2));
		this.velocity.set();
		this.acceleration.set();
		
		super.update(elapsed);
		this.setPosition(b2b.getPosition().x, b2b.getPosition().y);
		this.angle = MathExtender.Rad2Deg(b2b.getAngle());
	}
	
}