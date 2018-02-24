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
	
	private var targetTile : FlxSprite;
	
	private var MaxMineCount : Int = GP.PlayerMineStartCount;
	
	private var invisTimer : Float = GP.PlayerInvisStartTimer;
	private var invisTween : FlxTween = null;
	
	private var playerColor : FlxColor;
	
	public function new(i : Int, bi: BasicInput, s: PlayState) 
	{
		super();
		_state = s;
		id = i;
		input = bi;
		
		this.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel), FlxColor.WHITE, true);
		
		targetTile = new FlxSprite();
		//targetTile.makeGraphic(Std.int(GP.WorldTileSizeInPixel), Std.int(GP.WorldTileSizeInPixel));
		targetTile.loadGraphic(AssetPaths.crosshair__png, true, 16, 16);
		targetTile.animation.add("idle", [for (i in 0...10) i], 15);
		targetTile.animation.play("idle");
		targetTile.scale.set(2, 2);
		targetTile.alpha = 0.8;
		
		calcPlayerColor();
	}
	
	function calcPlayerColor() 
	{
		if (id == 0) playerColor = Palette.colp1;
		if (id == 1) playerColor = Palette.colp2;
		if (id == 2) playerColor = Palette.colp3;
		if (id == 3) playerColor = Palette.colp4;
		
		playerColor.alpha = 20;
	}
	
	
	public function setTilePosition ( px : Int, py : Int)
	{
		this.setPosition(px * GP.WorldTileSizeInPixel, py * GP.WorldTileSizeInPixel);
		posX = px;
		posY = py;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		input.update(elapsed);
		
		targetTile.update(elapsed);
		
		HandleInvisibility(elapsed);
		
		//trace(moveList.length);
		
		
		HandleMoveInput();	
		PerformMoves(elapsed);
	
		HandleLayMineInput(elapsed);
		UpdateTargetTile();
	
		HandleDetonateInput();
	}
	
	function HandleDetonateInput() 
	{
		if (input.DetonateJustPressed)
		{
			UnHide(0.7);
			var m : Mine = _state.getFirstMineForPlayerX(id);
			
			if (m != null && m.mode == 1 )
			{
				m.ExplodeMe();
			}
			
		}
	}
	
	function UpdateTargetTile() 
	{
		if (attackHoldTimer <= 0)
			targetTile.setPosition( -500, -500);
		else
		{
			var ox : Float = MathExtender.objectDir2Point(playerFacing).x + MathExtender.objectDir2Point(playerFacing).x * throwDist;
			var oy : Float = MathExtender.objectDir2Point(playerFacing).y + MathExtender.objectDir2Point(playerFacing).y * throwDist;
			targetTile.setPosition(GP.WorldTileSizeInPixel * (posX + ox), GP.WorldTileSizeInPixel * (posY + oy));
		}
	}
	
	function HandleLayMineInput(elapsed : Float) 
	{
		attackTimer -= elapsed;
		if (attackTimer > 0)
			return;
		
		
		if ( input.ShootJustPressed)
		{
			UnHide();
		}
			
		if ( input.ShootPressed)
		{
			
			attackHoldTimer += elapsed;
		}
		
		if (attackHoldTimer > 0)
		{
			throwDist = Std.int(attackHoldTimer / GP.PlayerAttackHoldForDistance) + 1;
			if (throwDist > GP.PlayerMaxThrowDistance)	throwDist = GP.PlayerMaxThrowDistance;
			
			if (input.ShootJustReleased)
			{
				if (_state.getMineCountForPlayerX(id) >= MaxMineCount )
				{	
					// todo dead man's click
					
				}
				else
				{
					ThrowMine();
					
				}
				attackHoldTimer = 0;
				attackTimer = 0.2;
				throwDist = 0;
			}
		}
		else
		{
			throwDist = 0;
		}
	}
	
	function ThrowMine() 
	{
		UnHide();
		var ox : Int = Std.int(MathExtender.objectDir2Point(playerFacing).x) + Std.int(MathExtender.objectDir2Point(playerFacing).x) * throwDist;
		var oy : Int = Std.int(MathExtender.objectDir2Point(playerFacing).y) + Std.int(MathExtender.objectDir2Point(playerFacing).y) * throwDist;

		var tx : Int = posX + ox;
		var ty : Int = posY + oy;
		
		if (_state.level.isTileShootable(tx,ty))
		{	
			var m : Mine = new Mine(posX, posY, tx, ty, this.id, _state );
			_state.SpawnMine(m);
		}
	}
	
	
	
	function ExecuteCurrentMove() 
	{
		if (moveList.length == 0)
			return;		// nothing to do here
		
		if (moveList[0] == FlxObject.LEFT )
		{
			playerFacing = FlxObject.LEFT;
			if (_state.isTileWalkable(posX-1,posY))
			{
				posX--;
				FlxTween.tween(this, { x : x - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
				moveTimer = GP.PlayerMoveTimer;
			}
			else
			{
				UnHide(0.4);
			}
			
		}
		else if (moveList[0] == FlxObject.RIGHT )
		{
			playerFacing = FlxObject.RIGHT;
			if (_state.isTileWalkable(posX + 1, posY))
			{
				posX++;
				FlxTween.tween(this, { x : x + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
				moveTimer = GP.PlayerMoveTimer;
			}
			else
			{
				UnHide(0.4);
			}
		}
		
		if (moveList[0] == FlxObject.UP )
		{
			playerFacing = FlxObject.UP;
			if (_state.isTileWalkable(posX, posY - 1))
			{
				posY--;
				FlxTween.tween(this, { y : y - GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
				moveTimer = GP.PlayerMoveTimer;
			}
			else
			{
				UnHide(0.4);
			}
		}
		else if (moveList[0] == FlxObject.DOWN )
		{
			playerFacing = FlxObject.DOWN;
			if (_state.isTileWalkable(posX, posY + 1))
			{
				posY++;
				FlxTween.tween(this, { y : y + GP.WorldTileSizeInPixel }, GP.PlayerMoveTimer, { ease : FlxEase.circInOut } );
				moveTimer = GP.PlayerMoveTimer;
			}
			else
			{
				UnHide(0.4);
			}
		}
		if (_state.level.isTileDetection(posX, posY))
		{
			
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
	
	function HandleInvisibility(elapsed:Float):Void 
	{
		invisTimer -= elapsed;
		if (invisTimer < 0 && invisTimer +elapsed >= 0 )	// just crossed -> fade to dark
		{
			if (invisTween != null)
			{
				invisTween.cancel();
			}
			invisTween = FlxTween.tween(this, { alpha : 0 }, 0.75);
		}
	}
	
	public function UnHide(t: Float = 1 ) : Void
	{
		if (invisTween != null)
		{
			invisTween.cancel();
		}
		invisTween = FlxTween.tween(this, { alpha : ((t < 0)?  t: 1 ) }, 0.25);
		invisTimer = t;
		
		LocalScreenFlash.addFlash(x + GP.WorldTileSizeInPixel/2, y+ GP.WorldTileSizeInPixel/2, 0.35, playerColor);
	}
	
	
	override public function draw():Void 
	{
		super.draw();
		
		if (throwDist != 0)
			targetTile.draw();
	}
	
	
	public function KillMe()
	{
		alive = false;
	}
}