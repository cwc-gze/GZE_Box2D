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
	import GzBox2D.Vector.B2Vec2;
	
	
	<cpp_h>
	#include "Box2D/Box2D.h"
	</cpp_h>
	

	/**
	 * @author Maeiky
	 */
	public class DemoBox2d extends Clip {

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
	
		<cpp_class_h>
			b2World* oWorld;
			b2Body* oBody;
		</cpp_class_h>
	
		
		public function DemoBox2d( _oParent : Root ):Void {
			Clip(_oParent, _oParent.oItf.nHalfFrameWidth,  _oParent.oItf.nHalfFrameHeight);
			
			
			
			var _vGravity : B2Vec2<Float> = new B2Vec2<Float>();
			_vGravity.nX = 0;
			_vGravity.nY = 10;
			
			
			<cpp>
				// Construct a world object, which will hold and simulate the rigid bodies.
				//b2World world(_vGravity.vB2d);
				oWorld =  new b2World(_vGravity.vB2d);
				
			
				// Define the ground body.
				b2BodyDef groundBodyDef;
				groundBodyDef.position.Set(0.0f, 10.0f);

				// Call the body factory which allocates memory for the ground body
				// from a pool and creates the ground box shape (also from a pool).
				// The body is also added to the world.
				b2Body* groundBody = oWorld->CreateBody(&groundBodyDef);

				// Define the ground box shape.
				b2PolygonShape groundBox;

				// The extents are the half-widths of the box.
				groundBox.SetAsBox(50.0f, 10.0f, b2Vec2(0,0), 0.785 );

				// Add the ground fixture to the ground body.
				groundBody->CreateFixture(&groundBox, 0.0f);

				// Define the dynamic body. We set its position and call the body factory.
				b2BodyDef bodyDef;
				bodyDef.type = b2_dynamicBody;
				bodyDef.position.Set(0.0f, -4.0f);
				oBody = oWorld->CreateBody(&bodyDef);

				// Define another box shape for our dynamic body.
				b2PolygonShape dynamicBox;
				dynamicBox.SetAsBox(1.0f, 1.0f);

				// Define the dynamic body fixture.
				b2FixtureDef fixtureDef;
				fixtureDef.shape = &dynamicBox;

				// Set the box density to be non-zero, so it will be dynamic.
				fixtureDef.density = 1.0f;

				// Override the default friction.
				fixtureDef.friction = 0.3f;

				// Add the shape to the body.
				oBody->CreateFixture(&fixtureDef);
					
					
				 b2Fixture* F = oBody->GetFixtureList();             
					while(F != NULL)
					{
						switch (F->GetType())
						{
							case b2Shape::e_circle:
							{
								b2CircleShape* circle = (b2CircleShape*) F->GetShape();                     
								printf("\n------CircleShape");
							}
							break;

							case b2Shape::e_polygon:
							{
								b2PolygonShape* poly = (b2PolygonShape*) F->GetShape();
								/* Do stuff with a polygon shape */
									printf("\n------b2PolygonShape");
							}
							break;
						}
						F = F->GetNext();
					}	
					
					
					
			
				
			</cpp>
			
			
			
			
			
			
			
			

			
			
			
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
			
			oVectorShape.oShape.aNewPt3dOri[0].vPt.nX = 50;
			
		}	

		
		override public function fUpdateParentToChild():Void {
		
		
			var _nX : Float = 0;
			var _nY  : Float = 0;
			var _nAngle  : Float = 0;
			<cpp>
			// Prepare for simulation. Typically we use a time step of 1/60 of a
				// second (60Hz) and 10 iterations. This provides a high quality simulation
				// in most game scenarios.
				float32 timeStep = 1.0f / 60.0f;
				int32 velocityIterations = 6;
				int32 positionIterations = 2;
				
			// Instruct the world to perform a single step of simulation.
			// It is generally best to keep the time step and iterations fixed.
			oWorld->Step(timeStep, velocityIterations, positionIterations);

			// Now print the position and angle of the body.
			b2Vec2 position = oBody->GetPosition();
			float32 angle = oBody->GetAngle();

			
			_nX = position.x;
			_nY = position.y;
			_nAngle = angle;
			//printf("%4.2f %4.2f %4.2f\n", position.x, position.y, angle);
		///////////////////////////////////
			</cpp>
		
		oVectorShape.vPos.nX = _nX;
		oVectorShape.vPos.nY = _nY;
			oVectorShape.vRot.nRoll = _nAngle;	
		
		//	oVectorShape.oShape.aNewPt3dOri[0].vPt.nX = 50;
		
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
