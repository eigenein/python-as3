package engine.core.utils
{
   public class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function sign(param1:Number) : int
      {
         if(param1 < 0)
         {
            return -1;
         }
         if(param1 > 0)
         {
            return 1;
         }
         return 0;
      }
      
      public static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function map(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 1) : Number
      {
         return param1 == param2?param4:Number((param1 - param2) * (param5 - param4) / (param3 - param2) + param4);
      }
      
      public static function mapSin(param1:Number, param2:Number = 1, param3:Number = 0, param4:Number = 1) : Number
      {
         var _loc5_:* = NaN;
         if(param2 == 1)
         {
            param1 = param1 - 0.5;
         }
         else
         {
            _loc5_ = param1;
            if(param1 > 0.5)
            {
               param1 = Math.pow(param1 * 2 - 1,param2) * 0.5;
            }
            else
            {
               param1 = -Math.pow(1 - param1 * 2,param2) * 0.5;
            }
         }
         return param3 + (param4 - param3) * (0.5 + 0.5 * Math.sin(param1 * 3.14159265358979));
      }
      
      public static function mapPower(param1:Number, param2:Number = 1, param3:Number = 0, param4:Number = 1) : Number
      {
         var _loc5_:* = NaN;
         if(param2 == 1)
         {
            param1 = param1 - 0.5;
         }
         else
         {
            _loc5_ = param1;
            if(param1 > 0.5)
            {
               param1 = Math.pow(param1 * 2 - 1,param2) * 0.5;
            }
            else
            {
               param1 = -Math.pow(1 - param1 * 2,param2) * 0.5;
            }
         }
         return param3 + (param4 - param3) * (0.5 + param1);
      }
   }
}
