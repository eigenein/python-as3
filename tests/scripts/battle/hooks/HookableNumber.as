package battle.hooks
{
   import battle.signals.SignalNotifier;
   import battle.skills.Effect;
   import flash.Boot;
   
   public class HookableNumber
   {
       
      
      public var previousValue:Number;
      
      public var onChange:SignalNotifier;
      
      public var modifiersCount:int;
      
      public var modifiers:Vector.<HookableNumberModifier>;
      
      public var initialValue:Number;
      
      public function HookableNumber(param1:Number = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onChange = new SignalNotifier(this,"HookableNumber.onChange");
         modifiersCount = 0;
         modifiers = new Vector.<HookableNumberModifier>();
         initialValue = param1;
      }
      
      public function set_value(param1:Number) : Number
      {
         if(param1 == initialValue)
         {
            return param1;
         }
         initialValue = param1;
         onChange.fire();
         return param1;
      }
      
      public function setValue(param1:Number) : Number
      {
         return Number(set_value(param1));
      }
      
      public function removeEffectInfluence(param1:Effect) : void
      {
         var _loc5_:* = 0;
         var _loc2_:Number = get_value();
         var _loc3_:int = modifiersCount;
         var _loc4_:int = 0;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            if(modifiers[_loc3_].effect == param1)
            {
               _loc5_ = modifiersCount - 1;
               modifiersCount = _loc5_;
               modifiers[_loc3_] = modifiers[_loc5_];
               _loc4_++;
            }
         }
         if(_loc4_ != 0)
         {
            previousValue = _loc2_;
            onChange.fire();
         }
      }
      
      public function remove(param1:Effect = undefined) : void
      {
         if(param1 != null)
         {
            param1.onRemove.remove(removeEffectInfluence);
         }
         removeEffectInfluence(param1);
      }
      
      public function multiply(param1:Number, param2:Effect = undefined) : void
      {
         var _loc3_:* = null as HookableNumberModifier;
         var _loc4_:* = 0;
         if(param2 != null)
         {
            param2.onRemove.add(removeEffectInfluence);
         }
         previousValue = Number(get_value());
         if(HookableNumberModifier._pooled == 0)
         {
            _loc3_ = new HookableNumberModifier();
         }
         else
         {
            _loc4_ = HookableNumberModifier._pooled - 1;
            HookableNumberModifier._pooled = _loc4_;
            _loc3_ = HookableNumberModifier._pool[_loc4_];
         }
         _loc3_.addition = 0;
         _loc3_.multiplier = param1;
         _loc3_.flatMultiplier = 1;
         _loc3_.effect = param2;
         _loc4_ = int(modifiersCount);
         modifiersCount = modifiersCount + 1;
         modifiers[_loc4_] = _loc3_;
         onChange.fire();
      }
      
      public function get_value() : Number
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as HookableNumberModifier;
         var _loc1_:Number = initialValue;
         var _loc2_:* = 1;
         var _loc3_:Number = 1 - modifiersCount;
         var _loc4_:int = 0;
         var _loc5_:int = modifiersCount;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = modifiers[_loc6_];
            _loc1_ = _loc1_ + _loc7_.addition;
            _loc2_ = Number(_loc2_ * _loc7_.multiplier);
            _loc3_ = _loc3_ + _loc7_.flatMultiplier;
         }
         return _loc1_ * _loc2_ * _loc3_;
      }
      
      public function flatMultiply(param1:Number, param2:Effect = undefined) : void
      {
         var _loc3_:* = null as HookableNumberModifier;
         var _loc4_:* = 0;
         if(param2 != null)
         {
            param2.onRemove.add(removeEffectInfluence);
         }
         previousValue = Number(get_value());
         if(HookableNumberModifier._pooled == 0)
         {
            _loc3_ = new HookableNumberModifier();
         }
         else
         {
            _loc4_ = HookableNumberModifier._pooled - 1;
            HookableNumberModifier._pooled = _loc4_;
            _loc3_ = HookableNumberModifier._pool[_loc4_];
         }
         _loc3_.addition = 0;
         _loc3_.multiplier = 1;
         _loc3_.flatMultiplier = param1;
         _loc3_.effect = param2;
         _loc4_ = int(modifiersCount);
         modifiersCount = modifiersCount + 1;
         modifiers[_loc4_] = _loc3_;
         onChange.fire();
      }
      
      public function add(param1:Number, param2:Effect = undefined) : void
      {
         var _loc3_:* = null as HookableNumberModifier;
         var _loc4_:* = 0;
         if(param2 != null)
         {
            param2.onRemove.add(removeEffectInfluence);
         }
         previousValue = Number(get_value());
         if(HookableNumberModifier._pooled == 0)
         {
            _loc3_ = new HookableNumberModifier();
         }
         else
         {
            _loc4_ = HookableNumberModifier._pooled - 1;
            HookableNumberModifier._pooled = _loc4_;
            _loc3_ = HookableNumberModifier._pool[_loc4_];
         }
         _loc3_.addition = param1;
         _loc3_.multiplier = 1;
         _loc3_.flatMultiplier = 1;
         _loc3_.effect = param2;
         _loc4_ = int(modifiersCount);
         modifiersCount = modifiersCount + 1;
         modifiers[_loc4_] = _loc3_;
         onChange.fire();
      }
   }
}
