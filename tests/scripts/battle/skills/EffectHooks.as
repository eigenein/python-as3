package battle.skills
{
   import battle.DamageValue;
   import battle.Hero;
   import battle.HeroStats;
   import battle.data.BattleSkillDescription;
   import battle.hooks.HookedValue;
   import battle.hooks.IntValue;
   import battle.objects.EffectContainer;
   
   public class EffectHooks
   {
      
      public static var intValue:IntValue = new IntValue(0);
       
      
      public var updateHeroStats:Function;
      
      public var updateHeroProcessedStats:Function;
      
      public var takeDamage:Function;
      
      public var removed:Function;
      
      public var getSkillLevel:Function;
      
      public var applyHeal:Function;
      
      public var applyEffect:Function;
      
      public var applyDamage:Function;
      
      public function EffectHooks()
      {
      }
      
      public static function hook_applyDamage(param1:Hero, param2:DamageValue) : void
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc3_:EffectContainer = param1.effects;
         var _loc4_:Vector.<Effect> = _loc3_.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.applyDamage != null)
            {
               _loc6_.hooks.applyDamage(_loc6_,param2);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         _loc3_ = param1.team.effects;
         _loc4_ = _loc3_.effects;
         _loc5_ = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.applyDamage != null)
            {
               _loc7_ = _loc6_.target;
               _loc6_.setTarget(param1);
               _loc6_.hooks.applyDamage(_loc6_,param2);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
      }
      
      public static function hook_takeDamage(param1:Hero, param2:DamageValue) : void
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc3_:EffectContainer = param1.effects;
         var _loc4_:Vector.<Effect> = _loc3_.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.takeDamage != null)
            {
               _loc6_.hooks.takeDamage(_loc6_,param2);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         _loc3_ = param1.team.effects;
         _loc4_ = _loc3_.effects;
         _loc5_ = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.takeDamage != null)
            {
               _loc7_ = _loc6_.target;
               _loc6_.setTarget(param1);
               _loc6_.hooks.takeDamage(_loc6_,param2);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
      }
      
      public static function hook_applyHeal(param1:Hero, param2:SkillCast, param3:HookedValue) : void
      {
         var _loc7_:* = null as Effect;
         var _loc8_:* = null as Hero;
         var _loc4_:EffectContainer = param1.effects;
         var _loc5_:Vector.<Effect> = _loc4_.effects;
         var _loc6_:int = _loc5_.length;
         while(true)
         {
            _loc6_--;
            if(_loc6_ <= 0)
            {
               break;
            }
            _loc7_ = _loc5_[_loc6_];
            if(_loc7_.hooks.applyHeal != null)
            {
               _loc7_.hooks.applyHeal(_loc7_,param2,param3);
            }
            while(_loc6_ > int(_loc5_.length))
            {
               _loc6_--;
            }
         }
         _loc4_ = param1.team.effects;
         _loc5_ = _loc4_.effects;
         _loc6_ = _loc5_.length;
         while(true)
         {
            _loc6_--;
            if(_loc6_ <= 0)
            {
               break;
            }
            _loc7_ = _loc5_[_loc6_];
            if(_loc7_.hooks.applyHeal != null)
            {
               _loc8_ = _loc7_.target;
               _loc7_.setTarget(param1);
               _loc7_.hooks.applyHeal(_loc7_,param2,param3);
               _loc7_.setTarget(_loc8_);
            }
            while(_loc6_ > int(_loc5_.length))
            {
               _loc6_--;
            }
         }
      }
      
      public static function hook_applyEffect(param1:EffectContainer, param2:Effect) : void
      {
         var _loc5_:* = null as Effect;
         var _loc3_:Vector.<Effect> = param1.effects;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.hooks.applyEffect != null)
            {
               _loc5_.hooks.applyEffect(_loc5_,param2);
            }
            while(_loc4_ > int(_loc3_.length))
            {
               _loc4_--;
            }
         }
      }
      
      public static function hook_applyEffectToTeamMember(param1:Hero, param2:EffectContainer, param3:Effect) : void
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc4_:Vector.<Effect> = param2.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.applyEffect != null)
            {
               _loc7_ = _loc6_.target;
               _loc6_.setTarget(param1);
               _loc6_.hooks.applyEffect(_loc6_,param3);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
      }
      
      public static function hook_updateHeroStats(param1:EffectContainer, param2:HeroStats) : void
      {
         var _loc5_:* = null as Effect;
         var _loc3_:Vector.<Effect> = param1.effects;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.hooks.updateHeroStats != null)
            {
               _loc5_.hooks.updateHeroStats(_loc5_,param2);
            }
            while(_loc4_ > int(_loc3_.length))
            {
               _loc4_--;
            }
         }
      }
      
      public static function hook_updateTeamStats(param1:Hero, param2:EffectContainer, param3:HeroStats) : void
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc4_:Vector.<Effect> = param2.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.updateHeroStats != null)
            {
               _loc7_ = _loc6_.target;
               _loc6_.setTarget(param1);
               _loc6_.hooks.updateHeroStats(_loc6_,param3);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
      }
      
      public static function hook_updateHeroProcessedStats(param1:EffectContainer, param2:HeroStats) : void
      {
         var _loc5_:* = null as Effect;
         var _loc3_:Vector.<Effect> = param1.effects;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.hooks.updateHeroProcessedStats != null)
            {
               _loc5_.hooks.updateHeroProcessedStats(_loc5_,param2);
            }
            while(_loc4_ > int(_loc3_.length))
            {
               _loc4_--;
            }
         }
      }
      
      public static function hook_updateTeamProcessedStats(param1:Hero, param2:EffectContainer, param3:HeroStats) : void
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc4_:Vector.<Effect> = param2.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.updateHeroProcessedStats != null)
            {
               _loc7_ = _loc6_.target;
               _loc6_.setTarget(param1);
               _loc6_.hooks.updateHeroProcessedStats(_loc6_,param3);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
      }
      
      public static function hook_getSkillLevel(param1:EffectContainer, param2:BattleSkillDescription, param3:int) : int
      {
         var _loc6_:* = null as Effect;
         EffectHooks.intValue.value = param3;
         var _loc4_:Vector.<Effect> = param1.effects;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.hooks.getSkillLevel != null)
            {
               _loc6_.hooks.getSkillLevel(_loc6_,param2,EffectHooks.intValue);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         return EffectHooks.intValue.value;
      }
   }
}
