package;
import flixel.FlxG;
import flixel.system.FlxSound;

/**
 * ...
 * @author 
 */
class VarSound
{
	var _sounds : Array<FlxSound>;

	public var volume : Float = 1.0;
	
	
	public function new(folder:String)
	{
		_sounds = new Array<FlxSound>();
		var files  = FileList.getFileListRunTime(folder, "ogg");
		for (f in files)
		{
			var snd : FlxSound = FlxG.sound.load(f, 1, false);
			_sounds.push(snd);
		}
	}
	
	public function play(forceRestart:Bool = false, startTime : Float = 0.0, ?endTime : Float ) 
	{
		if (_sounds.length == 0) return;
		
		var idx : Int = FlxG.random.int(0, _sounds.length - 1);
		trace("play sound " + Std.string(idx));
		_sounds[idx].volume = volume;
		_sounds[idx].play(forceRestart, startTime, endTime);
	}
	
	
}