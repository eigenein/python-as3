package starling.filters
{
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.utils.Color;
   
   public class ColorMatrixFilter extends FragmentFilter
   {
      
      private static const PROGRAM_NAME:String = "CMF";
      
      private static const MIN_COLOR:Vector.<Number> = new <Number>[0,0,0,0.0001];
      
      private static const IDENTITY:Vector.<Number> = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      private static const LUMA_R:Number = 0.299;
      
      private static const LUMA_G:Number = 0.587;
      
      private static const LUMA_B:Number = 0.114;
      
      private static var sTmpMatrix1:Vector.<Number> = new Vector.<Number>(20,true);
      
      private static var sTmpMatrix2:Vector.<Number> = new Vector.<Number>(0);
       
      
      private var mShaderProgram:Program3D;
      
      private var mUserMatrix:Vector.<Number>;
      
      private var mShaderMatrix:Vector.<Number>;
      
      public function ColorMatrixFilter(param1:Vector.<Number> = null)
      {
         super();
         mUserMatrix = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         mShaderMatrix = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         this.matrix = param1;
      }
      
      override protected function createPrograms() : void
      {
         var _loc1_:* = null;
         var _loc2_:Starling = Starling.current;
         if(_loc2_.hasProgram("CMF"))
         {
            mShaderProgram = _loc2_.getProgram("CMF");
         }
         else
         {
            _loc1_ = "tex ft0, v0,  fs0 <2d, clamp, linear, mipnone>  \nmax ft0, ft0, fc5              \ndiv ft0.xyz, ft0.xyz, ft0.www  \nm44 ft0, ft0, fc0              \nadd ft0, ft0, fc4              \nmul ft0.xyz, ft0.xyz, ft0.www  \nmov oc, ft0                    \n";
            mShaderProgram = _loc2_.registerProgramFromSource("CMF","m44 op, va0, vc0 \nmov v0, va1      \n",_loc1_);
         }
      }
      
      override protected function activate(param1:int, param2:Context3D, param3:Texture) : void
      {
         param2.setProgramConstantsFromVector("fragment",0,mShaderMatrix);
         param2.setProgramConstantsFromVector("fragment",5,MIN_COLOR);
         param2.setProgram(mShaderProgram);
      }
      
      public function invert() : ColorMatrixFilter
      {
         return concatValues(-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0);
      }
      
      public function adjustSaturation(param1:Number) : ColorMatrixFilter
      {
         param1 = param1 + 1;
         var _loc3_:Number = 1 - param1;
         var _loc4_:Number = _loc3_ * 0.299;
         var _loc2_:Number = _loc3_ * 0.587;
         var _loc5_:Number = _loc3_ * 0.114;
         return concatValues(_loc4_ + param1,_loc2_,_loc5_,0,0,_loc4_,_loc2_ + param1,_loc5_,0,0,_loc4_,_loc2_,_loc5_ + param1,0,0,0,0,0,1,0);
      }
      
      public function adjustContrast(param1:Number) : ColorMatrixFilter
      {
         var _loc2_:Number = param1 + 1;
         var _loc3_:Number = 128 * (1 - _loc2_);
         return concatValues(_loc2_,0,0,0,_loc3_,0,_loc2_,0,0,_loc3_,0,0,_loc2_,0,_loc3_,0,0,0,1,0);
      }
      
      public function adjustBrightness(param1:Number) : ColorMatrixFilter
      {
         param1 = param1 * 255;
         return concatValues(1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0);
      }
      
      public function adjustHue(param1:Number) : ColorMatrixFilter
      {
         param1 = param1 * 3.14159265358979;
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         return concatValues(0.299 + _loc2_ * (1 - 0.299) + _loc3_ * -0.299,0.587 + _loc2_ * -0.587 + _loc3_ * -0.587,0.114 + _loc2_ * -0.114 + _loc3_ * (1 - 0.114),0,0,0.299 + _loc2_ * -0.299 + _loc3_ * 0.143,0.587 + _loc2_ * (1 - 0.587) + _loc3_ * 0.14,0.114 + _loc2_ * -0.114 + _loc3_ * -0.283,0,0,0.299 + _loc2_ * -0.299 + _loc3_ * -0.701,0.587 + _loc2_ * -0.587 + _loc3_ * 0.587,0.114 + _loc2_ * (1 - 0.114) + _loc3_ * 0.114,0,0,0,0,0,1,0);
      }
      
      public function tint(param1:uint, param2:Number = 1.0) : ColorMatrixFilter
      {
         var _loc4_:Number = Color.getRed(param1) / 255;
         var _loc6_:Number = Color.getGreen(param1) / 255;
         var _loc5_:Number = Color.getBlue(param1) / 255;
         var _loc3_:Number = 1 - param2;
         var _loc8_:Number = param2 * _loc4_;
         var _loc7_:Number = param2 * _loc6_;
         var _loc9_:Number = param2 * _loc5_;
         return concatValues(_loc3_ + _loc8_ * 0.299,_loc8_ * 0.587,_loc8_ * 0.114,0,0,_loc7_ * 0.299,_loc3_ + _loc7_ * 0.587,_loc7_ * 0.114,0,0,_loc9_ * 0.299,_loc9_ * 0.587,_loc3_ + _loc9_ * 0.114,0,0,0,0,0,1,0);
      }
      
      public function color(param1:uint, param2:Number = 1.0) : ColorMatrixFilter
      {
         var _loc4_:Number = Color.getRed(param1) / 255;
         var _loc6_:Number = Color.getGreen(param1) / 255;
         var _loc5_:Number = Color.getBlue(param1) / 255;
         var _loc3_:Number = Math.max(_loc4_,_loc6_,_loc5_);
         var _loc8_:Number = _loc4_ / _loc3_;
         var _loc7_:Number = _loc6_ / _loc3_;
         var _loc9_:Number = _loc5_ / _loc3_;
         return concatValues(_loc8_ * 0.299,_loc8_ * 0.587,_loc8_ * 0.114,0,0,_loc7_ * 0.299,_loc7_ * 0.587,_loc7_ * 0.114,0,0,_loc9_ * 0.299,_loc9_ * 0.587,_loc9_ * 0.114,0,0,0,0,0,1,0);
      }
      
      public function reset() : ColorMatrixFilter
      {
         matrix = null;
         return this;
      }
      
      public function concat(param1:Vector.<Number>) : ColorMatrixFilter
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               sTmpMatrix1[int(_loc3_ + _loc2_)] = param1[_loc3_] * mUserMatrix[_loc2_] + param1[int(_loc3_ + 1)] * mUserMatrix[int(_loc2_ + 5)] + param1[int(_loc3_ + 2)] * mUserMatrix[int(_loc2_ + 10)] + param1[int(_loc3_ + 3)] * mUserMatrix[int(_loc2_ + 15)] + (_loc2_ == 4?param1[int(_loc3_ + 4)]:0);
               _loc2_++;
            }
            _loc3_ = _loc3_ + 5;
            _loc4_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            mUserMatrix[_loc3_] = sTmpMatrix1[_loc3_];
            _loc3_++;
         }
         updateShaderMatrix();
         return this;
      }
      
      private function concatValues(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Number, param17:Number, param18:Number, param19:Number, param20:Number) : ColorMatrixFilter
      {
         sTmpMatrix2.length = 0;
         sTmpMatrix2.push(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17,param18,param19,param20);
         concat(sTmpMatrix2);
         return this;
      }
      
      private function copyMatrix(param1:Vector.<Number>, param2:Vector.<Number>) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            param2[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      private function updateShaderMatrix() : void
      {
         mShaderMatrix[0] = mUserMatrix[0];
         mShaderMatrix[1] = mUserMatrix[1];
         mShaderMatrix[2] = mUserMatrix[2];
         mShaderMatrix[3] = mUserMatrix[3];
         mShaderMatrix[4] = mUserMatrix[5];
         mShaderMatrix[5] = mUserMatrix[6];
         mShaderMatrix[6] = mUserMatrix[7];
         mShaderMatrix[7] = mUserMatrix[8];
         mShaderMatrix[8] = mUserMatrix[10];
         mShaderMatrix[9] = mUserMatrix[11];
         mShaderMatrix[10] = mUserMatrix[12];
         mShaderMatrix[11] = mUserMatrix[13];
         mShaderMatrix[12] = mUserMatrix[15];
         mShaderMatrix[13] = mUserMatrix[16];
         mShaderMatrix[14] = mUserMatrix[17];
         mShaderMatrix[15] = mUserMatrix[18];
         mShaderMatrix[16] = mUserMatrix[4] / 255;
         mShaderMatrix[17] = mUserMatrix[9] / 255;
         mShaderMatrix[18] = mUserMatrix[14] / 255;
         mShaderMatrix[19] = mUserMatrix[19] / 255;
      }
      
      public function get matrix() : Vector.<Number>
      {
         return mUserMatrix;
      }
      
      public function set matrix(param1:Vector.<Number>) : void
      {
         var _loc2_:int = 0;
         if(param1 && param1.length != 20)
         {
            throw new ArgumentError("Invalid matrix length: must be 20");
         }
         if(param1 == null)
         {
            _loc2_ = 0;
            while(_loc2_ < 20)
            {
               mUserMatrix[_loc2_] = IDENTITY[_loc2_];
               _loc2_++;
            }
            updateShaderMatrix();
         }
         else
         {
            var _loc3_:* = param1[0];
            mUserMatrix[0] = _loc3_;
            mShaderMatrix[0] = _loc3_;
            _loc3_ = param1[1];
            mUserMatrix[1] = _loc3_;
            mShaderMatrix[1] = _loc3_;
            _loc3_ = param1[2];
            mUserMatrix[2] = _loc3_;
            mShaderMatrix[2] = _loc3_;
            _loc3_ = param1[3];
            mUserMatrix[3] = _loc3_;
            mShaderMatrix[3] = _loc3_;
            _loc3_ = param1[5];
            mUserMatrix[5] = _loc3_;
            mShaderMatrix[4] = _loc3_;
            _loc3_ = param1[6];
            mUserMatrix[6] = _loc3_;
            mShaderMatrix[5] = _loc3_;
            _loc3_ = param1[7];
            mUserMatrix[7] = _loc3_;
            mShaderMatrix[6] = _loc3_;
            _loc3_ = param1[8];
            mUserMatrix[8] = _loc3_;
            mShaderMatrix[7] = _loc3_;
            _loc3_ = param1[10];
            mUserMatrix[10] = _loc3_;
            mShaderMatrix[8] = _loc3_;
            _loc3_ = param1[11];
            mUserMatrix[11] = _loc3_;
            mShaderMatrix[9] = _loc3_;
            _loc3_ = param1[12];
            mUserMatrix[12] = _loc3_;
            mShaderMatrix[10] = _loc3_;
            _loc3_ = param1[13];
            mUserMatrix[13] = _loc3_;
            mShaderMatrix[11] = _loc3_;
            _loc3_ = param1[15];
            mUserMatrix[15] = _loc3_;
            mShaderMatrix[12] = _loc3_;
            _loc3_ = param1[16];
            mUserMatrix[16] = _loc3_;
            mShaderMatrix[13] = _loc3_;
            _loc3_ = param1[17];
            mUserMatrix[17] = _loc3_;
            mShaderMatrix[14] = _loc3_;
            _loc3_ = param1[18];
            mUserMatrix[18] = _loc3_;
            mShaderMatrix[15] = _loc3_;
            mUserMatrix[4] = param1[4];
            mUserMatrix[9] = param1[9];
            mUserMatrix[14] = param1[14];
            mUserMatrix[19] = param1[19];
            mShaderMatrix[16] = mUserMatrix[4] / 255;
            mShaderMatrix[17] = mUserMatrix[9] / 255;
            mShaderMatrix[18] = mUserMatrix[14] / 255;
            mShaderMatrix[19] = mUserMatrix[19] / 255;
         }
      }
   }
}
