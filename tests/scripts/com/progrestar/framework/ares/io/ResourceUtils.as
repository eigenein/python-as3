package com.progrestar.framework.ares.io
{
   import com.progrestar.common.util.assert;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Rectangle;
   
   public class ResourceUtils
   {
      
      private static const eps:Number = 0.01;
       
      
      public function ResourceUtils()
      {
         super();
      }
      
      public static function colorTransformToColorMatrix(param1:Vector.<Number>, param2:ColorTransform) : void
      {
         var _loc3_:int = 0;
         assert(param1 && param1.length == 20);
         assert(param2);
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            param1[_loc3_] = 0;
            _loc3_++;
         }
         param1[0] = param2.redMultiplier;
         param1[6] = param2.greenMultiplier;
         param1[12] = param2.blueMultiplier;
         param1[18] = param2.alphaMultiplier;
         param1[4] = param2.redOffset;
         param1[9] = param2.greenOffset;
         param1[14] = param2.blueOffset;
         param1[19] = param2.alphaOffset;
      }
      
      public static function colorTransformArrayToColorMatrix(param1:Vector.<Number>, param2:Array) : void
      {
         var _loc3_:int = 0;
         assert(param1 && param1.length == 20);
         assert(param2 && param2.length == 8);
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            param1[_loc3_] = 0;
            _loc3_++;
         }
         param1[0] = param2[0];
         param1[6] = param2[2];
         param1[12] = param2[4];
         param1[18] = param2[6];
         param1[4] = param2[1];
         param1[9] = param2[3];
         param1[14] = param2[5];
         param1[19] = param2[7];
      }
      
      public static function isColorMatrixEqual(param1:Vector.<Number>, param2:Vector.<Number>) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         assert(param1.length == 20);
         assert(param2.length == 20);
         _loc3_ = 0;
         while(_loc3_ < 20)
         {
            if(param1[_loc3_] != param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function isMatrixEqual(param1:Matrix, param2:Matrix) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1.a - param2.a > 0.01 || param1.a - param2.a < -0.01)
         {
            return false;
         }
         if(param1.b - param2.b > 0.01 || param1.b - param2.b < -0.01)
         {
            return false;
         }
         if(param1.c - param2.c > 0.01 || param1.c - param2.c < -0.01)
         {
            return false;
         }
         if(param1.d - param2.d > 0.01 || param1.d - param2.d < -0.01)
         {
            return false;
         }
         if(param1.tx - param2.tx > 0.01 || param1.tx - param2.tx < -0.01)
         {
            return false;
         }
         if(param1.ty - param2.ty > 0.01 || param1.ty - param2.ty < -0.01)
         {
            return false;
         }
         return true;
      }
      
      public static function isRectEqual(param1:Rectangle, param2:Rectangle, param3:Number = 0.01) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.width - param2.width > param3 || param1.width - param2.width < -param3)
         {
            return false;
         }
         if(param1.height - param2.height > param3 || param1.height - param2.height < -param3)
         {
            return false;
         }
         if(param1.x - param2.x > param3 || param1.x - param2.x < -param3)
         {
            return false;
         }
         if(param1.y - param2.y > param3 || param1.y - param2.y < -param3)
         {
            return false;
         }
         return true;
      }
      
      public static function convertMatrix3DToMatrix2D(param1:Matrix3D) : Matrix
      {
         var _loc2_:Vector.<Number> = param1.rawData;
         return new Matrix(_loc2_[0],_loc2_[4],_loc2_[1],_loc2_[5],_loc2_[3],_loc2_[7]);
      }
   }
}
