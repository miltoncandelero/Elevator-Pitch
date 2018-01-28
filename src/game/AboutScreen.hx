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
class AboutScreen extends Sprite 
{
	var lu:engine.mapsheet.Animation;

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/board.png")));
		
		//luli
		var luSheet = new Mapsheet(Assets.getBitmapData("img/credits.png"));
		luSheet.slice(5, 4);
		luSheet.addBehavior(new Behavior("idle", [0,1], true,10));
		lu = new Animation(luSheet);
		lu.showBehavior("idle");
		addChild(lu);
	}
	
	public function update(dt:Int)
	{
		lu.update(dt);
	}
	
}