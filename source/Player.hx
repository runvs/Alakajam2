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
	private var _state : PlayState;
	
	private var input : BasicInput;
	public var id : Int = 0;
	
	public var moveTimer : Float = 0;
	
	public var posX : Int = 0;
	public var posY : Int = 0;
	
	public var moveList : Array<Int> = [];
	public var playerFacing : Int = FlxObject.LEFT;
	
	public var remainingMines : Int = 3;
	public var attackTimer : Float = 0;
	public var attackHoldTimer  : Float = 0;
	public var throwDist : Int = 0;
	
	
	public function new(i : Int, bi: BasicInput) 
	{
		super();
		id = i;
		input = bi;
		
		this.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel), FlxColor.WHITE, true);
	}
	
	public function setState (s : PlayState)
	{
		_state = s;
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		input.update(elapsed);
		
		//trace(moveList.length);
		
		
		HandleMoveInput();	
		PerformMoves(elapsed);
	
		HandleAttackInput(elapsed);
		
		
	}
	
	function HandleAttackInput(elapsed : Float) 
	{
		attackTimer -= elapsed;
		if (attackTimer > 0)
			return;
		
		if ( input.ShootPressed)
			attackHoldTimer += elapsed;
		
		if (attackHoldTimer > 0)
		{
			throwDist = Std.int(attackHoldTimer / GP.PlayerAttackHoldForDistance) + 1;
			if (throwDist > 4)	throwDist = 4;
			
			if (input.ShootJustReleased)
			{
				ThrowMine();
				attackHoldTimer = 0;
				attackTimer = 0.2;
			}
		}
		else
		{
			throwDist = 0;
		}
			
		
	}
	
	function ThrowMine() 
	{
		var m : Mine = new Mine();
		
		var ox : Float = MathExtender.objectDir2Point(playerFacing).x * throwDist * GP.WorldTileSizeInPixel;
		var oy : Float = MathExtender.objectDir2Point(playerFacing).y * throwDist * GP.WorldTileSizeInPixel;
		
		
		m.setPosition(x + ox, y +oy);
		
		//m.velocity.(MathExtender.objectDir2Point(playerFacing)* GP.InitialMineVelocity
		
		_state.SpawnMine(m);
	}
	
	
	
	function ExecuteCurrentMove() 
	{
		if (moveList.length == 0)
			return;		// nothing to do here
		
		if (moveList[0] == FlxObject.LEFT)
		{
			posX--;
			FlxTween.tween(this, { x : x - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
			playerFacing = FlxObject.LEFT;
		}
		else if (moveList[0] == FlxObject.RIGHT)
		{
			posX++;
			FlxTween.tween(this, { x : x + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
			playerFacing = FlxObject.RIGHT;
		}
		
		if (moveList[0] == FlxObject.UP)
		{
			posY--;
			FlxTween.tween(this, { y : y - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
			playerFacing = FlxObject.UP;
		}
		else if (moveList[0] == FlxObject.DOWN)
		{
			posY++;
			FlxTween.tween(this, { y : y + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
			moveTimer = GP.PlayerMoveTimer;
			playerFacing = FlxObject.DOWN;
		}
		
		moveList.remove(moveList[0]);
	}
	
	function HandleMoveInput():Void 
	{
		if (input.LeftJustPressed)
			moveList.push(FlxObject.LEFT);
		else if (input.RightJustPressed)
			moveList.push(FlxObject.RIGHT);
			
		if (input.UpJustPressed)
			moveList.push(FlxObject.UP);
		else if (input.DownJustPressed)
			moveList.push(FlxObject.DOWN);
	
	}
	
	function PerformMoves(elapsed : Float):Void 
	{
		moveTimer -= elapsed;
		if (moveTimer <= 0)
		{
			ExecuteCurrentMove();
		}
	}
	
	
	
	override public function draw():Void 
	{
		super.draw();
	}
	
}