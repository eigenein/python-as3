package ru.crazybit.socexp.view.core.text
{
   public class ColorChar extends FormatChar implements IFormatterChar
   {
       
      
      private var _color:uint;
      
      public function ColorChar(param1:uint)
      {
         super();
         _color = param1;
      }
      
      public static function tryNewColorChar(param1:String) : SpecialChar
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = 0;
         var _loc6_:int = param1.search(/{\d+\s\d+\s\d+}/g);
         if(_loc6_ >= 0)
         {
            _loc7_ = param1.match(/\d+/g);
            _loc4_ = uint(ColorUtils.rgbToHex(_loc7_[0],_loc7_[1],_loc7_[2]));
            return new ColorChar(_loc4_);
         }
         _loc6_ = param1.search(/{\/color}/g);
         if(_loc6_ >= 0)
         {
            return new NoColorChar();
         }
         return null;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function processFormat(param1:SpecialBitmapFontTextFormat) : void
      {
         param1.color = _color;
      }
   }
}
