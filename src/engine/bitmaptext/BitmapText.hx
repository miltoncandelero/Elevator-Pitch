package engine.bitmaptext;

import engine.bitmaptext.BitmapFont.Char;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Milton Candelero @ Killabunnies
 * For the Alpha Engine.
 */
class BitmapText extends Sprite
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
	
	var container:Tilemap;
	var set:Tileset;
	var charMap:Map<Int,Int>;
	var cursorPosition:Point;
	var font:BitmapFont;
	public var text(default, set):String;
		
	public function new(font:BitmapFont,?text:String="",width:Int,?height:Null<Int>,?align:Int = 7) 
	{
		super();
		this.font = font;
		
		cursorPosition = new Point();
		charMap = new Map<Int,Int>();
		
		if (height == null) height = font.lineHeight;
		set = new Tileset(font.B);
		container = new Tilemap(width, height, set);
		addChild(container);
		
		for (i/*:Char*/ in font.charArray) 
		{
			charMap.set(i.id, set.addRect(new Rectangle(i.x, i.y, i.width, i.height)));
		}
		
		
		set_text(text); //setter
		setAlign(align);
	}
	
	
	function set_text(value:String):String 
	{
		//clear previous text
		container.removeTiles();
		cursorPosition.x = 0;
		cursorPosition.y = 0;
		
		//for each letter in the string
		for (i in 0...value.length) 
		{
			//get the char code
			var keyCode:Int = value.charCodeAt(i);
			
			//oopsie, thats a new line.
			if (keyCode == 10)  //"\n"
			{
				cursorPosition.y += font.lineHeight;
				cursorPosition.x = 0;
				continue;
			}
			
			//get the char for the char code
			var char = font.charArray.filter(function (c:Char) { return (c.id == keyCode); } )[0];
			if (char != null) //If the map knows how to print that char.
			{
				//print it
				container.addTile(new Tile(charMap.get(char.id), char.xoffset + cursorPosition.x, char.yoffset + cursorPosition.y));
				//move the cursor
				cursorPosition.x += char.xadvance;
			}
		}
		//just asign it for reading purposes.
		return text = value;
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
				container.x = container.y = 0;
			case TOP_CENTER:
				container.x = -container.width / 2;
				container.y = 0;
			case TOP_RIGHT:
				container.x = -container.width;
				container.y = 0;
				
			case LEFT:
				container.x = 0;
				container.y = -container.height/2;
			case CENTER:
				container.x = -container.width / 2;
				container.y = -container.height/2;
			case RIGHT:
				container.x = -container.width;
				container.y = -container.height/2;

			case BOTTOM_LEFT:
				container.x = 0;
				container.y = -container.height;
			case BOTTOM_CENTER:
				container.x = -container.width / 2;
				container.y = -container.height;
			case BOTTOM_RIGHT:
				container.x = -container.width;
				container.y = -container.height;
			default:
				
		}
	}
	
	/**
	 * Allows you to pick the center of the container. The container will take X and Y positions equal to negative the value you give.
	 * @param	centerX X-coordinate of the center
	 * @param	centerY Y-coordinate of the center
	 */
	public function setCenter(centerX:Float, centerY:Float)
	{
		container.x =  - centerX;
		container.y =  - centerY;
	}
	
}