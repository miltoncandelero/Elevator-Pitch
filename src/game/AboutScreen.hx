package game;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.utils.Assets;

/**
 * ...
 * @author Elemental Code
 */
class AboutScreen extends Sprite 
{

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/creditsMockupBoard.png")));		
	}
	
}