package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:pathy12:img%2Fbg.pngy4:sizei58102y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y15:img%2Fboard.pngR2i20233R3R4R5R7R6tgoR0y18:img%2FbtnAbout.pngR2i3113R3R4R5R8R6tgoR0y17:img%2FbtnHelp.pngR2i3139R3R4R5R9R6tgoR0y18:img%2FbtnScore.pngR2i3161R3R4R5R10R6tgoR0y17:img%2Fcredits.pngR2i11212R3R4R5R11R6tgoR0y28:img%2FcreditsMockupBoard.pngR2i77884R3R4R5R12R6tgoR0y18:img%2FdoorLeft.pngR2i18056R3R4R5R13R6tgoR0y19:img%2FdoorRight.pngR2i18002R3R4R5R14R6tgoR0y19:img%2Fdoorsmask.pngR2i2918R3R4R5R15R6tgoR0y24:img%2FdummyBGforBugs.pngR2i119971R3R4R5R16R6tgoR0y21:img%2FelevatorBox.pngR2i19127R3R4R5R17R6tgoR0y26:img%2FelevatorBoxWired.pngR2i43684R3R4R5R18R6tgoR0y23:img%2FelevatorCable.pngR2i6193R3R4R5R19R6tgoR0y18:img%2Fgaugetap.pngR2i2816R3R4R5R20R6tgoR0y15:img%2Fhideo.pngR2i14444R3R4R5R21R6tgoR0y12:img%2Flu.pngR2i10882R3R4R5R22R6tgoR0y20:img%2FpopupBoard.pngR2i24689R3R4R5R23R6tgoR0y20:img%2FpopupBoard.psdR2i748759R3y6:BINARYR5R24R6tgoR0y25:img%2FpopupHelpMockup.pngR2i33172R3R4R5R26R6tgoR0y19:img%2Fpreloader.jpgR2i71312R3R4R5R27R6tgoR0y20:img%2FrustyPipes.pngR2i28429R3R4R5R28R6tgoR0y14:img%2Ftest.jpgR2i51728R3R4R5R29R6tgoR0y23:img%2FverticalGauge.pngR2i18661R3R4R5R30R6tgoR0y19:fonts%2Fvisitor.pngR2i3962R3R4R5R31R6tgoR0y19:fonts%2Fvisitor.xmlR2i10509R3y4:TEXTR5R32R6tgoR2i15528R3y5:SOUNDR5y16:audio%2Fcoin.wavy9:pathGroupaR35hR6tgoR2i139284R3R34R5y16:audio%2Ffall.wavR36aR37hR6tgoR2i6068R3R34R5y16:audio%2Fhurt.wavR36aR38hR6tgoR0y34:assets%2Fpreloader%2Fpreloader.jpgR2i71312R3R4R5R39R6tgh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__img_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_board_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btnabout_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btnhelp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_btnscore_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_creditsmockupboard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_doorleft_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_doorright_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_doorsmask_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_dummybgforbugs_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_elevatorbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_elevatorboxwired_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_elevatorcable_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_gaugetap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hideo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_lu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_popupboard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_popupboard_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__img_popuphelpmockup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_preloader_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_rustypipes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_test_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_verticalgauge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__fonts_visitor_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__audio_coin_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__audio_fall_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__audio_hurt_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_preloader_preloader_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:image("assets/img/bg.png") #if display private #end class __ASSET__img_bg_png extends lime.graphics.Image {}
@:image("assets/img/board.png") #if display private #end class __ASSET__img_board_png extends lime.graphics.Image {}
@:image("assets/img/btnAbout.png") #if display private #end class __ASSET__img_btnabout_png extends lime.graphics.Image {}
@:image("assets/img/btnHelp.png") #if display private #end class __ASSET__img_btnhelp_png extends lime.graphics.Image {}
@:image("assets/img/btnScore.png") #if display private #end class __ASSET__img_btnscore_png extends lime.graphics.Image {}
@:image("assets/img/credits.png") #if display private #end class __ASSET__img_credits_png extends lime.graphics.Image {}
@:image("assets/img/creditsMockupBoard.png") #if display private #end class __ASSET__img_creditsmockupboard_png extends lime.graphics.Image {}
@:image("assets/img/doorLeft.png") #if display private #end class __ASSET__img_doorleft_png extends lime.graphics.Image {}
@:image("assets/img/doorRight.png") #if display private #end class __ASSET__img_doorright_png extends lime.graphics.Image {}
@:image("assets/img/doorsmask.png") #if display private #end class __ASSET__img_doorsmask_png extends lime.graphics.Image {}
@:image("assets/img/dummyBGforBugs.png") #if display private #end class __ASSET__img_dummybgforbugs_png extends lime.graphics.Image {}
@:image("assets/img/elevatorBox.png") #if display private #end class __ASSET__img_elevatorbox_png extends lime.graphics.Image {}
@:image("assets/img/elevatorBoxWired.png") #if display private #end class __ASSET__img_elevatorboxwired_png extends lime.graphics.Image {}
@:image("assets/img/elevatorCable.png") #if display private #end class __ASSET__img_elevatorcable_png extends lime.graphics.Image {}
@:image("assets/img/gaugetap.png") #if display private #end class __ASSET__img_gaugetap_png extends lime.graphics.Image {}
@:image("assets/img/hideo.png") #if display private #end class __ASSET__img_hideo_png extends lime.graphics.Image {}
@:image("assets/img/lu.png") #if display private #end class __ASSET__img_lu_png extends lime.graphics.Image {}
@:image("assets/img/popupBoard.png") #if display private #end class __ASSET__img_popupboard_png extends lime.graphics.Image {}
@:file("assets/img/popupBoard.psd") #if display private #end class __ASSET__img_popupboard_psd extends haxe.io.Bytes {}
@:image("assets/img/popupHelpMockup.png") #if display private #end class __ASSET__img_popuphelpmockup_png extends lime.graphics.Image {}
@:image("assets/img/preloader.jpg") #if display private #end class __ASSET__img_preloader_jpg extends lime.graphics.Image {}
@:image("assets/img/rustyPipes.png") #if display private #end class __ASSET__img_rustypipes_png extends lime.graphics.Image {}
@:image("assets/img/test.jpg") #if display private #end class __ASSET__img_test_jpg extends lime.graphics.Image {}
@:image("assets/img/verticalGauge.png") #if display private #end class __ASSET__img_verticalgauge_png extends lime.graphics.Image {}
@:image("assets/fonts/visitor.png") #if display private #end class __ASSET__fonts_visitor_png extends lime.graphics.Image {}
@:file("assets/fonts/visitor.xml") #if display private #end class __ASSET__fonts_visitor_xml extends haxe.io.Bytes {}
@:file("assets/audio/coin.wav") #if display private #end class __ASSET__audio_coin_wav extends haxe.io.Bytes {}
@:file("assets/audio/fall.wav") #if display private #end class __ASSET__audio_fall_wav extends haxe.io.Bytes {}
@:file("assets/audio/hurt.wav") #if display private #end class __ASSET__audio_hurt_wav extends haxe.io.Bytes {}
@:image("assets/preloader/preloader.jpg") #if display private #end class __ASSET__assets_preloader_preloader_jpg extends lime.graphics.Image {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)



#end
#end