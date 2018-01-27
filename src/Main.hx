package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;

/**
 * ...
 * @author Elemental Code
 */
class Main extends Sprite 
{

	public static inline var WIDTH:Int = 540;
	public static inline var HEIGHT:Int = 960;
	public function new() 
	{
		super();
		var game = new game.ElevatorGame();
		addChild(game);
		
	}
	

}
