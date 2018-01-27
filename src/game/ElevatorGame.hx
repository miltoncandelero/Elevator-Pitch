package game;

import engine.bitmaptext.BitmapFont;
import engine.bitmaptext.BitmapText;
import engine.image.Image;
import game.VerticalRangeBar;
import motion.Actuate;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.media.Sound;

/**
 * ...
 * @author Elemental Code
 */
class ElevatorGame extends Sprite 
{

		
	//DT
	var currentTime:Int;
	public static var dt:Int;
	public var font:BitmapFont;
	var previousTime:Int;
	var cursor:game.VerticalMovingCursor;
	var good:Sound;
	var bad:Sound;
	var bar:VerticalRangeBar;
	
	var score:Int = 0;
	var txt:engine.bitmaptext.BitmapText;
	
	public function new() 
	{
		super();
		
		currentTime = previousTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, update);
		
		
		addChild(new Bitmap(Assets.getBitmapData("img/test.jpg")));
		
		cursor = new VerticalMovingCursor();
		
		bar = new VerticalRangeBar();
		bar.x = 420;
		bar.y = 45;
		addChild(bar);

		
		good = Assets.getSound("audio/coin.wav");
		bad = Assets.getSound("audio/hurt.wav");
		
		cursor.x = 405;
		cursor.y = 110;
		addChild(cursor);
		
		addEventListener(MouseEvent.CLICK, onClick);
		
		
		font = new BitmapFont(Assets.getBitmapData("fonts/visitor.png"), Assets.getText("fonts/visitor.xml"));
		txt = new BitmapText(font, "score: 0", Main.WIDTH, null, 7	);
		addChild(txt);
	}
	
	function onClick(e:MouseEvent = null):Void 
	{
		if (cursor.canTap) 
		{
			if (cursor.y > VerticalRangeBar.GREEN_START-cursor.height && cursor.y < VerticalRangeBar.GREEN_END) 
			{	//Score!
				score++;
				cursor.speedUp();
				good.play();
				
				var staticY:Float = cursor.y;
				var scoreThingy:BitmapText = new BitmapText(font, "+1", 100, null, 4);
				scoreThingy.y = staticY;
				scoreThingy.x = 350;
				addChild(scoreThingy);
				Actuate.tween(scoreThingy, 0.5, {y:staticY - 20, alpha:0}).delay(0.1).onComplete(removeChild, [scoreThingy]);
				
			}else if (cursor.y > VerticalRangeBar.NO_PUNISH_START-cursor.height && cursor.y < VerticalRangeBar.NO_PUNISH_END)  
			{	//keep up
				
				bad.play();
				
				var staticY:Float = cursor.y;
				var scoreThingy:BitmapText = new BitmapText(font, "+0", 100, null, 4);
				scoreThingy.y = staticY;
				scoreThingy.x = 350;
				addChild(scoreThingy);
				Actuate.tween(scoreThingy, 0.5, {y:staticY - 20, alpha:0}).delay(0.1).onComplete(removeChild, [scoreThingy]);
			}else 
			{	//are you even trying?
				score--;
				cursor.speedDown();
				bad.play();
				
				var staticY:Float = cursor.y;
				var scoreThingy:BitmapText = new BitmapText(font, "-1", 100, null, 4);
				scoreThingy.y = staticY;
				scoreThingy.x = 350;
				addChild(scoreThingy);
				Actuate.tween(scoreThingy, 0.5, {y:staticY - 20, alpha:0}).delay(0.1).onComplete(removeChild, [scoreThingy]);
			}
			
			cursor.taped();
			txt.text = "score: " + Std.string(score);
		}		
	}
	
	
	/* UPDATE aqui viene lo bueno señores. */
	private function update(e:Event = null):Void{
		currentTime = Lib.getTimer ();
		dt = (currentTime - previousTime);
		previousTime = currentTime;
		
		cursor.update(dt);
	}
	
}