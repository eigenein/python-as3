package com.progrestar.common.util
{
   public class HashModem
   {
      
      public static const FILLER:String = "_";
      
      public static const PERMITTED_SYMBOLS:String = "_ 0123456789АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЬьЫыЪъЭэЮюЯяAaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@():,./-?_\n\"";
      
      public static const PERMITED_INPUT_SYMBOLS:String = " 0123456789АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЬьЫыЪъЭэЮюЯяAaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@():,./-?\n\"";
      
      public static const DATA_LENGTH:int = 180;
      
      public static const HASH_LENGTH:int = 252;
       
      
      public function HashModem()
      {
         super();
      }
      
      public static function demodulate(param1:String) : String
      {
         var _loc4_:int = 0;
         if(param1 == null)
         {
            throw new Error("Hash is null");
         }
         if(param1.length % 7 != 0)
         {
            throw new Error("Error hash length. Hash has length = " + param1.length);
         }
         var _loc3_:String = "";
         var _loc2_:int = param1.length / 7;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc3_ + fragmentToWord(param1.substr(_loc4_ * 7,7));
            _loc4_++;
         }
         while(_loc3_.charAt(_loc3_.length - 1) == "_")
         {
            _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
         }
         return _loc3_;
      }
      
      public static function modulate(param1:String) : String
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            throw new Error("Data is null");
         }
         if(param1.charAt(param1.length - 1) == "_")
         {
            throw new Error("Data close sybmol must not be FILLER = [_]");
         }
         if(param1.length > 180)
         {
            throw new Error("Very long data. Data length = " + param1.length);
         }
         while(param1.length % 5 != 0)
         {
            param1 = param1 + "_";
         }
         var _loc4_:String = "";
         var _loc2_:int = param1.length / 5;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc4_ + wordToFragment(param1.substr(_loc3_ * 5,5));
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function validateData(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return 3;
         }
         var _loc2_:int = param1.length;
         if(_loc2_ == 0)
         {
            return 3;
         }
         if(_loc2_ > 180)
         {
            return 2;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.charAt(_loc3_).charCodeAt(0);
            if(!(_loc4_ > 1039 && _loc4_ < 1104))
            {
               if(!(_loc4_ > 62 && _loc4_ < 123 && _loc4_ != 91 && _loc4_ != 92 && _loc4_ != 93 && _loc4_ != 94 && _loc4_ != 96))
               {
                  if(_loc4_ != 32)
                  {
                     if(!(_loc4_ > 38 && _loc4_ < 59 && _loc4_ != 42 && _loc4_ != 43))
                     {
                        if(!(_loc4_ == 10 || _loc4_ == 33 || _loc4_ == 34))
                        {
                           return 1;
                        }
                     }
                  }
               }
            }
            _loc3_++;
         }
         return 0;
      }
      
      public static function softReplacement(param1:String) : String
      {
         var _loc2_:* = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_:int = 0;
         param1 = param1.replace(/ё/g,"е");
         param1 = param1.replace(/Ё/g,"Е");
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc3_);
            if("_ 0123456789АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЬьЫыЪъЭэЮюЯяAaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@():,./-?_\n\"".indexOf(param1.charAt(_loc3_)) == -1)
            {
               trace("Unsupported symbol [" + _loc2_ + "] deleted in \"" + param1 + "\"");
               param1 = param1.substring(0,_loc3_) + param1.substr(_loc3_ + 1);
            }
            else
            {
               _loc3_++;
            }
         }
         return param1;
      }
      
      private static function fragmentToWord(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = fragmentCharToKey(param1.charAt(0)) * 35 + fragmentCharToKey(param1.charAt(1));
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = (int(Boolean(_loc3_ & 1 << _loc4_ * 2 + 1))) * 2 + (int(Boolean(_loc3_ & 1 << _loc4_ * 2)));
            _loc5_ = _loc5_ + wordKeyToChar(fragmentCharToKey(param1.charAt(2 + _loc4_)) + _loc2_ * 35);
            _loc4_++;
         }
         return _loc5_;
      }
      
      private static function wordToFragment(param1:String) : String
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = "";
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = wordCharToKey(param1.charAt(_loc5_));
            if(_loc3_ == 140)
            {
               _loc2_ = _loc2_ + fragmentKeyToChar(35);
               _loc4_ = _loc4_ + (3 << _loc5_ * 2);
            }
            else
            {
               _loc2_ = _loc2_ + fragmentKeyToChar(_loc3_ % 35);
               _loc4_ = _loc4_ + (int(_loc3_ / 35) << _loc5_ * 2);
            }
            _loc5_++;
         }
         _loc2_ = fragmentKeyToChar(int(_loc4_ / 35)) + fragmentKeyToChar(_loc4_ % 35) + _loc2_;
         return _loc2_;
      }
      
      private static function fragmentCharToKey(param1:String) : int
      {
         var _loc2_:int = param1.charCodeAt(0);
         return _loc2_ - (_loc2_ > 57?87:48);
      }
      
      private static function fragmentKeyToChar(param1:int) : String
      {
         return String.fromCharCode(param1 + (param1 > 9?87:48));
      }
      
      private static function wordCharToKey(param1:String) : int
      {
         var _loc2_:int = param1.charCodeAt(0);
         if(_loc2_ > 1039)
         {
            return _loc2_ - 963;
         }
         if(_loc2_ > 96)
         {
            return _loc2_ - 46;
         }
         if(_loc2_ == 95)
         {
            return 50;
         }
         if(_loc2_ == 32)
         {
            return 1;
         }
         if(_loc2_ > 62)
         {
            return _loc2_ - 41;
         }
         if(_loc2_ > 43)
         {
            return _loc2_ - 37;
         }
         if(_loc2_ == 10)
         {
            return 0;
         }
         if(_loc2_ < 35)
         {
            return _loc2_ - 31;
         }
         if(_loc2_ < 42)
         {
            return _loc2_ - 35;
         }
         throw new Error("Unexpected char [" + param1 + "] in word");
      }
      
      private static function wordKeyToChar(param1:int) : String
      {
         if(param1 > 76)
         {
            param1 = param1 + 963;
         }
         else if(param1 > 50)
         {
            param1 = param1 + 46;
         }
         else if(param1 == 50)
         {
            param1 = 95;
         }
         else if(param1 == 1)
         {
            param1 = 32;
         }
         else if(param1 > 21)
         {
            param1 = param1 + 41;
         }
         else if(param1 > 6)
         {
            param1 = param1 + 37;
         }
         else if(param1 == 0)
         {
            param1 = 10;
         }
         else if(param1 < 4)
         {
            param1 = param1 + 31;
         }
         else if(param1 < 7)
         {
            param1 = param1 + 35;
         }
         else
         {
            throw new Error("Unexpected key [" + param1 + "] in word. It`s mean [" + String.fromCharCode(param1) + "] symbol");
         }
         return String.fromCharCode(param1);
      }
   }
}
