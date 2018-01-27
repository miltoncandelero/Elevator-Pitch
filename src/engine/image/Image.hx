package engine.image;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Milton Candelero @ Killabunnies
 * For the Alpha Engine.
 */
class Image extends Sprite
{
	public static inline var TOP_LEFT = 7;
	public static inline var TOP_CENTER = 8;
	public static inline var TOP_RIGHT = 9;
	
	public static inline var LEFT = 4;
	public static inline var CENTER = 5;
	public static inline var RIGHT = 6;
	
	public static inline var BOTTOM_LEFT = 1;
	public static inline var BOTTOM_CENTER = 2;
	public static inline var BOTTOM_RIGHT = 3;
	
	public var bitmap: Bitmap;
	public var bitmapData:BitmapData;

	
	/**
	 * 
	 * @param	bitmapData The bitmapData to show
	 * @param	align Look at your numpad. 5 is the center. (You have it nomenclated as constants also)
	 * @param	centerAt If you use this value, the align is ignored. Manually set the center of your image.
	 */
	public function new(bitmapData:BitmapData, ?align:Int = 7, ?centerAt:Null<Point>, ?smoothing:Bool = true) 
	{
		this.bitmapData = bitmapData;
		bitmap = new Bitmap(bitmapData, null, smoothing);
		
		if (centerAt == null) 
		{
			setAlign(align);
		}else 
		{
			bitmap.x =  - centerAt.x;
			bitmap.y =  - centerAt.y;
		}
		super();
		
		addChild(bitmap);
	}
	
	/**
	 * Look at your numpad.
	 * 
	 * 7|8|9
	 * 4|5|6
	 * 1|2|3
	 * 
	 * 5 is center, 7 is top-left, 3 is bottom-right
	 * @param	align Look at your numpad. 5 is the center. (You have it nomenclated as constants also)
	 */
	public function setAlign(align:Int)
	{
		switch (align) 
		{
			case TOP_LEFT:
				bitmap.x = bitmap.y = 0;
			case TOP_CENTER:
				bitmap.x = -bitmap.width / 2;
				bitmap.y = 0;
			case TOP_RIGHT:
				bitmap.x = -bitmap.width;
				bitmap.y = 0;
				
			case LEFT:
				bitmap.x = 0;
				bitmap.y = -bitmap.height/2;
			case CENTER:
				bitmap.x = -bitmap.width / 2;
				bitmap.y = -bitmap.height/2;
			case RIGHT:
				bitmap.x = -bitmap.width;
				bitmap.y = -bitmap.height/2;

			case BOTTOM_LEFT:
				bitmap.x = 0;
				bitmap.y = -bitmap.height;
			case BOTTOM_CENTER:
				bitmap.x = -bitmap.width / 2;
				bitmap.y = -bitmap.height;
			case BOTTOM_RIGHT:
				bitmap.x = -bitmap.width;
				bitmap.y = -bitmap.height;
			default:
				
		}
	}
	
	/**
	 * Allows you to pick the center of the bitmap. The bitmap will take X and Y positions equal to negative the value you give.
	 * @param	centerX X-coordinate of the center
	 * @param	centerY Y-coordinate of the center
	 */
	public function setCenter(centerX:Float, centerY:Float)
	{
		bitmap.x =  - centerX;
		bitmap.y =  - centerY;
	}
}