package ;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
	
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
}