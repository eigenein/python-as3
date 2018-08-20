package feathers.utils.math
{
   public function roundUpToNearest(param1:Number, param2:Number = 1) : Number
   {
      if(param2 == 0)
      {
         return param1;
      }
      return Math.ceil(roundToPrecision(param1 / param2,10)) * param2;
   }
}
