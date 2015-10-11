package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Bullet;

class Background extends Entity
{
	
	public override function new(x:Int, y:Int)
    {
        super(x, y);
		
        graphic = new Image("graphics/background01.png");
    }

    public override function update()
    {
		super.update();
    }

}