package ru.crazybit.socexp.view.core.text
{
   public class FormatChar extends SpecialChar
   {
       
      
      public function FormatChar()
      {
         super();
      }
      
      public static function tryNewFormatChar(param1:String) : SpecialChar
      {
         var _loc5_:* = 0;
         var _loc2_:SpecialChar = null;
         var _loc3_:Array = [ColorChar.tryNewColorChar,ShiftChar.tryNewShiftChar];
         var _loc4_:uint = _loc3_.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc4_ && !_loc2_)
         {
            _loc2_ = (_loc3_[_loc5_] as Function)(param1);
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
