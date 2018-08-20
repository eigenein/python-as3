package ru.crazybit.socexp.view.core.text
{
   public class SpecialCharData
   {
      
      private static const _borderL:String = "{";
      
      private static const _borderR:String = "}";
       
      
      private var _formatChars:Object;
      
      private var _specialChars:Object;
      
      public function SpecialCharData()
      {
         _formatChars = {};
         _specialChars = {};
         super();
      }
      
      public static function isSpecialFormat(param1:String) : Boolean
      {
         var _loc2_:uint = param1.length;
         return _loc2_ >= 2 && param1.charAt(0) == "{" && param1.charAt(_loc2_ - 1) == "}";
      }
      
      public function addSpecialChar(param1:String, param2:uint) : void
      {
         var _loc4_:* = null;
         param1 = param1.toLowerCase();
         var _loc3_:SpecialChar = SpecialChar.createWithString(param1);
         if(!_loc3_)
         {
            return;
            §§push(trace("bad special character format string:",param1));
         }
         else
         {
            if(_loc3_ is FormatChar)
            {
               _loc4_ = _formatChars;
            }
            else
            {
               _loc4_ = _specialChars;
            }
            if(!(param2 in _loc4_))
            {
               _loc4_[param2] = [];
            }
            var _loc5_:Array = _loc4_[param2];
            _loc5_.push(_loc3_);
            return;
         }
      }
      
      public function getSpecialChars(param1:uint) : Array
      {
         return _specialChars[param1];
      }
      
      public function getFormatChars(param1:uint) : Array
      {
         return _formatChars[param1];
      }
      
      public function clear() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = _formatChars;
         for(_loc1_ in _formatChars)
         {
            delete _formatChars[_loc1_];
         }
         var _loc5_:int = 0;
         var _loc4_:* = _specialChars;
         for(_loc1_ in _specialChars)
         {
            delete _specialChars[_loc1_];
         }
      }
   }
}
