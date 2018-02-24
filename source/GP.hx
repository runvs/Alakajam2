package;

/**
 * ...
 * @author 
 */
class GP
{

	public static var WorldTileSizeInPixel (default, null) : Float = 32;
	public static var WorldSizeX (default, null) : Int = 32;
	public static var WorldSizeY (default, null) : Int = 24;
	public static var WorldExplosionsPerTile (default, null) : Int = 8;
	
	
	public static var PlayerMoveTimer (default, null) : Float = 0.275;
	public static var PlayerAttackHoldForDistance (default, null) : Float = 0.6;
	public static var PlayerMaxThrowDistance (default, null) : Int = 6;
	public static var PlayerMineStartCount (default, null) : Int = 8;
	
	public static var MineStaggeredExplosionDelay (default, null) : Float = 0.4;
	public static var MineFlyTimer (default, null) : Float = 0.5;
	static public var WorldTimerMax (default, null) : Float = 80;
	
}