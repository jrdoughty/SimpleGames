package ;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author John Doughty
 */
class Board extends FlxGroup
{

    public var gems: Array<Gem> = [];
    private var selectedGems: Array<Gem> = [];
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
		
		FlxG.plugins.add(new MouseEventManager());
        for (i in 0...gems.length) 
        {
			add(gems[i]);
			buildNeighbors(gems[i]);
			MouseEventManager.add(gems[i], onMouseDown, null, null, null, false, true, true);
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
        
    @:extern private inline function getGemAtRowCol(x:Int, y:Int):Gem
    {
        var result:Gem = null;
        for (i in 0...gems.length) {
            if(gems[i].gridX == x && gems[i].gridY == y)
            {
                result = gems[i];
                break;
            }
        }
        return result;
    }

    @:extern private inline function grabMatchingGems(firstGem:Gem, secondGem:Gem):Array<Gem>
    {
        var result: Array<Gem> = [];
        result = result.concat(firstGem.validateMove(secondGem));
        result = result.concat(secondGem.validateMove(firstGem));
        return result;
    }

    @:extern private inline function getPostSwapMatches(): Array<Gem>
    {
        var testArray:Array<Gem> = [];
        for (i in 0...gems.length) 
        {
            //testArray = testArray.concat(gems[i].validateMove(gems[i]));
        }
        return testArray;
    }
	
    public function onMouseDown(gem:Gem):Void
    {
        gem.color = 0xdddddd;
        selectedGems.push(gem);

        if(selectedGems.length == 2)
        {
            selectedGems[0].color = 0xffffff;
            selectedGems[1].color = 0xffffff;
            checkForMatch(selectedGems[0], selectedGems[1]);
            selectedGems = [];
        }
    }
	
    private function checkForMatch(?firstGem:Gem, ?secondGem:Gem):Void
    {
        var toExplode: Array<Gem> = [];
        if(firstGem != null && secondGem != null)
        {
            toExplode = grabMatchingGems(firstGem, secondGem);
            if(toExplode.length != 0)
            {
                firstGem.swap(secondGem);
            }
        }
		
        toExplode = toExplode.concat(getPostSwapMatches());
        for (i in 0...toExplode.length) 
        {
            FlxTween.color(toExplode[i], 0.5, toExplode[i].color, toExplode[i].color, 1, .5,{/*complete:*/});
        }
        if(toExplode.length != 0)
        {
            new FlxTimer(.5, function(timer:FlxTimer) {
				removeGems(toExplode);
				collapseGems();
            });
        }
    }
	private function removeGems(toExplode:Array<Gem>):Void
	{
        for (i in 0...toExplode.length) 
        {
			remove(toExplode[i]);
			gems.splice(gems.indexOf(toExplode[i]), 1)[0] = null;
		}
	}

    private function collapseGems(?timer:FlxTimer):Void
    {
        var i:Int = 0;
        var iIndex:Int;
        var j:Int = 0;
        var jIndex:Int;
        var shiftCount:Int = 0;
        var gem:Gem;
        var newGemCounts:Array<Int> = [];
        for (i in 0...Reg.BOARDWIDTH)
        {
            iIndex = Reg.BOARDWIDTH - i - 1;
            shiftCount = 0;

            for (j in 0...Reg.BOARDHEIGHT)
            {
                jIndex = Reg.BOARDHEIGHT - j - 1;
                gem = getGemAtRowCol(iIndex, jIndex);
                if(gem == null)
                {
                    ++shiftCount;
                }
                else
                {
                    FlxTween.tween(gem, {y:gem.y+(Reg.GEMIMAGESIZE*shiftCount)}, 0.5);
                }
            }
            newGemCounts.push(shiftCount);
        }
        
        new FlxTimer(.6, function(timer:FlxTimer){animateNewGems(newGemCounts);});
    }
    
	
    private function animateNewGems(newGemCounts:Array<Int>):Void
    {
        var iIndex:Int;
        var i:Int;
        var j:Int;
		var newGem:Gem;
        for(i in 0...newGemCounts.length)
        {
            iIndex = Reg.BOARDWIDTH - i - 1;
            for(j in 0...newGemCounts[i])
            {
				newGem = new Gem(getRandomGemID(), iIndex, j);
                gems.push(newGem);
				add(newGem);
            }
        }
        for (i in 0...gems.length) 
        {
            gems[i].resetGridPos();
        }
        for (i in 0...gems.length) 
        {
            buildNeighbors(gems[i]);
        }
        checkForMatch();
    }
	
    private function buildNeighbors(gem:Gem):Void
    {
        gem.neighborNodes = new Map();
        for (i in 0...gems.length) 
        {
            if(gem.gridX == gems[i].gridX && gem.gridY == gems[i].gridY - 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Reg.UP ,gems[i]);
            }
            else if(gem.gridX == gems[i].gridX && gem.gridY == gems[i].gridY + 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Reg.DOWN ,gems[i]);
            }
            else if(gem.gridY == gems[i].gridY && gem.gridX == gems[i].gridX - 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Reg.RIGHT ,gems[i]);
            }
            else if(gem.gridY == gems[i].gridY && gem.gridX == gems[i].gridX + 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Reg.LEFT ,gems[i]);
            }
        }
    }

}