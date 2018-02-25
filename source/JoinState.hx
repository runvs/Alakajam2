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
	
	private var _text : FlxText;
	
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
		
		_text = new FlxText(0, 50, 1024, "Press [THROW] to join!\nPress[SPACE] to start!", 16);
		_text.alignment = FlxTextAlign.CENTER;
		add(_text);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		var resort : Bool = false;
		if (_age == 0)	resort = true;
		
		_age += elapsed;
	
		
		for (i in 0 ... _all.length)
		{
			
			_all[i].Input.update(elapsed);
			_all[i].image.update(elapsed);
			
			if (_numberOfPlayersJoined >= 4)
				break;
		
			if (_all[i].alreadyJoined)
			{
				
				continue;
			}
			if (_all[i].Input.ShootJustPressed || _all[i].Input.anyPressed)
			{
				_all[i].text.text = _all[i].Input.name + "\njoined";
				
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
				_all[i].text.x = 250 + (i % 2) * 300;
				_all[i].text.y = 150 + Std.int(i / 2)  * 150;
				
				_all[i].image.setPosition(_all[i].text.x + 100 - 16, _all[i].text.y + 50);
				
				if (!StringTools.startsWith(_all[i].text.text, "Free"))
				{
					if (i == 0)	_all[i].text.color = Palette.colp1;
					else if (i == 1)	_all[i].text.color = Palette.colp2;
					else if (i == 2)	_all[i].text.color = Palette.colp3;
					else if (i == 3)	_all[i].text.color = Palette.colp4;
				}
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
		
		ps.levelString = SelectRandomLevel();
		
		FlxG.switchState(ps);
	}
	
	function SelectRandomLevel() : String
	{
		var arr : Array<String>  = FileList.getFileListRunTime("assets/data/", ".png");
		var idx = FlxG.random.int(0, arr.length - 1);
		trace(arr[idx]);
		return arr[idx];
	}
	
	override public function draw():Void 
	{
		super.draw();
		for (i in 0 ... _all.length)
		{
			_all[i].text.draw();
			if (_all[i].alreadyJoined)
			{
				_all[i].image.draw();
			}
		}
	}
}