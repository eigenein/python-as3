package engine.core.utils
{
   public class Deferred
   {
      
      private static const NOT_COMPLETED:Object = {};
      
      private static const REJECTED:Object = {};
       
      
      private var value;
      
      private var callbacks:Array;
      
      public function Deferred()
      {
         value = NOT_COMPLETED;
         super();
      }
      
      public static function resolved(param1:*) : Deferred
      {
         var _loc2_:Deferred = new Deferred();
         _loc2_.resolve(param1);
         return _loc2_;
      }
      
      public static function rejected() : Deferred
      {
         var _loc1_:Deferred = new Deferred();
         _loc1_.reject();
         return _loc1_;
      }
      
      public function resolve(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         this.value = param1;
         if(callbacks)
         {
            _loc3_ = callbacks.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(callbacks[_loc2_] == true)
               {
                  callbacks[_loc2_ + 1](param1);
               }
               _loc2_ = _loc2_ + 2;
            }
         }
      }
      
      public function reject() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         this.value = REJECTED;
         if(callbacks)
         {
            _loc2_ = callbacks.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(callbacks[_loc1_] == false)
               {
                  callbacks[_loc1_ + 1]();
               }
               _loc1_ = _loc1_ + 2;
            }
         }
      }
      
      public function then(param1:Function = null, param2:Function = null) : void
      {
         if(param1 && param1.length != 1)
         {
            throw "onFulfilled should have one argument";
         }
         if(param2 && param2.length != 0)
         {
            throw "onRejected should have no arguments";
         }
         if(value != NOT_COMPLETED)
         {
            if(value != REJECTED)
            {
               param1(value);
            }
            else
            {
               param2();
            }
         }
         else
         {
            if(param1)
            {
               if(!callbacks)
               {
                  callbacks = [];
               }
               callbacks.push(true,param1);
            }
            if(param2)
            {
               if(!callbacks)
               {
                  callbacks = [];
               }
               callbacks.push(false,param2);
            }
         }
      }
   }
}
