package ;

import flixel.FlxSprite;

/**
 * ...
 * @author John Doughty
 */
class Gem extends FlxSprite
{
    private var numImage: Int = 0;
    public var neighborNodes:Map<String,Gem>;
    public var gridX: Int;
    public var gridY: Int;
    private static inline var VERTICAL:Bool = true;
    private static inline var HORIZONTAL:Bool = false;

	public function new(numImage:Int, x:Int = 0, y:Int = 0) 
	{
		gridX = x;
		gridY = y;
		super(x * Reg.GEMIMAGESIZE, y * Reg.GEMIMAGESIZE);
		this.loadGraphic("assets/images/gem" + numImage+".png");
		scale.set(.5, .5);
		
	}
	
}