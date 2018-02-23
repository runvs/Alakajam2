package;

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup.FlxTypedGroupIterator;

/**
 * ...
 * @author 
 */
class AdministratedList<T:FlxObject> extends FlxObject
{
	
	var list : FlxTypedGroup<T>;
	
	public var DestroyCallBack : T -> Void = null;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		list = new FlxTypedGroup<T>();
	}
	
	override public function draw():Void 
	{
		super.draw();
		list.draw();
	}
	
	override public function update(elapsed:Float):Void 
	{
		cleanUp();
		super.update(elapsed);
		list.update(elapsed);
		
	}

	public inline function iterator() : FlxTypedGroupIterator<T>
	{
		return list.iterator();
	}
	
	private function cleanUp()
	{
		var l : FlxTypedGroup<T> = new FlxTypedGroup<T>();
		for (i in list)
		{
			if (i.alive) l.add(i);
			else
			{
				if (DestroyCallBack != null)
				{
					DestroyCallBack(i);
				}
			}
		}
		list = l;
	}
	
	public function add (t : T )
	{
		if (t != null)
			list.add(t);
	}
	
	// warning: return type is not valid anymore after calling update();
	public function getList () : FlxTypedGroup<T>
	{
		return list;
	}
	public function length() : Int
	{
		return list.length;
	}
}