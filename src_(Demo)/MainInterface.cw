package  { 
	
	import GZ.Sys.Interface.Interface;
	
	
	//import GZ.Gfx.Object;
//	import GZ.Gfx.Screen.Redraw;
	
	import GZ.Sys.Interface.Window;
	//import GZ.File.RcImg;
//	import GZ.Gfx.Root;
	
	
	//import GZ.Gfx.Clip.Img;
	import GZ.Gfx.Clip;
	
	import GZ.File.RcImg;
	//import Demo.Screen.DemoRoll;
	//import Demo.Screen.FpsCount;
	import Demo.Screen.DemoNima;
	
	import GZ.Gpu.ShaderModel.GzModel.GzShModel;
	import GZ.Gpu.ShaderModel.GzModel.GzShModel_Minimal;
	import GZ.Gpu.ShaderModel.GzModel.GzShModel_Quad.GzShModel_Quad;
	import GZ.Gpu.ShaderModel.GzModel.GzShModel_Raymarching;
	import GZ.Gpu.ShaderModel.GzModel.GzShModel_Shadertoy;
	
	

 //	import Demo.Screen.DemoArrow;
	
	import GZ.Base.Math.Math;
	
	import GZ.Base.Thread.Thread;
	import GZ.Sys.ThreadItf;
	
	import GZ.Base.Mat4x4;
	import GZ.Base.Perspective;
	import GZ.Gfx.Clip.Img;


	public thread<ThreadItf> MainInterface extends Interface {
		
		use Window.eWinClick;
		use Window.eWinBorder;
		
		public var oDemo : Clip;
		//public var aDemoArrow : Array<DemoArrow>;
		public	var oImg : Img;
	//	public var oGzShModel : GzShModel;
		
	//	public var oFps : FpsCount;
		
//		public var oImg : Img;
		
	//	public evar mTest : Mat4x4;
//		public var oPersv : Perspective;


		//public var nNbArrowInst : Int = 20;
		public var nNbArrowInst : Int = 1;
		
	
		public function MainInterface( _oThreadItf : ThreadItf ):Void {
			//!New thread started, this and subclass are isolated for thread safety
			//!Select rendering on GPU on CPU, default, true
			
	
			bGpuDraw = false;
			bGpuDraw = true;
			
			
			//!Make window transparent (Render or CPU)
			var _bTranparent : Bool = false;
			_bTranparent = false;
			
			//Create a new windows
			Interface(_oThreadItf, "GroundZero", 800, 600, _bTranparent, 0xFFFFFFFF);

			fCreateInterface(300,100);
		}
		
		
		
		override public function fLoadShader():Bool {
			oGzShModel = new GzShModel_Quad();
			//oGzShModel = new GzShModel_Minimal();
			//oGzShModel = new GzShModel_Shadertoy();
			return true;
		}
		
		
		
		
		override public function fWinStart():Void {
			
			oDemo = new DemoNima(this);
					
		
		}
		
		
		override public function fUpdateChildToParent():Void {
				
			//!Updated each frame, parents before
		}
		
		
		override public function fUpdateParentToChild():Void {
			//!Updated each frame, childs before
		}
		
	}
}