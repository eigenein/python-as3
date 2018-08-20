package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.utils.formatString;
   
   public class DisplacementMapFilter extends FragmentFilter
   {
      
      private static var sOneHalf:Vector.<Number> = new <Number>[0.5,0.5,0.5,0.5];
      
      private static var sMapTexCoords:Vector.<Number> = new <Number>[0,0,1,0,0,1,1,1];
      
      private static var sMatrix:Matrix3D = new Matrix3D();
      
      private static var sMatrixData:Vector.<Number> = new <Number>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
       
      
      private var mMapTexture:Texture;
      
      private var mMapPoint:Point;
      
      private var mComponentX:uint;
      
      private var mComponentY:uint;
      
      private var mScaleX:Number;
      
      private var mScaleY:Number;
      
      private var mRepeat:Boolean;
      
      private var mShaderProgram:Program3D;
      
      private var mMapTexCoordBuffer:VertexBuffer3D;
      
      public function DisplacementMapFilter(param1:Texture, param2:Point = null, param3:uint = 0, param4:uint = 0, param5:Number = 0.0, param6:Number = 0.0, param7:Boolean = false)
      {
         mMapTexture = param1;
         mMapPoint = new Point();
         mComponentX = param3;
         mComponentY = param4;
         mScaleX = param5;
         mScaleY = param6;
         this.mapPoint = param2;
         super();
      }
      
      override public function dispose() : void
      {
         if(mMapTexCoordBuffer)
         {
            mMapTexCoordBuffer.dispose();
         }
         super.dispose();
      }
      
      override protected function createPrograms() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(mMapTexCoordBuffer)
         {
            mMapTexCoordBuffer.dispose();
         }
         mMapTexCoordBuffer = Starling.context.createVertexBuffer(4,2);
         var _loc5_:Starling = Starling.current;
         var _loc1_:String = RenderSupport.getTextureLookupFlags(mapTexture.format,mapTexture.mipMapping,mapTexture.repeat);
         var _loc6_:String = RenderSupport.getTextureLookupFlags("bgra",false,mRepeat);
         var _loc2_:String = formatString("DMF_m{0}_i{1}",_loc1_,_loc6_);
         if(_loc5_.hasProgram(_loc2_))
         {
            mShaderProgram = _loc5_.getProgram(_loc2_);
         }
         else
         {
            _loc3_ = ["m44  op, va0, vc0","mov  v0, va1","mov  v1, va2"].join("\n");
            _loc4_ = ["tex ft0,  v1, fs1 " + _loc1_,"sub ft1, ft0, fc0","m44 ft2, ft1, fc1","add ft3,  v0, ft2","tex  oc, ft3, fs0 " + _loc6_].join("\n");
            mShaderProgram = _loc5_.registerProgramFromSource(_loc2_,_loc3_,_loc4_);
         }
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         updateParameters(param3.nativeWidth,param3.nativeHeight);
         param2.setVertexBufferAt(2,mMapTexCoordBuffer,0,"float2");
         param2.setProgramConstantsFromVector("fragment",0,sOneHalf);
         param2.setProgramConstantsFromMatrix("fragment",1,sMatrix,true);
         param2.setTextureAt(1,mMapTexture.base);
         param2.setProgram(mShaderProgram);
      }
      
      override protected function deactivate(param1:int, param2:Context3D, param3:Texture) : void
      {
         param2.setVertexBufferAt(2,null);
         param2.setTextureAt(1,null);
      }
      
      private function updateParameters(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Number = Starling.contentScaleFactor;
         _loc8_ = 0;
         while(_loc8_ < 16)
         {
            sMatrixData[_loc8_] = 0;
            _loc8_++;
         }
         if(mComponentX == 1)
         {
            _loc7_ = 0;
         }
         else if(mComponentX == 2)
         {
            _loc7_ = 1;
         }
         else if(mComponentX == 4)
         {
            _loc7_ = 2;
         }
         else
         {
            _loc7_ = 3;
         }
         if(mComponentY == 1)
         {
            _loc5_ = 0;
         }
         else if(mComponentY == 2)
         {
            _loc5_ = 1;
         }
         else if(mComponentY == 4)
         {
            _loc5_ = 2;
         }
         else
         {
            _loc5_ = 3;
         }
         sMatrixData[int(_loc7_ * 4)] = mScaleX * _loc6_ / param1;
         sMatrixData[int(_loc5_ * 4 + 1)] = mScaleY * _loc6_ / param2;
         sMatrix.copyRawDataFrom(sMatrixData);
         var _loc10_:Number = mMapPoint.x / mapTexture.width;
         var _loc9_:Number = mMapPoint.y / mapTexture.height;
         var _loc4_:Number = param1 / mapTexture.nativeWidth;
         var _loc3_:Number = param2 / mapTexture.nativeHeight;
         sMapTexCoords[0] = -_loc10_;
         sMapTexCoords[1] = -_loc9_;
         sMapTexCoords[2] = -_loc10_ + _loc4_;
         sMapTexCoords[3] = -_loc9_;
         sMapTexCoords[4] = -_loc10_;
         sMapTexCoords[5] = -_loc9_ + _loc3_;
         sMapTexCoords[6] = -_loc10_ + _loc4_;
         sMapTexCoords[7] = -_loc9_ + _loc3_;
         mMapTexture.adjustTexCoords(sMapTexCoords);
         mMapTexCoordBuffer.uploadFromVector(sMapTexCoords,0,4);
      }
      
      public function get componentX() : uint
      {
         return mComponentX;
      }
      
      public function set componentX(param1:uint) : void
      {
         mComponentX = param1;
      }
      
      public function get componentY() : uint
      {
         return mComponentY;
      }
      
      public function set componentY(param1:uint) : void
      {
         mComponentY = param1;
      }
      
      public function get scaleX() : Number
      {
         return mScaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         mScaleX = param1;
      }
      
      public function get scaleY() : Number
      {
         return mScaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         mScaleY = param1;
      }
      
      public function get mapTexture() : Texture
      {
         return mMapTexture;
      }
      
      public function set mapTexture(param1:Texture) : void
      {
         if(mMapTexture != param1)
         {
            mMapTexture = param1;
            createPrograms();
         }
      }
      
      public function get mapPoint() : Point
      {
         return mMapPoint;
      }
      
      public function set mapPoint(param1:Point) : void
      {
         if(param1)
         {
            mMapPoint.setTo(param1.x,param1.y);
         }
         else
         {
            mMapPoint.setTo(0,0);
         }
      }
      
      public function get repeat() : Boolean
      {
         return mRepeat;
      }
      
      public function set repeat(param1:Boolean) : void
      {
         if(mRepeat != param1)
         {
            mRepeat = param1;
            createPrograms();
         }
      }
   }
}
