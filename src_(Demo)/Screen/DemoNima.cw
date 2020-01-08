package  {

	import GZ.Sys.Interface.Context;
	import GZ.Gfx.Object;

	import GZ.File.RcImg;
	import GZ.Gfx.Clip.Letter;
	import GZ.File.RcFont;
	import GZ.Gfx.Root;

	import GZ.Sys.Interface.Interface;
	import GZ.Gfx.Clip;
	import GZ.Gfx.Clip.Text;

	import GZ.Base.Math.Math;

	import GZ.Gfx.Clip.Img;
	import GZ.Gfx.Clip.ButtonImg;
	import GZ.Gfx.Vector.VectorShape;
	import GZ.Gfx.Vector.Line;
	import GZ.Gfx.Vector.HalfLine;
	import GZ.Base.Quaternion;
	import GZ.Gpu.ShaderModel.AtModel.Attribute_Quad;
	import GZ.Base.PtA;
	
	import GzNima.Runtime.NmActor;

	/**
	 * @author Maeiky
	 */
	public class DemoNima extends Clip {

		public var oImg : Img;
		public var oLetter : Letter;
		public var oText : Text;
		public var oText2 : Text;
		public var oTitle : Text;
		public var nAdd : Int = 0;
		
		
		
		public var oLine : Line;
		public var oVectorShape : VectorShape;
		
		public var oButton : ButtonImg;
		public var oNmActor : NmActor;
		
		
		
		public function DemoNima( _oParent : Root ):Void {
			Clip(_oParent, _oParent.oItf.nHalfFrameWidth,  _oParent.oItf.nHalfFrameHeight);
			
			
			
			
			
			
			
			Debug.fTrace("----LoadFont ----");
		
		//	var _oFont : RcFont = new RcFont( "c:/extra_fonts/ProggyClean.ttf");
			var _oFont : RcFont = new RcFont( "Exe|Rc/Fonts/ProggyTiny.ttf", 10);
		//	var _oFont : RcFont = new RcFont("c:/extra_fonts/DroidSans.ttf");
		
	
			
			
			oNmActor = new NmActor(this, 0, 0);
				
			
			
			
			Debug.fTrace("--------");
			_oFont.fCpuLoad();
			
			
			Debug.fPass("DemoSize [" + _oFont.nWidth + " x " +  ( _oFont.nHeight) + "]" );

			
			if(Context.oItf.bGpuDraw){
				_oFont.fSetGpuTexLayer(Attribute_Quad.oTexFont);
				_oFont.fGpuLoad();
			}
			
			oImg = new Img(this, 100.0, 100.0, _oFont, true);

			
			oImg.vColor.nRed = 1.0;
			Debug.fTrace("--Finish-");

				
		
			oLetter = new Letter(this, _oFont, oItf.nHalfFrameWidth - 60,  oItf.nHalfFrameHeight* -1 +  60, 60);

			oLetter.vColor.nRed = 1.0;
			oLetter.vSize.nHeight = 2.0;
			oLetter.vSize.nWidth = 2.0;
			
			

			oText = new Text(this, _oFont,  oItf.nHalfFrameWidth * -1 + 60.0, -0.0, "Im a genius Testaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa12345678910");

			oText.vColor.nRed = 1.0;
			
			
			oText.oCurrRange.fClear();
			oText.oCurrRange.fAdd("Yeah");
			
			
			oTitle = new Text(this, _oFont,    oItf.nHalfFrameWidth * -1 + 40.0,   oItf.nHalfFrameHeight* -1 +  70.0, "[GroundZero Engine]");

			
			oTitle.vColor.nRed = 0.1;
			oTitle.vColor.nBlue = 0.2;
			oTitle.vColor.nGreen = 0.8;

			
			var _oInfo : Text =  new Text(this, _oFont,    oItf.nHalfFrameWidth * -1 + 200.0,   oItf.nHalfFrameHeight* -1 +  110.0, "Font Atlas:");
	
			oText2 = new Text(this, _oFont, 0.0, -30.0, "<Pixel Perfect Font!>");

			oText2.vColor.nRed = 0.0;
			oText2.vColor.nBlue = 1.0;
			oText2.vColor.nGreen = 0.0;
			

	/////////////////////////////////////////////////////////////////////////////////////////////				
			//oLine = new Line(this, new PtA(0 ,0), new PtA(200 , 200));
			oVectorShape = new VectorShape(this, 1.0);
						
			var _oImgRc : RcImg = new RcImg( "Exe|Rc/SimpleButton.png");
				_oImgRc.fCpuLoad();
			if(Context.oItf.bGpuDraw){
				_oImgRc.fSetGpuTexLayer(Attribute_Quad.oTexture);
			
				_oImgRc.fGpuLoad();
			}
			
			oButton = new ButtonImg(this, 0, 0, _oImgRc);
			
			
		}	

		
		override public function fUpdateParentToChild():Void {
		

			nAdd++;
			
			/*
			oText2.oCurrRange.fClear();
		
			var _sTest : String = "";
			_sTest = oTitle.oCurrRange.sText[1];
			oText2.oCurrRange.fAdd( _sTest );
			*/
			

			oText.oCurrRange.fClear();
			oText.oCurrRange.fAdd("Testing Number: " + nAdd);

		//return; //disable
			oLetter.vRot.nYaw = oLetter.vRot.nYaw + 0.1;
			//oLetter.vRot.nPitch = oLetter.vRot.nPitch + 0.1;
			
			var _nMouseX : Float = Context.nMouseX - oItf.nHalfFrameWidth;
			var _nMouseY : Float = Context.nMouseY - oItf.nHalfFrameHeight;

		
			
			if(Context.nMouseX < 0 || Context.nMouseY < 0  ||  Context.nMouseX >   oItf.nFrameWidth || Context.nMouseY >   oItf.nFrameHeight){
				vRot.nYaw.fTo(0);
				vRot.nPitch.fTo(0);
				//vRot.nYaw = 0;
				//vRot.nPitch = 0;
			}else{
				//!Updated each frame, parents before
				vRot.nYaw.fTo( _nMouseX / oItf.nHalfFrameWidth * -1.3);
				vRot.nPitch.fTo( _nMouseY / oItf.nHalfFrameHeight * -1.3);
			}
	
			
			
		}




	}
}
