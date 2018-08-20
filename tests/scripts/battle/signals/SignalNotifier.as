package battle.signals
{
   import flash.Boot;
   
   public class SignalNotifier
   {
      
      public static var deep:int = 0;
      
      public static var errorStack:int = 0;
       
      
      public var name:String;
      
      public var expectedParamsCount:int;
      
      public var data;
      
      public var count:int;
      
      public var callbacksCount:int;
      
      public var callbacks:Vector.<Object>;
      
      public var blocked:Boolean;
      
      public function SignalNotifier(param1:* = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         callbacks = new Vector.<Object>();
         callbacksCount = 0;
         data = param1;
         name = param2;
         if(param1)
         {
            expectedParamsCount = 1;
         }
         else
         {
            expectedParamsCount = 0;
         }
      }
      
      public function removeAll() : Boolean
      {
         if(callbacksCount == 0)
         {
            return false;
         }
         if(blocked)
         {
            callbacks = new Vector.<Object>();
            blocked = false;
         }
         callbacksCount = 0;
         return true;
      }
      
      public function remove(param1:*) : Boolean
      {
         var _loc2_:int = callbacksCount;
         while(true)
         {
            _loc2_--;
            if(_loc2_ > 0)
            {
               if(callbacks[_loc2_] != param1)
               {
                  continue;
               }
               break;
            }
            break;
         }
         if(_loc2_ == -1)
         {
            return false;
         }
         if(blocked)
         {
            callbacks = callbacks.concat();
            blocked = false;
         }
         var _loc3_:* = callbacksCount - 1;
         callbacksCount = _loc3_;
         callbacks[_loc2_] = callbacks[_loc3_];
         return true;
      }
      
      public function get_count() : int
      {
         return callbacksCount;
      }
      
      public function fire(param1:* = undefined) : void
      {
         SignalNotifier.deep = SignalNotifier.deep + 1;
         if(SignalNotifier.deep > 100)
         {
            throw "too deep invocation in SignalNotifier " + name;
         }
         blocked = true;
         var _loc2_:Vector.<Object> = callbacks;
         var _loc3_:int = callbacksCount;
         if(data)
         {
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               _loc2_[_loc3_](data);
            }
         }
         else
         {
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               _loc2_[_loc3_]();
            }
         }
         blocked = false;
         if(SignalNotifier.errorStack > 0)
         {
            SignalNotifier.errorStack = SignalNotifier.errorStack - 1;
            null;
         }
         SignalNotifier.deep = SignalNotifier.deep - 1;
      }
      
      public function add(param1:*) : void
      {
         var _loc2_:int = callbacksCount;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(callbacks[_loc2_] == param1)
            {
               return;
            }
         }
         var _loc3_:int = callbacksCount;
         callbacksCount = callbacksCount + 1;
         callbacks[_loc3_] = param1;
      }
   }
}
