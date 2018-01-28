package game;

import engine.mapsheet.Animation;
import engine.mapsheet.Mapsheet;
import engine.mapsheet.data.Behavior;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.utils.Assets;

/**
 * ...
 * @author Elemental Code
 */
class HelpScreen extends Sprite 
{

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/boardHelp.png")));
		
	}

}