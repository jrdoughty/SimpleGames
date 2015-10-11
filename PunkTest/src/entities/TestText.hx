package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TestText extends Entity
{
	var text:Text;
	public override function new(text:String)
    {
        super(0, 100);
		this.text = new Text(text,0,0,384,40);
        this.text.size = 32;
        //this.text.font = "font/arial.ttf";
        // create a new spritemap (image, frameWidth, frameHeight)
        graphic = this.text;
    }

    public function SetText(text:String){
    	
		this.text.text = text;
        // create a new spritemap (image, frameWidth, frameHeight)
        //graphic = this.text;
    }
}