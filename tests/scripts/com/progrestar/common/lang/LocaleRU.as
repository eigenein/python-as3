package com.progrestar.common.lang
{
   public class LocaleRU extends Locale
   {
       
      
      public function LocaleRU()
      {
         super("ru");
      }
      
      override public function get isAsian() : Boolean
      {
         return false;
      }
      
      override public function triggerG(param1:String, ... rest) : String
      {
         var _loc4_:String = String(rest[0]);
         var _loc3_:Array = param1.split("|");
         if(_loc4_.substr(0,1) == "f" || _loc4_.substr(0,1) == "F")
         {
            return _loc3_[1];
         }
         return _loc3_[0];
      }
      
      override public function triggerM(param1:String, ... rest) : String
      {
         var _loc4_:int = int(rest[0]) % 100;
         if(_loc4_ > 14)
         {
            _loc4_ = _loc4_ % 10;
         }
         var _loc3_:Array = param1.split("|");
         if(rest[0] != int(rest[0]))
         {
            return _loc3_[1];
         }
         if(_loc4_ == 1)
         {
            return _loc3_[0];
         }
         if(_loc4_ > 1 && _loc4_ < 5 || _loc3_.length < 3)
         {
            return _loc3_[1];
         }
         return _loc3_[2];
      }
      
      override public function triggerP(param1:String, ... rest) : String
      {
         var _loc3_:Array = param1.split("|");
         return _loc3_[0];
      }
   }
}
