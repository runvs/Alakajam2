package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var backgroundSprite : FlxSprite;
	public var overlay : FlxSprite;
	private var ending : Bool;
	
	public var Score : Int = 0;
	private var scoreText : FlxText;
	
	private var timer : Float;
	private var timerText : FlxText;
	
	private var playersToJoinInput : Array<BasicInput> = [];
	
	private var players : FlxTypedSpriteGroup<Player> = null;
	
	public var allMines : AdministratedList<Mine>;
	public var allExplosions:  AdministratedList<Explosion>;
	
	public var levelString : String = "";
	public var level : Level;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		super.create();
		backgroundSprite = new FlxSprite();
		backgroundSprite.makeGraphic(FlxG.width, FlxG.height);
		backgroundSprite.color = FlxColor.GRAY;
		add(backgroundSprite);
		
		
		// add stuff here
		level = new Level();
		level.loadLevel(levelString);
		add(level);
		
		allMines = new AdministratedList<Mine>();
		add(allMines);
		
		players = new FlxTypedSpriteGroup<Player>();
		SpawnPlayers();
		add(players);
	
		
		allExplosions = new AdministratedList<Explosion>();
		add(allExplosions);
		
		ending = false;
		overlay = new FlxSprite();
		overlay.makeGraphic(FlxG.width, FlxG.height);
		overlay.color = FlxColor.BLACK;
		overlay.alpha = 1;
		add(overlay);
	
		
		FlxTween.tween (overlay, { alpha : 0 }, 0.25);
		
		timer = GP.WorldTimerMax;
		timerText = new FlxText(200, 10, 624, "0", 32);
		timerText.alignment = FlxTextAlign.CENTER;
		add(timerText);
		
		scoreText = new FlxText(10, 32, 0, "0", 16);
		scoreText.color = Palette.color5;
		//add(scoreText);	
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function draw() : Void
	{
		super.draw();
		LocalScreenFlash.draw();
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed : Float):Void
	{
		super.update(elapsed);
		scoreText.text = "Score: " + Std.string(Score);
		
		TimerStuff();
		
		
		if (!ending)
		{
			if (timer <= 0)
			{
				HandleSuddenDeath(elapsed);
			}
			
			
			if (getNumberOfPlayersAlive()  <= 1)
			{
				EndGame();
			}

			CheckStupidPlayer();
			
			timer -= FlxG.elapsed;
		}
		LocalScreenFlash.update(elapsed);
	}	
	
	function CheckStupidPlayer() 
	{
		for (p in players)
		{
			if (!p.alive) continue;
			
			for (m in allMines)
			{
				if (m.tx == p.posX && m.ty == p.posY)
				{
					m.ExplodeMe(false);
				}
			}
		}
	}
	
	function HandleSuddenDeath(elapsed:Float) 
	{
		if (timer < -3) timer = -1;
		
		if (timer < -2 && timer + elapsed >= -2)
		{
			SpawnSuddenDeathCharge();
		}
		
	}
	
	
	
	
	function SpawnSuddenDeathCharge() 
	{
		var end : Bool = false;
		
		for (i in 0...10)
		{
			var sx : Int = Std.int(GP.WorldSizeX / 2) ;
			var sy : Int = 0;

			var ox : Int = FlxG.random.int( -Std.int(GP.WorldSizeX / 2), Std.int(GP.WorldSizeX / 2));
			var oy : Int = FlxG.random.int(0, GP.WorldSizeY-1);
	
			
			
			var tx : Int = ox + sx;
			var ty : Int = oy + sy;
			
			var c : Int = 0;
			while (!isTileShootable(tx, ty))
			{
				ox = FlxG.random.int( -Std.int(GP.WorldSizeX / 2), Std.int(GP.WorldSizeX / 2));
				oy = FlxG.random.int(0, GP.WorldSizeY-1);
				tx = ox + sx;
				ty = oy + sy;
				 c++; 
				 if (c > 100)
				 {
					 end = true;
					 break;
				 }
			}
			
			
			if (end)
				break;

			var m : Mine = new Mine(sx, sy, sx + ox, sy + oy, FlxG.random.int(0, players.length - 1) , this );
			SpawnMine(m);
			
		}
	}
	
	
	public function getNumberOfPlayersAlive(): Int
	{
		var count : Int = 0;
		for (p in players)
		{
			if (p.alive)
				count++;
		}
		return count;
	}
	
	public function AddPlayer ( bi : BasicInput)
	{
		playersToJoinInput.push(bi);
	}
	
	public function SpawnPlayers()
	{
		for (i in 0 ... playersToJoinInput.length)
		{
			var p : Player = new Player(i, playersToJoinInput[i], this);
			
			var pos : FlxPoint = level.spawnPositions[p.id];
			
			p.setTilePosition(Std.int(pos.x), Std.int(pos.y));
			players.add(p);
		}
	}

	
	function EndGame() 
	{
		if (!ending)
		{
			ending = true;
			
			FlxTween.tween(overlay, {alpha : 1.0}, 0.9);
			
			var t: FlxTimer = new FlxTimer();
			t.start(1,function(t:FlxTimer): Void {MenuState.setNewScore(Score); FlxG.switchState(new MenuState()); } );
		}
		
	}
	
	function TimerStuff():Void 
	{
		if (timer > 0)
		{
			var dec: Int = Std.int((timer * 10) % 10);
			if (dec < 0) dec *= -1;
			timerText.text = "Timer: " + Std.string(Std.int(timer) + "." + Std.string(dec));
		}
		else
		{
			timerText.text = "SUDDEN DEATH";
			timerText.color = FlxColor.RED;
		}
	}
	
	public function SpawnMine ( m : Mine)
	{
		for (m2 in allMines)
		{
			if (m2.tx == m.tx && m2.ty == m.ty)
			{
				m.ExplodeMe(true);
				break;
			}
		}
		
		if (level.isTileBreakable(m.tx, m.ty))
		{
			m.ExplodeMe(true);
		}
		
		allMines.add(m);
	}
	
	public function ExplodeTile (tx: Int, ty : Int)
	{
		for (p in players)
		{
			if (p.posX == tx && p.posY == ty)
				p.KillMe();
		}
		for (m in allMines)
		{
			if (m.tx == tx && m.ty == ty)
			{
				var ti: FlxTimer = new FlxTimer();
				ti.start(FlxG.random.float(1.0,1.1) * GP.MineStaggeredExplosionDelay, function(t) { m.ExplodeMe(); } );
			}
		}
		
		if (level.isTileBreakable(tx, ty))
		{
			level.BreakBreakableTile(tx, ty);
		}
		
		
		
		for (i in 0 ... GP.WorldExplosionsPerTile)
		{
			var t : FlxTimer = new FlxTimer();
			t.start(FlxG.random.float(0, 0.2), function (t)
			{
				var px : Float = (tx - 1 + FlxG.random.float(0.2, 0.8) ) * GP.WorldTileSizeInPixel ;
				var py : Float = (ty - 1 + FlxG.random.float(0.2, 0.8) ) * GP.WorldTileSizeInPixel ;
				var e : Explosion = new Explosion(px, py, Std.int(1.5 * GP.WorldTileSizeInPixel));
				SpawnExplosion(e);
			});
		}
	}
	
	public function SpawnExplosion(e : Explosion)
	{
		allExplosions.add(e);
	}
	
	public function getMineCountForPlayerX(pID : Int ) : Int
	{
		var c : Int = 0;
		for (m in allMines)
		{
			if (!m.alive) continue;
			if (m.id == pID)
				c++;
		}
		return c;
	}
	
	public function getFirstMineForPlayerX(pID : Int) : Mine
	{
		for (m in allMines)
		{
			if (!m.alive) continue;
			if (m.id == pID)
			{
				return m;
			}
		}
		return  null;
	}
	
	public function isTileShootable(X:Int, Y: Int)
	{
		return level.isTileShootable(X, Y);
	}
	
	public function isTileWalkable(X:Int, Y:Int)
	{
		var noPlayer : Bool = true;
		
		for (p in players)
		{
			if (p.posX == X && p.posY == Y)
			{
				noPlayer = false;
				break;
			}
		}
		
		return level.isTileWalkable(X, Y) && noPlayer;
	}
	
}