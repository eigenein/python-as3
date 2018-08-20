package battle.hooks
{
   import flash.Boot;
   
   public class HookedValue
   {
      
      public static var pool:Vector.<HookedValue> = new Vector.<HookedValue>();
       
      
      public var value:Object;
      
      public function HookedValue(param1:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         value = param1;
      }
      
      public static function getValue(param1:Object) : HookedValue
      {
         var _loc2_:* = null as HookedValue;
         if(int(HookedValue.pool.length) > 0)
         {
            _loc2_ = HookedValue.pool.pop();
            _loc2_.value = param1;
         }
         else
         {
            _loc2_ = new HookedValue(param1);
         }
         return _loc2_;
      }
      
      public static function dispose(param1:HookedValue) : Object
      {
         HookedValue.pool.push(param1);
         return param1.value;
      }
   }
}
