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
	var juan:engine.mapsheet.Animation;
	var yo:engine.mapsheet.Animation;

	public function new() 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/boardAbout.png")));
		
		//luli
		var luSheet = new Mapsheet(Assets.getBitmapData("img/credits.png"));
		luSheet.slice(5, 4);
		luSheet.addBehavior(new Behavior("luidle", [0, 1], true, 10));
		luSheet.addBehavior(new Behavior("yoidle", [5, 6], true, 10));
		luSheet.addBehavior(new Behavior("juanidle", [10, 11], true, 10));
		
		lu = new Animation(luSheet);
		lu.scaleX = -1;
		lu.x = 55 + lu.width;
		lu.y = 150;
		lu.showBehavior("luidle");
		addChild(lu);
		
		
		juan = new Animation(luSheet);
		juan.scaleX = -1;
		juan.x = 30 + juan.width;
		juan.y = 460;
		juan.showBehavior("juanidle");
		addChild(juan);
		
		yo = new Animation(luSheet);
		yo.x = 360;
		yo.y = 300;
		yo.showBehavior("yoidle");
		addChild(yo);
		
	}
	
	public function update(dt:Int)
	{
		if (lu != null)lu.update(dt);
		if (juan != null)juan.update(dt);
		if (yo != null)yo.update(dt);
	}
	
}