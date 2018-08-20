package ru.crazybit.socexp.view.core.text
{
   public class ShiftChar extends FormatChar implements IFormatterChar
   {
       
      
      private var _shift:uint;
      
      public function ShiftChar(param1:uint)
      {
         super();
         _shift = param1;
      }
      
      public static function tryNewShiftChar(param1:String) : SpecialChar
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = param1.search(/{->\d+}/g);
         if(_loc3_ >= 0)
         {
            _loc4_ = param1.match(/\d+/g);
            return new ShiftChar(_loc4_[0]);
         }
         return null;
      }
      
      public function get shift() : uint
      {
         return _shift;
      }
      
      public function processFormat(param1:SpecialBitmapFontTextFormat) : void
      {
         param1.indent = _shift;
      }
   }
}
