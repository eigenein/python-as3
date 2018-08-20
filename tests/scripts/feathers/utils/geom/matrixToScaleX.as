package feathers.utils.geom
{
   import flash.geom.Matrix;
   
   public function matrixToScaleX(param1:Matrix) : Number
   {
      var _loc2_:Number = param1.a;
      var _loc3_:Number = param1.b;
      return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
   }
}
