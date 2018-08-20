package com.progrestar.common.lang
{
   public class Locale
   {
       
      
      public const TRIGGER_PATTERN:RegExp = /\$([a-z])([^\(]*)\(([^\(\)]+?)\)/gi;
      
      private var _id:String;
      
      public function Locale(param1:String)
      {
         super();
         this._id = param1;
      }
      
      public function get isAsian() : Boolean
      {
         var _loc1_:Boolean = LocaleEnum.ASIAN_LANGUAGES.indexOf(this) == -1?false:true;
         return _loc1_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function triggerG(param1:String, ... rest) : String
      {
         return "";
      }
      
      public function triggerM(param1:String, ... rest) : String
      {
         return "";
      }
      
      public function triggerP(param1:String, ... rest) : String
      {
         var _loc3_:Array = param1.split("|");
         if(int(rest[0]) == 1)
         {
            return _loc3_[0];
         }
         if(int(rest[0]) == 2)
         {
            return _loc3_[1];
         }
         if(int(rest[0]) == 3)
         {
            return _loc3_[2];
         }
         return _loc3_[3];
      }
   }
}
