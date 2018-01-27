package engine.bitmaptext;
import haxe.xml.Fast;
import openfl.display.BitmapData;

/**
 * ...
 * @author Milton Candelero @ Killabunnies
 * For the Alpha Engine.
 */
class BitmapFont
{
	public var X:Fast;
	public var B:BitmapData;
	public var C:List<Fast>;
	public var lineHeight:Int;
	
	public var charArray:Array<Char>;
	
	public function new(bmp:BitmapData,xml:String) 
	{
		this.B = bmp;
		
		X = new Fast(Xml.parse(xml));
		
		C = X.node.font.node.chars.nodes.char;
		
		charArray = new Array<Char>();
		
		for (i in C) 
		{
			var tmp:Char = { id: Std.parseInt(i.att.id), x: Std.parseInt(i.att.x), y: Std.parseInt(i.att.y), width: Std.parseInt(i.att.width), height: Std.parseInt(i.att.height), xoffset: Std.parseInt(i.att.xoffset), yoffset: Std.parseInt(i.att.yoffset),  xadvance: Std.parseInt(i.att.xadvance) };
			charArray.push(tmp);
		}
		
	trace (charArray);
			
		lineHeight = Std.parseInt(X.node.font.node.common.att.lineHeight);
	}
	
}


typedef Char =
{

	public var id :Int;
    public var x :Int;
    public var y :Int;
    public var width :Int;
    public var height :Int;
    public var xoffset :Int;
    public var yoffset :Int;
    public var xadvance :Int;
	
	/*public function new(id,x,y,width,height,xoffset,yoffset,xadvance) 
	{
		this.xadvance = xadvance;
		this.yoffset = yoffset;
		this.xoffset = xoffset;
		this.height = height;
		this.width = width;
		this.y = y;
		this.x = x;
		this.id = id;
	}*/
}