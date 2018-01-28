package game;

import openfl.display.Sprite;

/**
 * ...
 * @author Elemental Code
 */
class VerticalMovingCursor extends Sprite 
{
	public static inline var TOP_SCROLL:Int = 55;
	public static inline var BOT_SCROLL:Int = 885;

	private var isGoingUp:Bool = false;
	public var canTap:Bool = true;
	
	public var speed:Float = 0.6;
	
	public function new() 
	{
		super();

		enableTap();
	}
	
	public function update(dt)
	{
		if (isGoingUp) 
		{
			y -=  speed * dt;
		}
		else 
		{
			y += speed * dt;
		}
		
		if (y <= TOP_SCROLL) 
		{
			y = TOP_SCROLL;
			isGoingUp = false;
			enableTap();
		}else if (y >= BOT_SCROLL)
		{
			y = BOT_SCROLL;
			isGoingUp = true;
			enableTap();
		}
	}
	
	public function speedUp()
	{
		speed += 0.1;
	}
	
	public function speedDown()
	{
		speed -= 0.1;
		if (speed < 0.1) speed = 0.1;
	}
	
	public function taped() 
	{
		graphics.clear();
		graphics.beginFill(0xFFFFFF,0);
		graphics.lineStyle(5, 0);
		graphics.drawRect(0, 0, 135, 20);
		graphics.endFill();
		canTap = false;
	}
	
	public function enableTap()
	{
		graphics.clear();
		graphics.beginFill(0xFFFFFF,1);
		graphics.lineStyle(5, 0);
		graphics.drawRect(0, 0, 135, 20);
		graphics.endFill();
		canTap = true;
	}
	
	public function reset() 
	{
		enableTap();
		speed = 0.6;
		isGoingUp = false;
	}
	
}