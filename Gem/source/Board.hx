package ;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author John Doughty
 */
class Board extends FlxGroup
{

    public var gems: Array<Gem> = [];
    private static var board:Board = null;
	
	private function new() 
	{
		super();
		var i: Int;
        var x: Int;
        var y: Int;
        var numImage: Int;
        for (i in 0...Reg.BOARDWIDTH * Reg.BOARDHEIGHT)
        {
            x = i % Reg.BOARDWIDTH;
            y = Math.floor(i / Reg.BOARDWIDTH);
            numImage = getRandomGemID();
            gems.push(new Gem(numImage, x, y));
        }
        for (i in 0...gems.length) 
        {
			add(gems[i]);
        //    buildNeighbors(gems[i]);
        }
	}

    public static function instance ():Board
    {
        if(board == null)
        {
            board = new Board();
        }

        return board;
    }
    
    @:extern static inline function getRandomGemID():Int
    {
        return Math.floor(Math.random() * Reg.NUMGEMIMAGES);
    }
	
}