package game;

import engine.bitmaptext.BitmapText;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;

/**
 * ...
 * @author Elemental Code
 */
class ScoreScreen extends Sprite 
{

	public function new(iScore:Int) 
	{
		super();
		addChild(new Bitmap(Assets.getBitmapData("img/popupBoard.png")));

		var txtGameOver:BitmapText = new BitmapText(ElevatorGame.font, "GAME\nOVER", Main.WIDTH, 36*2, 4);
		txtGameOver.scaleX = txtGameOver.scaleY = 2;
		txtGameOver.x = 93; 
		txtGameOver.y = 570; 
		addChild(txtGameOver);
		
		var txtScore:BitmapText = new BitmapText(ElevatorGame.font, "score", Main.WIDTH, 36, 4);
		
		txtScore.x = 145; 
		txtScore.y = 710; 
		addChild(txtScore);
		
		var txtScoreNumber:BitmapText = new BitmapText(ElevatorGame.font, ((iScore < 10 && iScore >-1)?" " + Std.string(iScore): Std.string(iScore)), Main.WIDTH, 36, 4);
		txtScoreNumber.scaleX = txtScoreNumber.scaleY = 4;
		
		txtScoreNumber.x = 100; 
		if (iScore > 9 && iScore < 20) txtScoreNumber.x += 15;
		if (iScore > 1 && iScore < 10 || iScore == 0) txtScoreNumber.x -= 10; //4:16 AM. Works for me.
		if (iScore == 11) txtScoreNumber.x += 37;
		txtScoreNumber.y = 800; 
		addChild(txtScoreNumber);
		
		
	}
	
}