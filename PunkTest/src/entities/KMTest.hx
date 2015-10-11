package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class KMText extends Entity
{
	
	public override function new(text:String)
    {
        super(0, 100);
		
        // create a new spritemap (image, frameWidth, frameHeight)
        graphic = new Text(text,0,0,384,40);
    }
}