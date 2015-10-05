package;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Input;

class Main extends luxe.Game
{
    private var activeBoard: Board;
    private var score: Int;

    public static inline var BOARDWIDTH: Int = 8; // how many columns in the board
    public static inline var BOARDHEIGHT: Int = 8; // how many rows in the board
    public static inline var GEMIMAGESIZE: Int = 64; // width & height of each space in pixels
 
    public static inline var NUMGEMIMAGES: Int = 8;
    public static inline var NUMMATCHSOUNDS: Int = 6;
    public static inline var MOVERATE: Int = 25; // 1 to 100, larger num means faster animations
    public static inline var DEDUCTSPEED: Float = 0.8; //// reduces score by 1 point every DEDUCTSPEED seconds.

    public static inline var UP: String = 'up';
    public static inline var DOWN: String = 'down';
    public static inline var LEFT: String = 'left';
    public static inline var RIGHT: String = 'right';

    public static inline var MININAROW: Int = 3;

    override function ready()
    {
        newGame();
    }

    public function newGame():Void
    {
        activeBoard = Board.instance();
        score = 0;
    }


    override function onkeyup( e:KeyEvent ):Void 
    {
       if(e.keycode == Key.escape) {
          Luxe.shutdown();
       }

    }
    
    override function onmouseup( event:MouseEvent ):Void
    {
        if(event.button == MouseButton.left)
            activeBoard.onMouseUp(event.pos);
    }


    override function config( config:luxe.AppConfig ):luxe.AppConfig 
    {
        var i: Int;
        for(i in 0...NUMGEMIMAGES)
            config.preload.textures.push({ id:'img/gem'+i+'.png' });

        return config;

    }
}