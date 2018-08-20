package feathers.utils.math
{
   public function roundToPrecision(param1:Number, param2:int = 0) : Number
   {
      var _loc3_:Number = Math.pow(10,param2);
      return Math.round(_loc3_ * param1) / _loc3_;
   }
}
