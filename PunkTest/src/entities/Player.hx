package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.Bullet;

class Player extends Entity
{
    private var velocity:Float;
    private var acceleration:Float;
    private var sprite:Spritemap;
    public var dead:Bool = false;
	
	public override function new(x:Int, y:Int)
    {
        super(x, y);
		
        // create a new spritemap (image, frameWidth, frameHeight)
        sprite = new Spritemap("graphics/xenoWalkSpriteSheet.png",100,100);
        // define animations by passing frames in an array
        sprite.add("idle", [0]);
        // we set a speed to the walk animation
        sprite.add("walk", [0, 1, 2, 3, 2, 1], 12);
        // tell the sprite to play the idle animation
        sprite.play("idle");


        // Here I set the hitbox width/height with the setHitbox function.
        setHitbox(100, 100);

        // Here I do the same thing by just assigning Player's properties.
        width = 100;
        height = 100;
        // apply the sprite to our graphic object so we can see the player
        graphic = sprite;

        // defines left and right as arrow keys and WASD controls
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
		
        velocity = 0;
    }

    public override function update()
    {
        checkCollisions();
        if(!dead){
    		handleInput();
    		move();
    		setAnimations();
        }
		super.update();
    }

    private function checkCollisions()
    {
        var collisionObject;
        if(collide("bullet", x, y) != null){
            collisionObject = cast(collide("bullet", x, y), Bullet);
            collisionObject.destroy();
            sprite.play("idle");
            dead = true;
        }
    }

	private function handleInput()
    {
        acceleration = 0;

        if (Input.check("left"))
        {
            acceleration = -1;
        }

        if (Input.check("right"))
        {
            acceleration = 1;
        }
    }

    private function move()
    {
		
        velocity += acceleration;
        if (Math.abs(velocity) > 5)
        {
            velocity = 5 * HXP.sign(velocity);
        }
		if (velocity < 0 && this.x > 0)
		{
			velocity = Math.min(velocity + 0.4, 0);
		}
		else if (velocity > 0 && this.x < 384 - this.width)
		{
			velocity = Math.max(velocity - 0.4, 0);
		}
        else{
            velocity = 0;
        }
        moveBy(velocity, 0);
    }

    private function setAnimations()
    {
        if (velocity == 0)
        {
            // we are stopped, set animation to idle
            sprite.play("idle");
        }
        else
        {
            // we are moving, set animation to walk
            sprite.play("walk");

            // this will flip our sprite based on direction
            if (velocity < 0) // left
            {
                sprite.flipped = true;
            }
            else // right
            {
                sprite.flipped = false;
            }
        }
    }
    public function reset()
    {
        this.x = 0;
        dead = false;
    }
}