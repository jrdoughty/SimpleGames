package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Bullet extends Entity
{	
	public override function new(x:Int, y:Int)
    {
        super(x, y);
		
        graphic = new Spritemap("graphics/blast.png", 20, 20);

        setHitbox(20, 20);

        // Here I do the same thing by just assigning Player's properties.
        width = 20;
        height = 20;
        //scaleY = -1;
        type = "bullet";
    }

    public override function update()
    {
		move();
		super.update();
    }

    private function move()
    {	if(y > 500){
    		y = 0;
    		x = Math.random() * 384;
    	}
        moveBy(0, 7);
    }
    

    public function destroy()
    {
        // Here we could place specific destroy-behavior for the Bullet.
        scene.remove(this);
    }
    public function reset() : Bullet
    {
        // Here we could place specific destroy-behavior for the Bullet.
        this.x = 200;
        this.y = 0;
        return this;
    }
}