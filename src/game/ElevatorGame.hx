package game;

import engine.image.Image;
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
	var previousTime:Int;
	var cursor:game.VerticalMovingCursor;
	var good:Sound;
	var bad:Sound;
	
	
	public function new() 
	{
		super();
		
		currentTime = previousTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, update);
		
		
		addChild(new Bitmap(Assets.getBitmapData("img/test.jpg")));
		
		cursor = new VerticalMovingCursor();

		
		good = Assets.getSound("audio/coin.wav");
		bad = Assets.getSound("audio/hurt.wav");
		
		cursor.x = 405;
		cursor.y = 110;
		addChild(cursor);
		
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	function onClick(e:MouseEvent = null):Void 
	{
		trace ("========");
		trace(VerticalRangeBar.GREEN_START-cursor.height);
		trace(cursor.y);
		trace(VerticalRangeBar.GREEN_END);
		trace ("========");
		if (cursor.y > VerticalRangeBar.GREEN_START-cursor.height && cursor.y < VerticalRangeBar.GREEN_END) 
		{
			cursor.speedUp();
			good.play();
		}else 
		{
			cursor.speedDown();
			bad.play();
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