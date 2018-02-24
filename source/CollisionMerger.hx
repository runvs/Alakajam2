package;

/**
 * ...
 * @author 
 */
class CollisionMerger
{
	static public function Merge( input : Array<Int>, sx : Int, sy : Int) : Array<Array<Int> >
	{
		var output :Array<Array<Int> > = new Array<Array<Int>>();
		var tmp :Array<Int> = new Array<Int>();
		//var tmp2 :Array<Array<Int> > = new Array<Array<Int> >();
		
		for (i in 0 ... input.length)
		{
			tmp.push(input[i]);
			output.push( [0,1]);
		}
		
		{
		var x : Int = 0;
		while (x < sx)
		{
			var y : Int = 0;
			while (y < sy)
			{
				var idx : Int = getID(x, y, sx);
				if (tmp[idx] == 1)
				{
					var y2 : Int = y;
					var count :Int = 1;
					while (true)
					{
						y2++;
						if (y2 >= sy)
						{
							output[idx][0] = count;
							break;
						}
						
						var idx2 = getID(x, y2, sx);
						if (tmp[idx2] == 1)
						{
							count++;
							tmp[idx2] = 0;
						}
						else
						{
							output[idx][0] = count;
							break;
						}
					}
				}
				
				y++;
			}
			x++;
		}
		}
		

		
		{
		var y : Int = 0;
		while (y < sy)
		{
			var x : Int = 0;
			while (x < sx)
			{
			
				var idx : Int = getID(x, y, sx);
				if (output[idx][0] == 0)
				{
					x++;
					continue;
				}
				
				var v : Int = output[idx][0];
				var x2 = x;
				var count = 1;
				while (true)
				{
					x2++;
					if (x2 >= sx) 
					{
						output[idx][1] = count;
						break;
					}
					
					var idx2 : Int = getID(x2, y, sx);
					if (output[idx2][0] == v)
					{
						output[idx2][0] = 0;
						count++;
					}
					else
					{
						output[idx][1] = count;
						break;
					}
				}
				x++;
			}
			y++;
		}
		}
		
		return output;
	}
	
	static private function getID(x : Int, y : Int, sx : Int) : Int
	{
		return x + y * sx;
	}
	
	
}