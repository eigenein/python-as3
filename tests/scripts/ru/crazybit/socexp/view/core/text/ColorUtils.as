package ru.crazybit.socexp.view.core.text
{
   public class ColorUtils
   {
      
      public static const DEFAULT_BEIGE:uint = 16442802;
      
      public static const NUMBER_WHITE:uint = 16711677;
       
      
      public function ColorUtils()
      {
         super();
      }
      
      public static function rgbToHex(param1:uint, param2:uint, param3:uint) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
      
      public static function hexToRGBFormat(param1:uint) : String
      {
         var _loc2_:* = (param1 & 16711680) >> 16;
         var _loc3_:* = (param1 & 65280) >> 8;
         var _loc4_:* = param1 & 255;
         return "^{" + _loc2_ + " " + _loc3_ + " " + _loc4_ + "}^";
      }
      
      public static function addWhiteAndDefault(param1:String, param2:int = 16645626, param3:int = 16568453) : String
      {
         return ColorUtils.hexToRGBFormat(param2) + param1 + ColorUtils.hexToRGBFormat(param3);
      }
   }
}
