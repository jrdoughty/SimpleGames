package systems;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import entities.*;

class ScoreSystem
{
	private var outputText:TestText;
	private var player:Player;
	private var bullet:Bullet;

	private var score:Int;
	private var lastBulletY:Int;
	private var wasGreater:Bool;
	private var debug:Bool;

    public function new()
    {
    	score = 0;
    	lastBulletY = 0;
    	wasGreater = false;
    	debug = false;
    }

    public function reset()
    {
    	score = 0;
    	lastBulletY = 0;
    	wasGreater = false;
    }

	public function updateSet()
	{
		var gotPoints:Bool = false;
		if(bullet.y<lastBulletY)
		{
			score += 25;
			gotPoints = true;
		}

		if(player.x < bullet.x && wasGreater || player.x > bullet.x && !wasGreater)
		{
			if(!gotPoints)
				score += 300;

			if(wasGreater)
				wasGreater = false;
			else
				wasGreater = true;
		}
		if(!player.dead && debug)
			outputText.SetText(player.x+" "+score+" points");
		else if(!player.dead)
			outputText.SetText(score+" points");
		else
			outputText.SetText("Game Over: \nYou had "+score+" points");
		lastBulletY = Math.floor(bullet.y);
	}

	public function SetOutPutText(text:TestText)
	{
		outputText = text;
	}

	public function SetPlayer(player:Player)
	{
		this.player = player;
	}

	public function SetBullet(bullet:Bullet)
	{
		this.bullet = bullet;
	}
}