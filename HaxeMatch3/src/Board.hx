using Std;
import luxe.Input;
import luxe.Vector;
import luxe.Color;
import luxe.tween.Actuate;
import luxe.Text;
import phoenix.BitmapFont;

class Board 
{
    private var gems: Array<Gem> = [];
    private var selectedGems: Array<Gem> = [];
    private static var board:Board = null;
    private var score: Text;
    private var font:BitmapFont = Luxe.resources.font('font/PressStart2P.ttf');
    //private var theFont:BitmapFont;

    private function new()
    {
        var i: Int;
        var x: Int;
        var y: Int;
        var numImage: Int;
        score = new Text({
            pos : Luxe.screen.mid,
            point_size : Math.min( Math.round(Luxe.screen.h/12), 48),
            depth : 3,
            align : TextAlign.center,
            text : 'no message yet',
            font : font,
            color : new Color(0,0,0,0).rgb(0x242424)
        });
        for (i in 0...Main.BOARDWIDTH * Main.BOARDHEIGHT)
        {
            x = i % Main.BOARDWIDTH;
            y = Math.floor(i / Main.BOARDWIDTH);
            numImage = getRandomGemID();
            gems.push(new Gem(numImage, x, y));
        }
        for (i in 0...gems.length) 
        {
            buildNeighbors(gems[i]);
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
        return Math.floor(Math.random() * Main.NUMGEMIMAGES);
    }
        
    @:extern private inline function getGemAtRowCol(x:Int, y:Int):Gem
    {
        var result:Gem = null;
        for (i in 0...gems.length) {
            if(gems[i].x == x && gems[i].y == y)
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
            testArray = testArray.concat(gems[i].validateMove(gems[i]));
        }
        return testArray;
    }

    public function onMouseUp(pos:Vector):Void
    {
        var i: Int = 0;
        var x: Float = (pos.x - pos.x % Main.GEMIMAGESIZE)/Main.GEMIMAGESIZE;
        var y: Float = (pos.y - pos.y % Main.GEMIMAGESIZE)/Main.GEMIMAGESIZE;
        var gem = getGemAtRowCol(Std.int(x),Std.int(y));

        if(gem == null)
        {
            return;
        }
        gem.color = new Color().rgb(0xdddddd);
        selectedGems.push(gem);

        if(selectedGems.length == 2)
        {
            selectedGems[0].color = new Color().rgb(0xffffff);
            selectedGems[1].color = new Color().rgb(0xffffff);
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
            Actuate.tween(toExplode[i].color, 0.5, {a:0}).onComplete(function(){
                gems.splice(gems.indexOf(toExplode[i]), 1)[0] = null;
            });
        }
        if(toExplode.length != 0)
        {
            Luxe.timer.schedule(.6, collapseGems);
        }
    }

    private function handleMatches(?toExplode:Array<Gem>):Void
    {
        if(toExplode == null)
        {
            toExplode = getPostSwapMatches();
        }
        else
        {
            toExplode = toExplode.concat(getPostSwapMatches());
        }
        for (i in 0...toExplode.length) 
        {
            Actuate.tween(toExplode[i].color, 0.5, {a:0}).onComplete(function(){
                gems.splice(gems.indexOf(toExplode[i]), 1)[0] = null;
            });
        }
        Luxe.timer.schedule(.6, collapseGems);
    }

    private function collapseGems():Void
    {
        var i:Int = 0;
        var iIndex:Int;
        var j:Int = 0;
        var jIndex:Int;
        var shiftCount:Int = 0;
        var gem:Gem;
        var newGemCounts:Array<Int> = [];
        for (i in 0...Main.BOARDWIDTH)
        {
            iIndex = Main.BOARDWIDTH - i - 1;
            shiftCount = 0;

            for (j in 0...Main.BOARDHEIGHT)
            {
                jIndex = Main.BOARDHEIGHT - j - 1;
                gem = getGemAtRowCol(iIndex, jIndex);
                if(gem == null)
                {
                    ++shiftCount;
                }
                else
                {
                    Actuate.tween(gem.pos, 0.5, {y:gem.pos.y+(Main.GEMIMAGESIZE*shiftCount)});
                }
            }
            newGemCounts.push(shiftCount);
        }
        
        Luxe.timer.schedule(.6, function(){animateNewGems(newGemCounts);});
    }
    
    private function animateNewGems(newGemCounts:Array<Int>):Void
    {
        var iIndex:Int;
        var i:Int;
        var j:Int;
        for(i in 0...newGemCounts.length)
        {
            iIndex = Main.BOARDWIDTH - i - 1;
            for(j in 0...newGemCounts[i])
            {
                gems.push(new Gem(getRandomGemID(), iIndex, j));
            }
        }
        for (i in 0...gems.length) 
        {
            gems[i].reset();
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
            if(gem.x == gems[i].x && gem.y == gems[i].y - 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Main.UP ,gems[i]);
            }
            else if(gem.x == gems[i].x && gem.y == gems[i].y + 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Main.DOWN ,gems[i]);
            }
            else if(gem.y == gems[i].y && gem.x == gems[i].x - 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Main.RIGHT ,gems[i]);
            }
            else if(gem.y == gems[i].y && gem.x == gems[i].x + 1 && gem != gems[i])
            {
                gem.neighborNodes.set(Main.LEFT ,gems[i]);
            }
        }
    }

}