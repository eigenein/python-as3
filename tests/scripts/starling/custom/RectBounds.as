package starling.custom
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.utils.MathUtil;
   import starling.utils.MatrixUtil;
   
   public class RectBounds
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
       
      
      public function RectBounds()
      {
         super();
      }
      
      public static function getBounds(param1:Number, param2:Number, param3:Matrix, param4:Rectangle) : void
      {
         if(param3 == null)
         {
            param4.x = 0;
            param4.y = 0;
            param4.width = param1;
            param4.height = param2;
         }
         else
         {
            if(param3.a > 0)
            {
               if(param3.c > 0)
               {
                  param4.x = param3.tx;
                  param4.width = param3.a * param1 + param3.c * param2;
               }
               else
               {
                  param4.x = param3.tx + param3.c * param2;
                  param4.width = param3.a * param1 - param3.c * param2;
               }
            }
            else if(param3.c > 0)
            {
               param4.x = param3.tx + param3.a * param1;
               param4.width = -param3.a * param1 + param3.c * param2;
            }
            else
            {
               param4.x = param3.tx + param3.a * param1 + param3.c * param2;
               param4.width = -param3.a * param1 - param3.c * param2;
            }
            if(param3.b > 0)
            {
               if(param3.d > 0)
               {
                  param4.y = param3.ty;
                  param4.height = param3.b * param1 + param3.d * param2;
               }
               else
               {
                  param4.y = param3.ty + param3.d * param2;
                  param4.height = param3.b * param1 - param3.d * param2;
               }
            }
            else if(param3.d > 0)
            {
               param4.y = param3.ty + param3.b * param1;
               param4.height = -param3.b * param1 + param3.d * param2;
            }
            else
            {
               param4.y = param3.ty + param3.b * param1 + param3.d * param2;
               param4.height = -param3.b * param1 - param3.d * param2;
            }
         }
      }
      
      public static function getBoundsProjected(param1:Number, param2:Number, param3:Matrix3D, param4:Vector3D, param5:Rectangle) : Rectangle
      {
         var _loc11_:* = NaN;
         var _loc10_:* = NaN;
         if(param4 == null)
         {
            throw new ArgumentError("camPos must not be null");
         }
         var _loc7_:* = 1.79769313486232e308;
         var _loc9_:* = -1.79769313486232e308;
         var _loc6_:* = 1.79769313486232e308;
         var _loc8_:* = -1.79769313486232e308;
         _loc10_ = 0;
         _loc11_ = 0;
         if(param3)
         {
            MatrixUtil.transformCoords3D(param3,_loc10_,_loc11_,0,sHelperPoint3D);
         }
         else
         {
            sHelperPoint3D.setTo(_loc10_,_loc11_,0);
         }
         MathUtil.intersectLineWithXYPlane(param4,sHelperPoint3D,sHelperPoint);
         if(_loc7_ > sHelperPoint.x)
         {
            _loc7_ = Number(sHelperPoint.x);
         }
         if(_loc9_ < sHelperPoint.x)
         {
            _loc9_ = Number(sHelperPoint.x);
         }
         if(_loc6_ > sHelperPoint.y)
         {
            _loc6_ = Number(sHelperPoint.y);
         }
         if(_loc8_ < sHelperPoint.y)
         {
            _loc8_ = Number(sHelperPoint.y);
         }
         _loc10_ = param1;
         if(param3)
         {
            MatrixUtil.transformCoords3D(param3,_loc10_,_loc11_,0,sHelperPoint3D);
         }
         else
         {
            sHelperPoint3D.setTo(_loc10_,_loc11_,0);
         }
         MathUtil.intersectLineWithXYPlane(param4,sHelperPoint3D,sHelperPoint);
         if(_loc7_ > sHelperPoint.x)
         {
            _loc7_ = Number(sHelperPoint.x);
         }
         if(_loc9_ < sHelperPoint.x)
         {
            _loc9_ = Number(sHelperPoint.x);
         }
         if(_loc6_ > sHelperPoint.y)
         {
            _loc6_ = Number(sHelperPoint.y);
         }
         if(_loc8_ < sHelperPoint.y)
         {
            _loc8_ = Number(sHelperPoint.y);
         }
         _loc11_ = param2;
         if(param3)
         {
            MatrixUtil.transformCoords3D(param3,_loc10_,_loc11_,0,sHelperPoint3D);
         }
         else
         {
            sHelperPoint3D.setTo(_loc10_,_loc11_,0);
         }
         MathUtil.intersectLineWithXYPlane(param4,sHelperPoint3D,sHelperPoint);
         if(_loc7_ > sHelperPoint.x)
         {
            _loc7_ = Number(sHelperPoint.x);
         }
         if(_loc9_ < sHelperPoint.x)
         {
            _loc9_ = Number(sHelperPoint.x);
         }
         if(_loc6_ > sHelperPoint.y)
         {
            _loc6_ = Number(sHelperPoint.y);
         }
         if(_loc8_ < sHelperPoint.y)
         {
            _loc8_ = Number(sHelperPoint.y);
         }
         _loc10_ = 0;
         if(param3)
         {
            MatrixUtil.transformCoords3D(param3,_loc10_,_loc11_,0,sHelperPoint3D);
         }
         else
         {
            sHelperPoint3D.setTo(_loc10_,_loc11_,0);
         }
         MathUtil.intersectLineWithXYPlane(param4,sHelperPoint3D,sHelperPoint);
         if(_loc7_ > sHelperPoint.x)
         {
            _loc7_ = Number(sHelperPoint.x);
         }
         if(_loc9_ < sHelperPoint.x)
         {
            _loc9_ = Number(sHelperPoint.x);
         }
         if(_loc6_ > sHelperPoint.y)
         {
            _loc6_ = Number(sHelperPoint.y);
         }
         if(_loc8_ < sHelperPoint.y)
         {
            _loc8_ = Number(sHelperPoint.y);
         }
         param5.setTo(_loc7_,_loc6_,_loc9_ - _loc7_,_loc8_ - _loc6_);
         return param5;
      }
   }
}
