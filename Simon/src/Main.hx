package;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Input;

class Main extends luxe.Game {

    override function ready()
    {
        new Simon();
    }

    public function newGame():Void
    {
        //activeBoard = Board.instance();
        //score = 0;
    }


    override function onkeyup( e:KeyEvent ):Void 
    {
       //if(e.keycode == Key.escape) {
       //   Luxe.shutdown();
       //}

    }
    
    override function onmouseup( event:MouseEvent ):Void
    {
        //if(event.button == MouseButton.left)
        //    activeBoard.onMouseUp(event.pos);
    }


    override function config( config:luxe.AppConfig ):luxe.AppConfig 
    {/*
        var i: Int;
        for(i in 0...NUMGEMIMAGES)
            config.preload.textures.push({ id:'img/gem'+i+'.png' });
*/

        return config;
    }
}