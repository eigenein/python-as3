package battle.hooks
{
   import battle.skills.Effect;
   
   public class HookableNumberModifier
   {
      
      public static var _pool:Vector.<HookableNumberModifier>;
      
      public static var _pooled:int = 0;
       
      
      public var multiplier:Number;
      
      public var flatMultiplier:Number;
      
      public var effect:Effect;
      
      public var addition:Number;
      
      public function HookableNumberModifier()
      {
      }
      
      public static function create(param1:Number = 0, param2:Number = 1, param3:Number = 1, param4:Effect = undefined) : HookableNumberModifier
      {
         var _loc5_:* = null as HookableNumberModifier;
         var _loc6_:* = 0;
         if(HookableNumberModifier._pooled == 0)
         {
            _loc5_ = new HookableNumberModifier();
         }
         else
         {
            _loc6_ = HookableNumberModifier._pooled - 1;
            HookableNumberModifier._pooled = _loc6_;
            _loc5_ = HookableNumberModifier._pool[_loc6_];
         }
         _loc5_.addition = param1;
         _loc5_.multiplier = param2;
         _loc5_.flatMultiplier = param3;
         _loc5_.effect = param4;
         return _loc5_;
      }
      
      public function dispose() : void
      {
      }
   }
}
