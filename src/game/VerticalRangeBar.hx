package game;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Elemental Code
 */
class VerticalRangeBar extends Sprite 
{

	public static var GREEN_START = 440;
	public static var GREEN_END = 520;
	
	public static var NO_PUNISH_START = 305;
	public static var NO_PUNISH_END = 655;
	
	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/verticalGauge.png")));
	}
	
}