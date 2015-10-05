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
		scale.set(Reg.GEMIMAGESIZE / width, Reg.GEMIMAGESIZE / height);
		updateHitbox();
		this.numImage = numImage;
		
	}
	
	
    public function resetGridPos():Void
    {
        gridX = Std.int(x/Reg.GEMIMAGESIZE);
        gridY = Std.int(y/Reg.GEMIMAGESIZE);
    }

	public function validateMove(gem:Gem):Array<Gem>
    {
        var gemsInARowMap:Map<String, Array<Gem>>;
        var directions: Array<String> = [Reg.RIGHT, Reg.LEFT, Reg.UP, Reg.DOWN];
        var result: Array<Gem> = [];
        var horizontal: Array<Gem> = [];
        var vertical: Array<Gem> = [];
        var i: Int = 0;
        gemsInARowMap = new Map();

        if(gem.gridY == gridY && gem.gridX >= gridX - 1 && gem.gridX <= gridX + 1 ||
            gem.gridX == gridX && gem.gridY >= gridY - 1 && gem.gridY <= gridY + 1 )
        {
            for(i in directions)
            {
                gemsInARowMap.set(i, checkDirection(gem, i));
            }

            horizontal = gemsInARowMap[Reg.RIGHT].concat(gemsInARowMap[Reg.LEFT]);
            vertical = gemsInARowMap[Reg.UP].concat(gemsInARowMap[Reg.DOWN]);
            
            if(horizontal.length >= Reg.MININAROW - 1)
            {
                result = result.concat(horizontal);
            }
            if(vertical.length >= Reg.MININAROW - 1)
            {
                result = result.concat(vertical);
            }
            if(result.length != 0)
            {
                result.push(this);
            }
        }
        return (result);
    }
	
	
    private function checkDirection(gem:Gem, key:String):Array<Gem>
    {
        var result:Array<Gem> = [];
        var temp;
		
        if(gem.neighborNodes.exists(key))
        {
            if(gem.neighborNodes[key] != this && gem.neighborNodes[key].numImage == numImage)
            {
                result.push(gem.neighborNodes[key]);
				trace(numImage + " " + result[result.length - 1].numImage);
                result = result.concat(checkDirection(result[result.length - 1], key));
            }
        }

        return result;
    }
	

    public function swap(gem:Gem):Void
    {
        var oldGridX = gridX;
        var oldGridY = gridY;
        var oldY = y;
        var oldX = x;

        gridX = gem.gridX;
        gridY = gem.gridY;
		x = gem.x;
		y = gem.y;

        gem.gridX = oldGridX;
        gem.gridY = oldGridY;
		gem.x = oldX;
		gem.y = oldY;
    }
}