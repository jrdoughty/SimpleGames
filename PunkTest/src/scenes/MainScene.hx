package scenes;

import entities.*;
import systems.*;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;

class MainScene extends Scene
{

    private var player:Player;
    private var bullet:Bullet;
    private var background:Entity;
    private var text:TestText;
    private var score:ScoreSystem = new ScoreSystem();

    public function new()
    {
        super();
        Input.define("reset", [Key.ENTER, Key.SPACE]);
    }



    public override function update()
    {
        super.update();
        if(score != null)
            score.updateSet();
        if(player.dead && (Input.check("reset") || Input.mouseReleased))
            reset();
    }


	public override function begin()
	{
        //graphic = new Image("graphics/xenoWalkSpriteSheet.png");
        
        background = add(new Background(0,0));
		player = add(new Player(0,333));
        bullet = add(new Bullet(200,0));
        text = add(new TestText(""));
        score.SetBullet(bullet);
        score.SetPlayer(player);
        score.SetOutPutText(text);
	}

    public function reset()
    {
        player.reset();
        score.reset();
        add(bullet.reset());
    }
}