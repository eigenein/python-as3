package feathers.utils.math
{
   public function clamp(param1:Number, param2:Number, param3:Number) : Number
   {
      if(param2 > param3)
      {
         throw new ArgumentError("minimum should be smaller than maximum.");
      }
      if(param1 < param2)
      {
         param1 = param2;
      }
      else if(param1 > param3)
      {
         param1 = param3;
      }
      return param1;
   }
}
