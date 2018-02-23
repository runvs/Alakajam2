package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

/**
 * ...
 * @author 
 */
class JoinState extends FlxState
{
	
	private var _all : Array<JoinEntity> = [];
	private var _numberOfPlayersJoined = 0;
	private var _age : Float = 0;
	
	public function new() 
	{
		super();
	}
	
	public override function create()
	{
		super.create();
		_all.push(new JoinEntity(new InputKeyboard1()));
		_all.push(new JoinEntity(new InputKeyboard2()));
		for (i in 0...4)
		{
			_all.push(new JoinEntity(new GPInput(i)));
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		_age += elapsed;
		
		var resort : Bool = false;
		
		for (i in 0 ... _all.length)
		{
			_all[i].Input.update(elapsed);
			
			if (_numberOfPlayersJoined >= 4)
				break;
		
			if (_all[i].alreadyJoined)
			{
				
				continue;
			}
			if (_all[i].Input.ShootJustPressed)
			{
				_all[i].text.text = _all[i].Input.name + " joined";
				
				_numberOfPlayersJoined++;
				_all[i].alreadyJoined = true;
				resort = true;
			}
			
		}
		if (resort)
		{
			_all.sort(function(a:JoinEntity, b:JoinEntity) : Int
			{
				if (a.alreadyJoined && !b.alreadyJoined) return -1;
				if (!a.alreadyJoined && b.alreadyJoined) return 1;
				if (a.alreadyJoined == b.alreadyJoined)
				{
					if (a.Input.name.substr(0, 2) == "gp" && b.Input.name.substr(0, 2) != "gp") return 1;
					if (a.Input.name.substr(0, 2) != "gp" && b.Input.name.substr(0, 2) == "gp") return -1;
				}
				return 0;
			});
			
			for (i in 0 ... _all.length)
			{
				_all[i].text.x = 30 + i * 206;
			}
		}
	
		if (FlxG.keys.justPressed.SPACE && _numberOfPlayersJoined >= 2)
		{
			StartGame();
		}
	}
	
	function StartGame() 
	{
		var ps : PlayState = new PlayState();
		for (i in 0 ... 4 )
		{
			if (_all[i].alreadyJoined)
			{
				ps.AddPlayer(_all[i].Input);
			}
		}
		
		FlxG.switchState(ps);
		
		
	}
	
	override public function draw():Void 
	{
		super.draw();
		for (i in 0 ... _all.length)
		{
			_all[i].text.draw();
		}
	}
	
	
}