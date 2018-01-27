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
	
	public var speed:Float = 0.1;
	
	public function new() 
	{
		super();
		graphics.beginFill(0xFFFFFF);
		graphics.lineStyle(5, 0);
		graphics.drawRect(0, 0, 135, 20);
		graphics.endFill();
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
		}else if (y >= BOT_SCROLL)
		{
			y = BOT_SCROLL;
			isGoingUp = true;
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
	
}