package com.progrestar.common
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Logger
   {
      
      public static const FATAL:int = 16;
      
      public static const ERROR:int = 8;
      
      public static const WARNING:int = 4;
      
      public static const DEBUG:int = 2;
      
      private static const _loggers:Dictionary = new Dictionary();
      
      private static const _handlers:Array = [];
       
      
      private var _category:String;
      
      public function Logger()
      {
         super();
      }
      
      public static function getLogger(param1:*) : Logger
      {
         var _loc2_:String = param1 is String?param1:getQualifiedClassName(param1);
         var _loc3_:Logger = _loggers[_loc2_];
         if(_loc3_ == null)
         {
            var _loc4_:* = new Logger();
            _loggers[_loc2_] = _loc4_;
            _loc3_ = _loc4_;
            _loc3_._category = _loc2_;
         }
         return _loc3_;
      }
      
      public static function addHandler(param1:Function, param2:int = 2, param3:* = "*") : void
      {
         var _loc4_:String = param3 is String?param3:getQualifiedClassName(param3);
         _handlers.push(new Handler(param1,param2,_loc4_));
      }
      
      public function fatal(... rest) : void
      {
         log(16,rest);
      }
      
      public function error(... rest) : void
      {
         log(8,rest);
      }
      
      public function warn(... rest) : void
      {
         log(4,rest);
      }
      
      public function debug(... rest) : void
      {
         log(2,rest);
      }
      
      private function log(param1:int, param2:Array) : void
      {
         var _loc4_:String = format(param1,param2);
         var _loc6_:int = 0;
         var _loc5_:* = _handlers;
         for each(var _loc3_ in _handlers)
         {
            _loc3_.invoke(param1,_category,_loc4_);
         }
      }
      
      private function format(param1:int, param2:Array) : String
      {
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:Date = new Date();
         var _loc5_:String = _loc3_.fullYear + "/" + _loc3_.month + "/" + _loc3_.day + " " + _loc3_.hours + ":" + _loc3_.minutes + ":" + _loc3_.seconds + "." + _loc3_.milliseconds;
         switch(int(param1) - 2)
         {
            case 0:
               _loc7_ = "Debug";
               break;
            default:
               _loc7_ = "Unknown";
               break;
            case 2:
            default:
            default:
            default:
               _loc7_ = "Warning";
               break;
            case 6:
            default:
            default:
            default:
            default:
            default:
            default:
            default:
               _loc7_ = "Error";
               break;
            case 14:
               _loc7_ = "Fatal";
         }
         var _loc4_:String = _loc5_ + " | " + _category + " | [" + _loc7_ + "] ";
         if(param2 == null)
         {
            return _loc4_;
         }
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc4_ = _loc4_ + ((_loc6_ > 0?", ":"") + (param2[_loc6_] != null?param2[_loc6_].toString():"null"));
            _loc6_++;
         }
         return _loc4_;
      }
   }
}

class Handler
{
    
   
   private var _callback:Function;
   
   private var _level:int;
   
   private var _category:String;
   
   function Handler(param1:Function, param2:int, param3:String)
   {
      super();
      _callback = param1;
      _level = param2;
      _category = param3;
   }
   
   public function invoke(param1:int, param2:String, param3:String) : void
   {
      if(isSuitable(param1,param2))
      {
         _callback.apply(null,[param3]);
      }
   }
   
   private function isSuitable(param1:int, param2:String) : Boolean
   {
      if(param1 >= _level)
      {
         if(_category == "*" || param2.indexOf(_category) == 0)
         {
            return true;
         }
      }
      return false;
   }
}
