package game;

import engine.bitmaptext.BitmapFont;
import engine.bitmaptext.BitmapText;
import engine.image.Image;
import engine.mapsheet.Animation;
import engine.mapsheet.Mapsheet;
import engine.mapsheet.data.Behavior;
import game.DoorAnimation;
import game.VerticalRangeBar;
import motion.Actuate;
import motion.easing.Elastic;
import motion.easing.Quad;
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
	public static var font:BitmapFont;
	var rustyPipes:Bitmap;
	var previousTime:Int;
	var cursor:game.VerticalMovingCursor;
	var good:Sound;
	var bad:Sound;
		var fall:Sound;

	var bar:VerticalRangeBar;
	
	var score:Int = 0;
	var txt:engine.bitmaptext.BitmapText;
	
	var hideo:Animation;
	var elevatorBox:Sprite;
	var lu:Animation;
	var doors:game.DoorAnimation;
	var cables:openfl.display.Bitmap;
	var lazybg:openfl.display.Bitmap;
	
	var state:String = "ANIMATING";
	var scoreCart:game.ScoreScreen;
	var btnAbout:Image;
	var btnHelp:Image;

	
	public function new() 
	{
		super();
		
		//delta time first time setup
		currentTime = previousTime = Lib.getTimer();
		
		//click on top of enter frame, that way is hierarchier? :|
		addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		addEventListener(Event.ENTER_FRAME, update);
		
		//Visitor font
		font = new BitmapFont(Assets.getBitmapData("fonts/visitor.png"), Assets.getText("fonts/visitor.xml"));
		
		//testing...
		emergencyBG = new Bitmap(Assets.getBitmapData("img/dummyBGforBugs.png"));
		emergencyBG.y = -Main.HEIGHT;
		addChild(emergencyBG);
		
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
		bar.x = 420 + 140;
		bar.y = 45;
		addChild(bar);
		
		//cursor.
		cursor = new VerticalMovingCursor();
		cursor.x = 405 + 140;
		cursor.y = 110;
		addChild(cursor);

		//sounds
		good = Assets.getSound("audio/coin.wav");
		bad = Assets.getSound("audio/hurt.wav");
		fall = Assets.getSound("audio/fall.wav");
		
		
		//cables begind box
		cables = new Bitmap(Assets.getBitmapData("img/elevatorCable.png"));
		addChild(cables);
		
		
		//score text
		txt = new BitmapText(font, "score: 0", Main.WIDTH, null, 7	);
		txt.y = Main.HEIGHT - 50;
		txt.x = 50;
		
		//elevator box;
		elevatorBox = new Sprite();
		elevatorBox.addChild(new Bitmap(Assets.getBitmapData("img/elevatorBoxWired.png")));
		elevatorBox.x = 35;
		elevatorBox.y = 390+570;
		addChild(elevatorBox);
		

		
		//hideo
		var hideoSheet = new Mapsheet(Assets.getBitmapData("img/hideo.png"));
		hideoSheet.slice(5, 4);
		hideoSheet.addBehavior(new Behavior("idle", [0], true));
		hideoSheet.addBehavior(new Behavior("good", [0,0,0,0, 1,0], false, 10));
		hideoSheet.addBehavior(new Behavior("meh", [0,0,0,5, 6, 7], false, 10));
		hideoSheet.addBehavior(new Behavior("bad", [0,0,10,11,12,12,12,12,12],false,10));
		hideoSheet.addBehavior(new Behavior("suicide", [0,0,15,16,17,18,19,0],false,7));
		
		hideo = new Animation(hideoSheet);
		hideo.showBehavior("idle");
		hideo.x = 70;
		hideo.y = 245 +350 + 570;
		
		//luli
		var luSheet = new Mapsheet(Assets.getBitmapData("img/lu.png"));
		luSheet.slice(5, 4);
		luSheet.addBehavior(new Behavior("idle", [0], true));
		luSheet.addBehavior(new Behavior("talk", [0, 1, 0, 1],false, 10));
		luSheet.addBehavior(new Behavior("bad", [0,1,0,1,0,5, 6, 7, 7], false, 10));
		luSheet.addBehavior(new Behavior("fuckup", [5, 6, 7, 7], false, 10));
		lu = new Animation(luSheet);
		lu.showBehavior("idle");
		addChild(lu);
		lu.x = 200;
		lu.y = 245 +350 + 570;
		
		addChild(hideo);
		//--
		
		//doorContainer
		doors = new DoorAnimation();
		doors.x = 35;
		doors.y = 175 +350 +570;
		addChild(doors);
		
		
		btnAbout = new Image(Assets.getBitmapData("img/btnAbout.png"), 5, null, false);
		btnAbout .x = 70;
		btnAbout.y = -100;
		btnAbout.addEventListener(MouseEvent.CLICK, goAbout);
		addChild(btnAbout);
		
		btnHelp = new Image(Assets.getBitmapData("img/btnHelp.png"), 5, null, false);
		btnHelp .x = 270;
		btnHelp.y = -100;
		btnHelp.addEventListener(MouseEvent.CLICK, goHelp);
		addChild(btnHelp);
		
		title = new Image(Assets.getBitmapData("img/title.png"), 5, null, false);
		title.x = 270;
		title.y	= -title.height;
		addChild(title);
		
		tap = new Image(Assets.getBitmapData("img/tap.png"), 5, null, false);
		tap.x = 270;
		tap.y	= -tap.height;
		addChild(tap);
		
		Actuate.timer(1).onComplete(tweenToMenustate);
	}
	
	var helpDialog :HelpScreen;
	
	function goHelp(e:MouseEvent):Void 
	{
		if (state != "MENU") return;
		trace ("going help");
		state = "ANIMATING";
		helpDialog = new HelpScreen();
		//helpDialog.y = -helpDialog.height;
		helpDialog.y = -helpDialog.height;
		helpDialog.x = 20;
		addChild(helpDialog);
		Actuate.tween(helpDialog, 1, {y: 115 }).ease(Elastic.easeOut).onComplete(function () {state = "HELP"; });

	}
	
	var aboutDialog:AboutScreen;
	var emergencyBG:Bitmap;
	var title:engine.image.Image;
	var tap:engine.image.Image;
	
	function goAbout(e:MouseEvent):Void 
	{
		if (state != "MENU") return;
		trace ("going about");
		state = "ANIMATING";
		aboutDialog = new AboutScreen();
		aboutDialog.y = -aboutDialog.height;
		aboutDialog.x = 20;
		addChild(aboutDialog);
		Actuate.tween(aboutDialog, 1, {y: 115 }).ease(Elastic.easeOut).onComplete(function () {state = "ABOUT"; });
		
	}
	

	
	function tweenToMenustate() 
	{
		Actuate.tween(elevatorBox, 2, {y:390});
		Actuate.tween(hideo, 2, {y:245+350});
		Actuate.tween(lu, 2, {y:245+350});
		Actuate.tween(doors, 2, {y:175 + 350});
		Actuate.tween(btnAbout, 1,{y:75});
		Actuate.tween(btnHelp, 1, {y:75});
		Actuate.tween(title, 1, {y:280});
		Actuate.tween(tap, 1, {y:720});
		Actuate.timer(2.2).onComplete(function(){state = "MENU"; });
		//then the buttons and the logo.
		
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
						lu.showBehaviors(["talk","idle"]);
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
						lu.showBehaviors(["talk","idle"]);
						
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
						lu.showBehaviors(["bad","idle"]);
						
						var staticY:Float = cursor.y;
						var scoreThingy:BitmapText = new BitmapText(font, "-1", 100, null, 4);
						scoreThingy.y = staticY;
						scoreThingy.x = 350;
						addChild(scoreThingy);
						Actuate.tween(scoreThingy, 0.5, {y:staticY - 20, alpha:0}).delay(0.1).onComplete(removeChild, [scoreThingy]);
					
						if (score == -3) //you killed hideo.
						{
							state = "SUICIDE";
							hideo.showBehavior("suicide");
							lu.showBehavior("fuckup");
							Actuate.tween(hideo, 0.5, {y:Main.HEIGHT}).delay(1.5).onComplete(endGame).ease(Quad.easeIn);
							Actuate.timer(1.5).onComplete(fall.play);
							
						}
					}
					
					cursor.taped();
					txt.text = "score: " + Std.string(score);
				}		
			}
			
			case "MENU":{
				
				//ill planing right here.
				
				if (btnAbout.hitTestPoint(mouseX, mouseY) || btnHelp.hitTestPoint(mouseX, mouseY)) return;
				
				state = "ANIMATING"; //inexistent state
				cursor.reset();
				Actuate.tween(bar , 0.5, {x : 420}).ease(Linear.easeNone);
				Actuate.tween(cursor , 0.5, {x : 405}).ease(Linear.easeNone);
				Actuate.tween(btnAbout, 0.5, {y: -100}).ease(Linear.easeNone);
				Actuate.tween(btnHelp, 0.5, {y: -100}).ease(Linear.easeNone);
				Actuate.tween(title, 0.5, {y: -title.height}).ease(Linear.easeNone);
				Actuate.tween(tap, 0.5, {y: -tap.height}).ease(Linear.easeNone);
				
				Actuate.timer(1.7).onComplete(function () {
					state = "GAME";
					Actuate.tween(lazybg, 15, {y:0}).ease(Linear.easeNone).onComplete(endGame);
					Actuate.tween(rustyPipes, 15, {y:0}).ease(Linear.easeNone);
					addChild(txt);
				});
				
				//start position.
				Actuate.tween(doors, 1, {y:175}).ease(Quad.easeOut);
				Actuate.tween(hideo, 1, {y:245}).ease(Quad.easeOut);
				Actuate.tween(lu, 1, {y:245}).ease(Quad.easeOut);
				Actuate.tween(elevatorBox, 1, {y:40}).ease(Quad.easeOut).onComplete(doors.openDoor);
				
			}
			case "GAMEOVER":{
				state = "ANIMATING"; //inexistent state
				lazybg.y = -lazybg.height + Main.HEIGHT;
				rustyPipes.y = -rustyPipes.height + Main.HEIGHT;
				bar.x = 420 + 140;
				bar.y = 45;
				cursor.x = 405 + 140;
				cursor.y = 110;
				score = 0;
				elevatorBox.y = 390+570;
				hideo.showBehavior("idle");
				hideo.y = 245 +350+570;
				lu.showBehavior("idle");
				lu.y = 245 +350 + 570;
				doors.y = 175 +350 + 570;
				
				Actuate.tween(scoreCart, 1, {y:Main.HEIGHT}).ease(Elastic.easeIn).onComplete(function () {removeChild(scoreCart); tweenToMenustate(); });
				
			}
			case "ABOUT":{
				state = "ANIMATING";
				Actuate.tween(aboutDialog, 1, {y:-aboutDialog.height}).ease(Elastic.easeIn).onComplete(function () {removeChild(aboutDialog); state = "MENU"; });
				//exit and then go to play state.
			}
			
			case "HELP":{
				state = "ANIMATING";
				Actuate.tween(helpDialog, 1, {y:-helpDialog.height}).ease(Elastic.easeIn).onComplete(function () {removeChild(helpDialog); state = "MENU"; });
				//exit and then go to play state.
			}
			default:

		}
	}
	
	function endGame() 
	{
		Actuate.stop(lazybg, null, false, false); //just in case.
		trace ("gaming over. state: " + state);
		if (state != "GAME" && state != "SUICIDE") return;
		
		if (state == "GAME") Actuate.tween(hideo, 1, {y:245-570}).ease(Quad.easeOut);
		
		state = "ANIMATING";
		//end position.
		Actuate.timer(0.1).onComplete(doors.closeDoor);
		Actuate.tween(doors, 1, {y:175-570}).ease(Quad.easeOut);
		Actuate.tween(lu, 1, {y:245-570}).ease(Quad.easeOut);
		Actuate.tween(elevatorBox, 1, {y:40 -570}).ease(Quad.easeOut);
		Actuate.tween(bar , 0.5, {x : 420+140}).ease(Linear.easeNone);
		Actuate.tween(cursor , 0.5, {x : 405 + 140}).ease(Linear.easeNone);
						removeChild(txt);
		
		scoreCart = new ScoreScreen(score);
		scoreCart.y = Main.HEIGHT;
		addChild(scoreCart);
		scoreCart.x = 20;
		Actuate.tween(scoreCart, 1, {y: 115 }).ease(Elastic.easeOut).delay(1).onComplete(function () {state = "GAMEOVER"; });
		
		
		//bring the score screen.
		
	}
	
	
	
	
	/* UPDATE aqui viene lo bueno señores. */
	private function update(e:Event = null):Void{
		currentTime = Lib.getTimer ();
		dt = (currentTime - previousTime);
		previousTime = currentTime;
		
		//maybe always animate?
		hideo.update(dt);
		lu.update(dt);
		
		//about
		if (aboutDialog != null) aboutDialog.update(dt);
		
		switch (state) 
		{
			case "GAME":
				cursor.update(dt);
				emergencyBG.y += dt * 0.5;
				if (emergencyBG.y >=0) 
				{
					emergencyBG.y = -944;
				}
			default:
				
		}

	}
	
}