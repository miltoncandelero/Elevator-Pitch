package game;


import motion.Actuate;
import motion.easing.Linear;
import motion.easing.Quad;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Elemental Code
 */
class DoorAnimation extends Sprite 
{
	var LeftDoor:Bitmap;
	var RightDoor:Bitmap;

	public function new() 
	{
		super();
		var sMask:Sprite = new Sprite();
		sMask.graphics.beginFill(0x0);
		sMask.graphics.drawRect(0, 0, 295, 345);
		sMask.x = 30;
		sMask.y = 25;
		addChild(sMask);
		mask = sMask;
		
		LeftDoor = new Bitmap(Assets.getBitmapData("img/doorLeft.png"));
		LeftDoor.x = 25;
		LeftDoor.y = 25;
		addChild(LeftDoor);
		
		RightDoor = new Bitmap(Assets.getBitmapData("img/doorRight.png"));
		RightDoor.x = 175;
		RightDoor.y = 25;
		addChild(RightDoor);
	}
	
	
	public function openDoor(time:Float = 0.5)
	{
		Actuate.tween(LeftDoor, time, {x: 25 - LeftDoor.width}).ease(Quad.easeOut);
		Actuate.tween(RightDoor, time, {x: 175 + RightDoor.width}).ease(Quad.easeOut);
	}
	
	public function closeDoor(time:Float = 0.5)
	{
		Actuate.tween(LeftDoor, time, {x: 25}).ease(Quad.easeOut);
		Actuate.tween(RightDoor, time, {x: 175}).ease(Quad.easeOut);
	}
	
	public function closeDoorAndAlphaFade(doortime:Float = 0.5, fadetime:Float = 0.5)
	{
		Actuate.tween(LeftDoor, doortime, {x: 25}).ease(Quad.easeOut);
		Actuate.tween(RightDoor, doortime, {x: 175}).ease(Quad.easeOut).onComplete(function ()
		{
			Actuate.tween(this, fadetime, {alpha:0}).delay(0.2).ease(Linear.easeNone);
		});
	}
	
	
}