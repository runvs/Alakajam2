package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite
{

	private var input : BasicInput;
	public var id : Int = 0;
	
	public var moveTimer : Float = 0;
	
	public var posX : Int = 0;
	public var posY : Int = 0;
	
	public var moveList : Array<Int> = [];
	public var playerFacing : Int = FlxObject.LEFT;
	
	
	public function new(i : Int, bi: BasicInput) 
	{
		super();
		id = i;
		input = bi;
		
		this.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel), FlxColor.WHITE, true);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		input.update(elapsed);
		
		//trace(moveList.length);
		
		
		if (input.LeftJustPressed)
			moveList.push(FlxObject.LEFT);
		else if (input.RightJustPressed)
			moveList.push(FlxObject.RIGHT);
			
		if (input.UpJustPressed)
			moveList.push(FlxObject.UP);
		else if (input.DownJustPressed)
			moveList.push(FlxObject.DOWN);
		
		moveTimer -= elapsed;
		if (moveTimer <= 0)
		{
			ExecuteMove();
		}
		
		
	}
	
	function ExecuteMove() 
	{
		if (moveList.length == 0)
			return;		// nothing to do here
		
		if (moveList[0] == FlxObject.LEFT)
		{
			posX--;
			FlxTween.tween(this, { x : x - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
		}
		else if (moveList[0] == FlxObject.RIGHT)
		{
			posX++;
			FlxTween.tween(this, { x : x + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
		}
		
		if (moveList[0] == FlxObject.UP)
		{
			posY--;
			FlxTween.tween(this, { y : y - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
		}
		else if (moveList[0] == FlxObject.DOWN)
		{
			posY++;
			FlxTween.tween(this, { y : y + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
		}
		
		moveList.remove(moveList[0]);
	}
	
	
	
	override public function draw():Void 
	{
		super.draw();
	}
	
}