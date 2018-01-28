package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Preloader;
import openfl.display.Sprite;
import openfl.events.ProgressEvent;




@:bitmap("assets/preloader/preloader.jpg") class Back extends BitmapData { }


class CustomPreloader extends Preloader
{	
	private var back:Bitmap;


	
	public function new() 
	{
		
		display = new Sprite();
		
		back = new Bitmap( new Back(0, 0));

		
		display.addChild(back);
		
		display.addEventListener(ProgressEvent.PROGRESS, progress);
		
		super(display);
		
	}
	
	public function progress(e:ProgressEvent)
	{
		if (e.bytesTotal <= 0) return;
		var percentLoaded = e.bytesLoaded / e.bytesTotal;
		if (percentLoaded > 1) percentLoaded = 1;
		
	}	
}