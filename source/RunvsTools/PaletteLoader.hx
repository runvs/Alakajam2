////////////////////////////////////////////////////
////////////////////////////////////////////////////
// created by @Laguna_999
// to be used with *.scss or *.gpl color scheme files
////////////////////////////////////////////////////
// Example
////////////////////////////////////////////////////
// @:build(PaletteLoader.LoadPalette("assets/data/palettes/legendary.scss"))
// class Palette
// {
// }
////////////////////////////////////////////////////
////////////////////////////////////////////////////



package;
import haxe.macro.Context;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.FieldType;
import sys.io.File;


/**
 * ...
 * @author 
 */
class PaletteLoader
{
	
	private static function parseFile_gpl (fileName : String) : Map<String, Int>
	{
		var m : Map<String, Int> = new Map<String, Int>();
		
		var f : String = File.getContent(fileName);
		var lines : Array<String> = f.split("\n");
		
		for (i in 4 ... lines.length)
		{
			var l : String = StringTools.ltrim(lines[i]);
			
			var ss : Array<String>  = l.split(" ");			
			
			var r: Int = Std.parseInt(StringTools.trim(ss[0]));
			var g: Int = Std.parseInt(StringTools.trim(ss[1]));
			var b: Int = Std.parseInt(StringTools.trim(ss[2]));
			var colorName : String = "";
			
			var arr : Array<String> = [];
			for (j in 3 ... ss.length)
			{
				arr.push(StringTools.trim(ss[j]));
			}
			if (arr[0] == "primary")
			{
				
				var idx : Int = Std.parseInt(arr[1]);
				if (idx == 0) idx = 3; else if (idx < 3) idx = 6 - idx; else idx = 5 - idx;
				colorName = "color" + Std.string(idx);
			}
			else if (arr[0] == "secondary-1")
			{
				var idx : Int = Std.parseInt(arr[1]);
				if (idx == 0) idx = 3; else if (idx < 3) idx = 6 - idx; else idx = 5 - idx;
				colorName = "secondary1_" + Std.string(idx);
			}
			else if (arr[0] == "secondary-2")
			{
				var idx : Int = Std.parseInt(arr[1]);
				if (idx == 0) idx = 3; else if (idx < 3) idx = 6 - idx; else idx = 5 - idx;
				colorName = "secondary2_" + Std.string(idx);
			}
			else if (arr[0] == "complement")
			{
				var idx : Int = Std.parseInt(arr[1]);
				if (idx == 0) idx = 3; else if (idx < 3) idx = 6 - idx; else idx = 5 - idx;
				colorName = "complement" + Std.string(idx);
			}
			
			trace(l + "       " + colorName + " " + r + " " + g + " " + b);
			var ic : Int =  (b)  + (g << 8) + (r << 8 << 8);
			m[colorName] = ic;
		}
		return m;
	}
	
	
	private static function parseFile_scss (fileName : String) : Map<String, Int>
	{
		var m : Map<String, Int> = new Map<String, Int>();
		
		var f : String = File.getContent(fileName);
		var lines : Array<String> = f.split("\n");
		
		for (l in lines)
		{
			if (l.indexOf(": rgba(") == -1) continue;
			var s1 : Array<String>  = l.split(": rgba(");			
			if (s1.length != 2) continue;
			var colorName : String = s1[0].substr(1);
			
			var s2 : Array<String> = s1[1].substring(0, s1[1].length - 2).split(",");
			if (s2.length != 4) continue;
			var r: Int = Std.parseInt(s2[0]);
			var g: Int = Std.parseInt(s2[1]);
			var b: Int = Std.parseInt(s2[2]);
			trace(colorName + " " + r + " " + g + " " + b);
			var ic : Int =  (b)  + (g << 8) + (r << 8 << 8);
			m[colorName] = ic;
		}
		return m;
	}
	
	private static function MapToTypeArray(m : Map<String,Int> ) : Array < Field >
	{
		var fields : Array<Field> = new Array<Field>();
		for (k in m.keys())
		{
			var pos = Context.currentPos();
			// create a new field
			var propertyField : Field = 
			{
			  name : k,
			  access : [Access.APublic, Access.AStatic],
			  kind: FieldType.FProp("default", "null", macro:Int,macro $v{m[k]}), 
			  pos: pos,
			};
			fields.push(propertyField);
		}
		return fields;
	}
	

	public static macro function LoadPalette(fileName:String, pname: String = "") : Array<Field>
	{
		// get the currently available fields
		var fields = Context.getBuildFields();
	
		var m : Map<String, Int> = new Map<String,Int>();
		
		if (StringTools.endsWith(fileName, "scss"))
			m = parseFile_scss(fileName);
		else if (StringTools.endsWith(fileName, "gpl"))
		{
			m = parseFile_gpl(fileName);
			if (!m.exists("color4"))
			{
				m["color4"] = m["color1_shade3"];
			}
			if (!m.exists("color5"))
			{
				m["color5"] = m["color1_shade4"];
			}
		}
		
		for (k in m.keys())
		{
		
			var pos = Context.currentPos();
			// create a new field
			var propertyField : Field = 
			{
			  name : k,
			  access : [Access.APublic, Access.AStatic],
			  kind: FieldType.FProp("default", "null", macro:Int,macro $v{m[k]}), 
			  pos: pos,
			};
			fields.push(propertyField);
		
		}
		return fields;
	}
	
}