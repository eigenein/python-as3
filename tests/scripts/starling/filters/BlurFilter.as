package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.utils.Color;
   
   public class BlurFilter extends FragmentFilter
   {
      
      private static const NORMAL_PROGRAM_NAME:String = "BF_n";
      
      private static const TINTED_PROGRAM_NAME:String = "BF_t";
      
      private static const MAX_SIGMA:Number = 2.0;
       
      
      private var mNormalProgram:Program3D;
      
      private var mTintedProgram:Program3D;
      
      private var mOffsets:Vector.<Number>;
      
      private var mWeights:Vector.<Number>;
      
      private var mColor:Vector.<Number>;
      
      private var mBlurX:Number;
      
      private var mBlurY:Number;
      
      private var mUniformColor:Boolean;
      
      private var sTmpWeights:Vector.<Number>;
      
      public function BlurFilter(param1:Number = 1, param2:Number = 1, param3:Number = 1)
      {
         mOffsets = new <Number>[0,0,0,0];
         mWeights = new <Number>[0,0,0,0];
         mColor = new <Number>[1,1,1,1];
         sTmpWeights = new Vector.<Number>(5,true);
         super(1,param3);
         mBlurX = param1;
         mBlurY = param2;
         updateMarginsAndPasses();
      }
      
      public static function createDropShadow(param1:Number = 4.0, param2:Number = 0.785, param3:uint = 0, param4:Number = 0.5, param5:Number = 1.0, param6:Number = 0.5) : BlurFilter
      {
         var _loc7_:BlurFilter = new BlurFilter(param5,param5,param6);
         _loc7_.offsetX = Math.cos(param2) * param1;
         _loc7_.offsetY = Math.sin(param2) * param1;
         _loc7_.mode = "below";
         _loc7_.setUniformColor(true,param3,param4);
         return _loc7_;
      }
      
      public static function createGlow(param1:uint = 16776960, param2:Number = 1.0, param3:Number = 1.0, param4:Number = 0.5) : BlurFilter
      {
         var _loc5_:BlurFilter = new BlurFilter(param3,param3,param4);
         _loc5_.mode = "below";
         _loc5_.setUniformColor(true,param1,param2);
         return _loc5_;
      }
      
      override protected function createPrograms() : void
      {
         mNormalProgram = createProgram(false);
         mTintedProgram = createProgram(true);
      }
      
      private function createProgram(param1:Boolean) : Program3D
      {
         var _loc2_:String = !!param1?"BF_t":"BF_n";
         var _loc5_:Starling = Starling.current;
         if(_loc5_.hasProgram(_loc2_))
         {
            return _loc5_.getProgram(_loc2_);
         }
         var _loc3_:String = "m44 op, va0, vc0       \nmov v0, va1            \nsub v1, va1, vc4.zwxx  \nsub v2, va1, vc4.xyxx  \nadd v3, va1, vc4.xyxx  \nadd v4, va1, vc4.zwxx  \n";
         var _loc4_:String = "tex ft0,  v0, fs0 <2d, clamp, linear, mipnone> \nmul ft5, ft0, fc0.xxxx                         \ntex ft1,  v1, fs0 <2d, clamp, linear, mipnone> \nmul ft1, ft1, fc0.zzzz                         \nadd ft5, ft5, ft1                              \ntex ft2,  v2, fs0 <2d, clamp, linear, mipnone> \nmul ft2, ft2, fc0.yyyy                         \nadd ft5, ft5, ft2                              \ntex ft3,  v3, fs0 <2d, clamp, linear, mipnone> \nmul ft3, ft3, fc0.yyyy                         \nadd ft5, ft5, ft3                              \ntex ft4,  v4, fs0 <2d, clamp, linear, mipnone> \nmul ft4, ft4, fc0.zzzz                         \n";
         if(param1)
         {
            _loc4_ = _loc4_ + "add ft5, ft5, ft4                              \nmul ft5.xyz, fc1.xyz, ft5.www                  \nmul oc, ft5, fc1.wwww                          \n";
         }
         else
         {
            _loc4_ = _loc4_ + "add  oc, ft5, ft4                              \n";
         }
         return _loc5_.registerProgramFromSource(_loc2_,_loc3_,_loc4_);
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         updateParameters(param1,param3.nativeWidth,param3.nativeHeight);
         param2.setProgramConstantsFromVector("vertex",4,mOffsets);
         param2.setProgramConstantsFromVector("fragment",0,mWeights);
         if(mUniformColor && param1 == numPasses - 1)
         {
            param2.setProgramConstantsFromVector("fragment",1,mColor);
            param2.setProgram(mTintedProgram);
         }
         else
         {
            param2.setProgram(mNormalProgram);
         }
      }
      
      private function updateParameters(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:int = 0;
         var _loc10_:* = param1 < mBlurX;
         if(_loc10_)
         {
            _loc4_ = Math.min(1,mBlurX - param1) * 2;
            _loc9_ = 1 / param2;
         }
         else
         {
            _loc4_ = Math.min(1,mBlurY - (param1 - Math.ceil(mBlurX))) * 2;
            _loc9_ = 1 / param3;
         }
         var _loc13_:Number = 2 * _loc4_ * _loc4_;
         var _loc5_:Number = 1 / Math.sqrt(_loc13_ * 3.14159265358979);
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            sTmpWeights[_loc6_] = _loc5_ * Math.exp(-_loc6_ * _loc6_ / _loc13_);
            _loc6_++;
         }
         mWeights[0] = sTmpWeights[0];
         mWeights[1] = sTmpWeights[1] + sTmpWeights[2];
         mWeights[2] = sTmpWeights[3] + sTmpWeights[4];
         var _loc11_:Number = mWeights[0] + 2 * mWeights[1] + 2 * mWeights[2];
         var _loc12_:Number = 1 / _loc11_;
         var _loc14_:* = 0;
         var _loc15_:* = mWeights[_loc14_] * _loc12_;
         mWeights[_loc14_] = _loc15_;
         _loc15_ = 1;
         _loc14_ = mWeights[_loc15_] * _loc12_;
         mWeights[_loc15_] = _loc14_;
         _loc14_ = 2;
         _loc15_ = mWeights[_loc14_] * _loc12_;
         mWeights[_loc14_] = _loc15_;
         var _loc8_:Number = (_loc9_ * sTmpWeights[1] + 2 * _loc9_ * sTmpWeights[2]) / mWeights[1];
         var _loc7_:Number = (3 * _loc9_ * sTmpWeights[3] + 4 * _loc9_ * sTmpWeights[4]) / mWeights[2];
         if(_loc10_)
         {
            mOffsets[0] = _loc8_;
            mOffsets[1] = 0;
            mOffsets[2] = _loc7_;
            mOffsets[3] = 0;
         }
         else
         {
            mOffsets[0] = 0;
            mOffsets[1] = _loc8_;
            mOffsets[2] = 0;
            mOffsets[3] = _loc7_;
         }
      }
      
      private function updateMarginsAndPasses() : void
      {
         if(mBlurX == 0 && mBlurY == 0)
         {
            mBlurX = 0.001;
         }
         numPasses = Math.ceil(mBlurX) + Math.ceil(mBlurY);
         marginX = (3 + Math.ceil(mBlurX)) / resolution;
         marginY = (3 + Math.ceil(mBlurY)) / resolution;
      }
      
      public function setUniformColor(param1:Boolean, param2:uint = 0, param3:Number = 1.0) : void
      {
         mColor[0] = Color.getRed(param2) / 255;
         mColor[1] = Color.getGreen(param2) / 255;
         mColor[2] = Color.getBlue(param2) / 255;
         mColor[3] = param3;
         mUniformColor = param1;
      }
      
      public function get blurX() : Number
      {
         return mBlurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         mBlurX = param1;
         updateMarginsAndPasses();
      }
      
      public function get blurY() : Number
      {
         return mBlurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         mBlurY = param1;
         updateMarginsAndPasses();
      }
   }
}
