package feathers.utils.math
{
   public function roundToNearest(param1:Number, param2:Number = 1) : Number
   {
      if(param2 == 0)
      {
         return param1;
      }
      var _loc3_:Number = Math.round(roundToPrecision(param1 / param2,10)) * param2;
      return roundToPrecision(_loc3_,10);
   }
}
