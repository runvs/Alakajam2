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
	
	static public var WorldTimerMax (default, null) : Float = 80;
	static public var WorldPowerUpTimerStart (default, null) : Float = 1.5 ;
	static public var WorldPowerUpTimerMax (default, null) : Float = 10 ;
	static public var WorldPowerFlashTimer(default, null) : Float = 1.1;
	
	public static var PlayerMoveTimer (default, null) : Float = 0.275;
	public static var PlayerAttackHoldForDistance (default, null) : Float = 0.6;
	public static var PlayerMaxThrowDistance (default, null) : Int = 6;
	public static var PlayerMineStartCount (default, null) : Int = 2;
	public static var PlayerInvisStartTimer (default, null) : Int = 3;
	
	public static var MineStaggeredExplosionDelay (default, null) : Float = 0.4;
	public static var MineFlyTimer (default, null) : Float = 0.5;
	
	
	
}