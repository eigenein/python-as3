package battle.hooks
{
   public class GenericHook_Int
   {
       
      
      public var listeners:GenericHookListener;
      
      public function GenericHook_Int()
      {
      }
      
      public function remove(param1:Function) : void
      {
         var _loc2_:GenericHookListener = listeners;
         var _loc3_:GenericHookListener = null;
         while(_loc2_ != null && _loc2_.callback != param1)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_ == null)
         {
            listeners = _loc2_.next;
         }
         else
         {
            _loc3_.next = _loc2_.next;
         }
      }
      
      public function numListeners() : int
      {
         if(listeners == null)
         {
            return 0;
         }
         var _loc1_:int = 0;
         var _loc2_:GenericHookListener = listeners;
         do
         {
            _loc1_++;
            _loc2_ = _loc2_.next;
         }
         while(_loc2_ != null);
         
         return _loc1_;
      }
      
      public function call(param1:int) : int
      {
         var _loc2_:* = null as HookedValue;
         var _loc3_:* = null as GenericHookListener;
         if(listeners == null)
         {
            return param1;
         }
         if(int(HookedValue.pool.length) > 0)
         {
            _loc2_ = HookedValue.pool.pop();
            _loc2_.value = param1;
         }
         else
         {
            _loc2_ = new HookedValue(param1);
         }
         _loc3_ = listeners;
         do
         {
            _loc3_.callback(_loc2_);
            _loc3_ = _loc3_.next;
         }
         while(_loc3_ != null);
         
         param1 = _loc2_.value;
         _loc2_.value = null;
         HookedValue.pool.push(_loc2_);
         return param1;
      }
      
      public function add(param1:Function) : void
      {
         listeners = new GenericHookListener(param1,listeners);
      }
   }
}
