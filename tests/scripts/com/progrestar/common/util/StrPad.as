package com.progrestar.common.util
{
   public class StrPad
   {
      
      public static const STR_PAD_LEFT:int = 1;
      
      public static const STR_PAD_RIGHT:int = 2;
      
      public static const STR_PAD_BOTH:int = 3;
       
      
      public function StrPad()
      {
         super();
      }
      
      public static function strPad(param1:String, param2:int, param3:String = " ", param4:int = 1) : String
      {
         var _loc6_:* = (param4 & 1) != 0;
         var _loc5_:* = (param4 & 2) != 0;
         param3 = param3.length > 1?param3.charAt():param3.length == 0?" ":param3;
         if(_loc6_ || _loc5_)
         {
            while(param1.length < param2)
            {
               if(_loc6_)
               {
                  param1 = param3 + param1;
               }
               if(param1.length < param2 && _loc5_)
               {
                  param1 = param1 + param3;
               }
            }
         }
         return param1;
      }
   }
}
