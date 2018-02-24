package ;

/**
 * ...
 * @author 
 */
class BasicInput
{
	public var xVal : Float = 0;
	public var yVal : Float = 0;
	
	public var anyPressed :Bool = false;
    public var name (default, null) : String = "";
	
	public var LeftJustPressed : Bool = false;
	public var RightJustPressed : Bool = false;
	public var UpJustPressed : Bool = false;
	public var DownJustPressed : Bool = false;
	
	public var ShootPressed : Bool = false;
	public var ShootJustPressed : Bool = false;
	public var ShootJustReleased : Bool = false;
	
	public function update(elapsed: Float) : Void 
	{
		// reset the values
		reset();
	}
	
	private function reset()
	{
		xVal = 0;
		yVal = 0;
		
		anyPressed = false;
		
		LeftJustPressed = false;
		RightJustPressed = false;
		UpJustPressed = false;
		DownJustPressed = false;
		
		ShootPressed = false;
		ShootJustPressed = false;
		ShootJustReleased = false;
	}
}
