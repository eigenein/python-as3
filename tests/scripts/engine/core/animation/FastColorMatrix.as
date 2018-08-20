package engine.core.animation
{
   public class FastColorMatrix
   {
      
      private static var tempMatrix:FastColorMatrix = FastColorMatrix.IDENTITY();
      
      private static var tempMatrix2:FastColorMatrix = FastColorMatrix.IDENTITY();
      
      private static var tempVector:Vector.<Number> = new Vector.<Number>(20,true);
       
      
      public var mR0:Number;
      
      public var mR1:Number;
      
      public var mR2:Number;
      
      public var mR3:Number;
      
      public var mR4:Number;
      
      public var mG0:Number;
      
      public var mG1:Number;
      
      public var mG2:Number;
      
      public var mG3:Number;
      
      public var mG4:Number;
      
      public var mB0:Number;
      
      public var mB1:Number;
      
      public var mB2:Number;
      
      public var mB3:Number;
      
      public var mB4:Number;
      
      public var mA0:Number;
      
      public var mA1:Number;
      
      public var mA2:Number;
      
      public var mA3:Number;
      
      public var mA4:Number;
      
      public function FastColorMatrix()
      {
         super();
      }
      
      public static function IDENTITY() : FastColorMatrix
      {
         var _loc1_:FastColorMatrix = new FastColorMatrix();
         var _loc2_:* = 1;
         _loc1_.mA3 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mB2 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mG1 = _loc2_;
         _loc1_.mR0 = _loc2_;
         _loc2_ = 0;
         _loc1_.mA4 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mA2 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mA1 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mA0 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mB4 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mB3 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mB1 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mB0 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mG4 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mG3 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mG2 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mG0 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mR4 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mR3 = _loc2_;
         _loc2_ = _loc2_;
         _loc1_.mR2 = _loc2_;
         _loc1_.mR1 = _loc2_;
         return _loc1_;
      }
      
      public function get isAlpha() : Boolean
      {
         if(mR0 != 1 || mG1 != 1 || mB2 != 1)
         {
            return false;
         }
         if(mR1 * mR1 + mR2 * mR2 + mR3 * mR3 + mR4 * mR4 + mG0 * mG0 + mG2 * mG2 != 0)
         {
            return false;
         }
         if(mG3 * mG3 + mG4 * mG4 + mB0 * mB0 + mB1 * mB1 + mB3 * mB3 + mA0 * mA0 + mA1 * mA1 + mA2 * mA2 + mA4 * mA4 != 0)
         {
            return false;
         }
         return true;
      }
      
      public function get isDiagonal() : Boolean
      {
         if(mR1 * mR1 + mR2 * mR2 + mR3 * mR3 + mR4 * mR4 + mG0 * mG0 + mG2 * mG2 != 0)
         {
            return false;
         }
         if(mG3 * mG3 + mG4 * mG4 + mB0 * mB0 + mB1 * mB1 + mB3 * mB3 + mA0 * mA0 + mA1 * mA1 + mA2 * mA2 + mA4 * mA4 != 0)
         {
            return false;
         }
         return true;
      }
      
      public function get colorMultiplier() : uint
      {
         return int(mA3 * 255) << 24 | int(mR0 * 255) << 16 | int(mG1 * 255) << 8 | int(mB2 * 255);
      }
      
      public function concat(param1:FastColorMatrix, param2:FastColorMatrix, param3:FastColorMatrix) : void
      {
         param3.mR0 = param1.mR0 * param2.mR0 + param1.mR1 * param2.mG0 + param1.mR2 * param2.mB0 + param1.mR3 * param2.mA0;
         param3.mR1 = param1.mR0 * param2.mR1 + param1.mR1 * param2.mG1 + param1.mR2 * param2.mB1 + param1.mR3 * param2.mA1;
         param3.mR2 = param1.mR0 * param2.mR2 + param1.mR1 * param2.mG2 + param1.mR2 * param2.mB2 + param1.mR3 * param2.mA2;
         param3.mR3 = param1.mR0 * param2.mR3 + param1.mR1 * param2.mG3 + param1.mR2 * param2.mB3 + param1.mR3 * param2.mA3;
         param3.mR4 = param1.mR0 * param2.mR4 + param1.mR1 * param2.mG4 + param1.mR2 * param2.mB4 + param1.mR3 * param2.mA4 + param1.mR4;
         param3.mG0 = param1.mG0 * param2.mR0 + param1.mG1 * param2.mG0 + param1.mG2 * param2.mB0 + param1.mG3 * param2.mA0;
         param3.mG1 = param1.mG0 * param2.mR1 + param1.mG1 * param2.mG1 + param1.mG2 * param2.mB1 + param1.mG3 * param2.mA1;
         param3.mG2 = param1.mG0 * param2.mR2 + param1.mG1 * param2.mG2 + param1.mG2 * param2.mB2 + param1.mG3 * param2.mA2;
         param3.mG3 = param1.mG0 * param2.mR3 + param1.mG1 * param2.mG3 + param1.mG2 * param2.mB3 + param1.mG3 * param2.mA3;
         param3.mG4 = param1.mG0 * param2.mR4 + param1.mG1 * param2.mG4 + param1.mG2 * param2.mB4 + param1.mG3 * param2.mA4 + param1.mG4;
         param3.mB0 = param1.mB0 * param2.mR0 + param1.mB1 * param2.mG0 + param1.mB2 * param2.mB0 + param1.mB3 * param2.mA0;
         param3.mB1 = param1.mB0 * param2.mR1 + param1.mB1 * param2.mG1 + param1.mB2 * param2.mB1 + param1.mB3 * param2.mA1;
         param3.mB2 = param1.mB0 * param2.mR2 + param1.mB1 * param2.mG2 + param1.mB2 * param2.mB2 + param1.mB3 * param2.mA2;
         param3.mB3 = param1.mB0 * param2.mR3 + param1.mB1 * param2.mG3 + param1.mB2 * param2.mB3 + param1.mB3 * param2.mA3;
         param3.mB4 = param1.mB0 * param2.mR4 + param1.mB1 * param2.mG4 + param1.mB2 * param2.mB4 + param1.mB3 * param2.mA4 + param1.mB4;
         param3.mA0 = param1.mA0 * param2.mR0 + param1.mA1 * param2.mG0 + param1.mA2 * param2.mB0 + param1.mA3 * param2.mA0;
         param3.mA1 = param1.mA0 * param2.mR1 + param1.mA1 * param2.mG1 + param1.mA2 * param2.mB1 + param1.mA3 * param2.mA1;
         param3.mA2 = param1.mA0 * param2.mR2 + param1.mA1 * param2.mG2 + param1.mA2 * param2.mB2 + param1.mA3 * param2.mA2;
         param3.mA3 = param1.mA0 * param2.mR3 + param1.mA1 * param2.mG3 + param1.mA2 * param2.mB3 + param1.mA3 * param2.mA3;
         param3.mA4 = param1.mA0 * param2.mR4 + param1.mA1 * param2.mG4 + param1.mA2 * param2.mB4 + param1.mA3 * param2.mA4 + param1.mA4;
      }
      
      public function copyFrom(param1:FastColorMatrix) : void
      {
         mR0 = param1.mR0;
         mR1 = param1.mR1;
         mR2 = param1.mR2;
         mR3 = param1.mR3;
         mR4 = param1.mR4;
         mG0 = param1.mG0;
         mG1 = param1.mG1;
         mG2 = param1.mG2;
         mG3 = param1.mG3;
         mG4 = param1.mG4;
         mB0 = param1.mB0;
         mB1 = param1.mB1;
         mB2 = param1.mB2;
         mB3 = param1.mB3;
         mB4 = param1.mB4;
         mA0 = param1.mA0;
         mA1 = param1.mA1;
         mA2 = param1.mA2;
         mA3 = param1.mA3;
         mA4 = param1.mA4;
      }
      
      public function concatAlpha(param1:Number) : void
      {
         mA0 = mA0 * param1;
         mA1 = mA1 * param1;
         mA2 = mA2 * param1;
         mA3 = mA3 * param1;
         mA4 = mA4 * param1;
      }
      
      public function concatMultiplyUint(param1:uint) : void
      {
         var _loc2_:Number = (int(param1 >>> 24) & 255) / 255;
         mA0 = mA0 * _loc2_;
         mA1 = mA1 * _loc2_;
         mA2 = mA2 * _loc2_;
         mA3 = mA3 * _loc2_;
         mA4 = mA4 * _loc2_;
         _loc2_ = (int(param1 >>> 16) & 255) / 255;
         mR0 = mR0 * _loc2_;
         mR1 = mR1 * _loc2_;
         mR2 = mR2 * _loc2_;
         mR3 = mR3 * _loc2_;
         mR4 = mR4 * _loc2_;
         _loc2_ = (int(param1 >>> 8) & 255) / 255;
         mG0 = mG0 * _loc2_;
         mG1 = mG1 * _loc2_;
         mG2 = mG2 * _loc2_;
         mG3 = mG3 * _loc2_;
         mG4 = mG4 * _loc2_;
         _loc2_ = (int(param1 >>> 0) & 255) / 255;
         mB0 = mB0 * _loc2_;
         mB1 = mB1 * _loc2_;
         mB2 = mB2 * _loc2_;
         mB3 = mB3 * _loc2_;
         mB4 = mB4 * _loc2_;
      }
      
      public function concatMatrixVector(param1:Vector.<Number>) : void
      {
         tempMatrix.setFromVector(param1);
         concat(this,tempMatrix,tempMatrix2);
         copyFrom(tempMatrix2);
      }
      
      public function setFromVector(param1:Vector.<Number>) : void
      {
         mR0 = param1[0];
         mR1 = param1[1];
         mR2 = param1[2];
         mR3 = param1[3];
         mR4 = param1[4];
         mG0 = param1[5];
         mG1 = param1[6];
         mG2 = param1[7];
         mG3 = param1[8];
         mG4 = param1[9];
         mB0 = param1[10];
         mB1 = param1[11];
         mB2 = param1[12];
         mB3 = param1[13];
         mB4 = param1[14];
         mA0 = param1[15];
         mA1 = param1[16];
         mA2 = param1[17];
         mA3 = param1[18];
         mA4 = param1[19];
      }
      
      public function concatVectors(param1:Vector.<Number>, param2:Vector.<Number>, param3:Vector.<Number>) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               param3[int(_loc5_ + _loc4_)] = param1[_loc5_] * param2[_loc4_] + param1[int(_loc5_ + 1)] * param2[int(_loc4_ + 5)] + param1[int(_loc5_ + 2)] * param2[int(_loc4_ + 10)] + param1[int(_loc5_ + 3)] * param2[int(_loc4_ + 15)] + (_loc4_ == 4?param1[int(_loc5_ + 4)]:0);
               _loc4_++;
            }
            _loc5_ = _loc5_ + 5;
            _loc6_++;
         }
      }
      
      public function getVector() : Vector.<Number>
      {
         return new <Number>[mR0,mR1,mR2,mR3,mR4,mG0,mG1,mG2,mG3,mG4,mB0,mB1,mB2,mB3,mB4,mA0,mA1,mA2,mA3,mA4];
      }
      
      public function setupVector(param1:Vector.<Number>) : Vector.<Number>
      {
         param1[0] = mR0;
         param1[1] = mR1;
         param1[2] = mR2;
         param1[3] = mR3;
         param1[4] = mR4;
         param1[5] = mG0;
         param1[6] = mG1;
         param1[7] = mG2;
         param1[8] = mG3;
         param1[9] = mG4;
         param1[10] = mB0;
         param1[11] = mB1;
         param1[12] = mB2;
         param1[13] = mB3;
         param1[14] = mB4;
         param1[15] = mA0;
         param1[16] = mA1;
         param1[17] = mA2;
         param1[18] = mA3;
         param1[19] = mA4;
         return param1;
      }
      
      public function identity() : void
      {
         mA3 = 1;
         mB2 = 1;
         mG1 = 1;
         mR0 = 1;
         mA4 = 0;
         mA2 = 0;
         mA1 = 0;
         mA0 = 0;
         mB4 = 0;
         mB3 = 0;
         mB1 = 0;
         mB0 = 0;
         mG4 = 0;
         mG3 = 0;
         mG2 = 0;
         mG0 = 0;
         mR4 = 0;
         mR3 = 0;
         mR2 = 0;
         mR1 = 0;
      }
   }
}
