import luxe.Sprite;
import luxe.Vector;
import luxe.Color;

class Simon 
{
    var Squares:Array<Sprite> = [];
    var positions:Array<Vector> = [new Vector(0,0),new Vector(0,255),new Vector(255,0),new Vector(255,255)];

    public function new()
    {
        var i:Int = 0;
        for(i in 0...positions.length)
        {
            positions[i].x += 125;
            positions[i].y += 125;
            Squares.push(new Sprite({
                pos: positions[i],
                color : new Color(positions[i].x-125,positions[i].y-125,255,1),
                depth : 4,
                size: new Vector(250, 250)
            }));
        }
    }
}