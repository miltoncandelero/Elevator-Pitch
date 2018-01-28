package game;

import engine.bitmaptext.BitmapFont;
import engine.bitmaptext.BitmapText;
import engine.mapsheet.Animation;
import engine.mapsheet.Mapsheet;
import engine.mapsheet.data.Behavior;
import game.DoorAnimation;
import game.VerticalRangeBar;
import motion.Actuate;
import motion.easing.Linear;
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
	var rustyPipes:Bitmap;
	var previousTime:Int;
	var cursor:game.VerticalMovingCursor;
	var good:Sound;
	var bad:Sound;
	var bar:VerticalRangeBar;
	
	var score:Int = 0;
	var txt:engine.bitmaptext.BitmapText;
	
	var hideo:Animation;
	var elevatorBox:Sprite;
	var lu:Animation;
	var doors:game.DoorAnimation;
	var cables:openfl.display.Bitmap;
	var lazybg:openfl.display.Bitmap;
	
	var state:String = "MENU";
	
	public function new() 
	{
		super();
		
		//delta time first time setup
		currentTime = previousTime = Lib.getTimer();
		
		//click on top of enter frame, that way is hierarchier? :|
		addEventListener(MouseEvent.CLICK, onClick);
		addEventListener(Event.ENTER_FRAME, update);
		
		//Visitor font
		font = new BitmapFont(Assets.getBitmapData("fonts/visitor.png"), Assets.getText("fonts/visitor.xml"));
		
		//testing...
		addChild(new Bitmap(Assets.getBitmapData("img/test.jpg")));
		
		//lazy stupidly long bg.
		lazybg = new Bitmap(Assets.getBitmapData("img/bg.png"));
		lazybg.y = -lazybg.height + Main.HEIGHT;
		addChild(lazybg);
		
		//rusty pipes
		rustyPipes = new Bitmap(Assets.getBitmapData("img/rustyPipes.png"));
		rustyPipes.y = -rustyPipes.height + Main.HEIGHT;
		addChild(rustyPipes);
		
		//indicator bar
		bar = new VerticalRangeBar();
		bar.x = 420 + 135;
		bar.y = 45;
		addChild(bar);
		
		//cursor.
		cursor = new VerticalMovingCursor();
		cursor.x = 405 + 135;
		cursor.y = 110;
		addChild(cursor);

		//sounds
		good = Assets.getSound("audio/coin.wav");
		bad = Assets.getSound("audio/hurt.wav");
		

		//score text
		txt = new BitmapText(font, "score: 0", Main.WIDTH, null, 7	);
		addChild(txt);
		
		//cables begind box
		cables = new Bitmap(Assets.getBitmapData("img/elevatorCable.png"));
		addChild(cables);
		
		//elevator box;
		elevatorBox = new Sprite();
		elevatorBox.addChild(new Bitmap(Assets.getBitmapData("img/elevatorBox.png")));
		elevatorBox.x = 35;
		elevatorBox.y = 175;
		addChild(elevatorBox);
		

		
		//hideo
		var hideoSheet = new Mapsheet(Assets.getBitmapData("img/hideo.png"));
		hideoSheet.slice(5, 4);
		hideoSheet.addBehavior(new Behavior("idle", [0], true));
		hideoSheet.addBehavior(new Behavior("good", [0, 1,0,1], false, 15));
		hideoSheet.addBehavior(new Behavior("meh", [5, 6, 7], false, 10));
		hideoSheet.addBehavior(new Behavior("bad", [10],false,5));
		hideoSheet.addBehavior(new Behavior("suicide", [15,16,17,18,19],true,15));
		
		hideo = new Animation(hideoSheet);
		hideo.showBehavior("idle");
		hideo.x = 70;
		hideo.y = 245;
		
		//luli
		var luSheet = new Mapsheet(Assets.getBitmapData("img/lu.png"));
		luSheet.slice(5, 4);
		luSheet.addBehavior(new Behavior("idle", [0], true));
		lu = new Animation(luSheet);
		lu.showBehavior("idle");
		addChild(lu);
		lu.x = 200;
		lu.y = 245;
		
		addChild(hideo);
		//--
		
		//doorContainer
		doors = new DoorAnimation();
		doors.x = 35;
		doors.y = 175;
		addChild(doors);
	}
	
	function onClick(e:MouseEvent = null):Void 
	{
		switch (state) 
		{
			case "GAME":{
				if (cursor.canTap) 
				{
					if (cursor.y > VerticalRangeBar.GREEN_START-cursor.height && cursor.y < VerticalRangeBar.GREEN_END) 
					{	//Score!
						score++;
						cursor.speedUp();
						good.play();
						hideo.showBehaviors(["good", "idle"]);
						var staticY:Float = cursor.y;
						var scoreThingy:BitmapText = new BitmapText(font, "+1", 100, null, 4);
						scoreThingy.y = staticY;
						scoreThingy.x = 350;
						addChild(scoreThingy);
						Actuate.tween(scoreThingy, 0.5, {y:staticY - 20, alpha:0}).delay(0.1).onComplete(removeChild, [scoreThingy]);
						
					}else if (cursor.y > VerticalRangeBar.NO_PUNISH_START-cursor.height && cursor.y < VerticalRangeBar.NO_PUNISH_END)  
					{	//keep up
						
						bad.play();
						hideo.showBehaviors(["meh", "idle"]);
						
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
						hideo.showBehaviors(["bad", "idle"]);
						
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
			
			case "MENU":{
				doors.openDoor();
				Actuate.tween(bar , 0.5, {x : 420}).ease(Linear.easeNone);
				Actuate.tween(cursor , 0.5, {x : 405}).ease(Linear.easeNone);
				Actuate.timer(0.6).onComplete(function () {state = "GAME"; });
				Actuate.tween(lazybg, 15, {y:0}).ease(Linear.easeNone).onComplete(function (){state="GAMEOVER"; });
				Actuate.tween(rustyPipes, 15, {y:0}).ease(Linear.easeNone);
			}
			default:
				
		}
	}
	
	
	
	
	/* UPDATE aqui viene lo bueno señores. */
	private function update(e:Event = null):Void{
		currentTime = Lib.getTimer ();
		dt = (currentTime - previousTime);
		previousTime = currentTime;
		
		//maybe always animate?
		hideo.update(dt);
		lu.update(dt);
		
		switch (state) 
		{
			case "GAME":
				cursor.update(dt);
				
			default:
				
		}

	}
	
}