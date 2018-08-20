package com.progrestar.common.lang
{
   import com.progrestar.common.Logger;
   import flash.utils.Dictionary;
   
   public class Translate
   {
      
      public static var logger:Logger = Logger.getLogger(Translate);
      
      public static var returnDictionaryMissedKey:Boolean = true;
      
      public static var dictionary:Dictionary = new Dictionary();
      
      private static var missed:Dictionary = new Dictionary();
      
      private static const paramsI:RegExp = /[0-9]+/g;
      
      private static const paramsR:RegExp = /%(param[0-9]+[,]*)+%/g;
      
      private static var locale:Locale;
       
      
      public function Translate()
      {
         super();
      }
      
      public static function init(param1:Locale) : void
      {
         locale = param1;
      }
      
      public static function prepare(param1:String, param2:String) : void
      {
         dictionary[param1] = param2;
      }
      
      public static function has(param1:String) : Boolean
      {
         return dictionary && dictionary[param1];
      }
      
      public static function fastTranslate(param1:String, param2:Array = null) : String
      {
         var _loc4_:* = 0;
         var _loc3_:* = null;
         var _loc5_:String = dictionary[param1];
         if(_loc5_)
         {
            if(param2)
            {
               _loc4_ = uint(0);
               while(_loc4_ < param2.length)
               {
                  _loc3_ = param2[_loc4_];
                  _loc5_ = _loc5_.replace("%param" + (_loc4_ + 1) + "%",_loc3_);
                  _loc4_++;
               }
            }
            return _loc5_;
         }
         if(!missed[param1])
         {
            missed[param1] = true;
            logger.warn("translate::Dictionary missed",param1);
         }
         return !!returnDictionaryMissedKey?param1:"";
      }
      
      public static function translate(param1:String) : String
      {
         return dictionary[param1] || param1;
      }
      
      public static function translateArgs(param1:String, ... rest) : String
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function genderTriggerString(param1:Boolean) : String
      {
         return !!param1?"m":"f";
      }
   }
}
