package com.progrestar.common.lang
{
   public class LocaleEN extends Locale
   {
       
      
      public function LocaleEN()
      {
         super("en");
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
         var _loc3_:Array = param1.split("|");
         if(int(rest[0]) == 1)
         {
            return _loc3_[0];
         }
         return _loc3_[1];
      }
   }
}
