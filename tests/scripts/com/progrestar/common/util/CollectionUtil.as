package com.progrestar.common.util
{
   public final class CollectionUtil
   {
       
      
      public function CollectionUtil()
      {
         super();
      }
      
      public static function map(param1:*, param2:Function) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1)
         {
            _loc3_ = param2(_loc5_);
            _loc4_.push(_loc3_);
         }
         return _loc4_;
      }
      
      public static function getItemCount(param1:*) : int
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function toArray(param1:*) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function printArrayField(param1:*, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc9_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:Array = param2.split(".");
         var _loc8_:int = _loc6_.length;
         var _loc7_:int = param1.length;
         var _loc3_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            if(_loc4_ > 0)
            {
               _loc3_ = _loc3_ + " ";
            }
            _loc9_ = param1[_loc4_];
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc9_ = _loc9_[_loc6_[_loc5_]];
               _loc5_++;
            }
            _loc3_ = _loc3_ + _loc9_;
            _loc4_++;
         }
      }
      
      public static function shuffleVector(param1:Vector.<*>) : Vector.<*>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function fold(param1:*, param2:Vector.<*>, param3:Function) : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            param1 = param3(param1,param2[_loc4_]);
            _loc4_++;
         }
         return param1;
      }
      
      public static function reduce(param1:Vector.<*>, param2:Function) : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = param1.length;
         if(_loc4_ == 0)
         {
            return null;
         }
         var _loc5_:* = param1[0];
         _loc3_ = 1;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param2(_loc5_,param1[_loc3_]);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public static function shuffleArray(param1:Array) : Array
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc5_:* = 0;
         var _loc6_:Array = param1.concat();
         var _loc3_:uint = param1.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc6_[_loc5_];
            _loc4_ = uint(Math.random() * _loc3_);
            _loc6_[_loc5_] = _loc6_[_loc4_];
            _loc6_[_loc4_] = _loc2_;
            _loc5_++;
         }
         return _loc6_;
      }
   }
}
