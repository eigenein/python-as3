package battle.objects
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.effects.IStatsInvalidator;
   import battle.skills.Effect;
   import battle.skills.Skill;
   import battle.skills.TeamEffect;
   import battle.utils.Version;
   import flash.Boot;
   
   public class EffectContainer
   {
       
      
      public var statsInvalidator:IStatsInvalidator;
      
      public var effects:Vector.<Effect>;
      
      public function EffectContainer(param1:IStatsInvalidator = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         effects = new Vector.<Effect>();
         statsInvalidator = param1;
      }
      
      public function removeEffectsFromTeam(param1:Team) : Boolean
      {
         var _loc4_:* = null as Hero;
         var _loc2_:Boolean = false;
         var _loc3_:int = effects.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            if(_loc3_ < int(effects.length))
            {
               _loc4_ = effects[_loc3_].skillCast.hero;
               if(_loc4_ != null && _loc4_.team == param1 && effects[_loc3_].environmental == false)
               {
                  effects[_loc3_].cancel();
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      public function removeEffects(param1:Vector.<String>) : void
      {
         var _loc2_:int = effects.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(int(param1.indexOf(effects[_loc2_].ident)) != -1)
            {
               effects[_loc2_].cancel();
            }
         }
      }
      
      public function removeEffectDuplicate(param1:Effect) : Effect
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Effect;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(Version.current > 113)
         {
            _loc2_ = effects.length;
            while(true)
            {
               _loc2_--;
               if(_loc2_ <= 0)
               {
                  break;
               }
               _loc3_ = effects[_loc2_];
               if(_loc3_.skillCast.skill == param1.skillCast.skill && _loc3_.ident == param1.ident && _loc3_ != param1)
               {
                  _loc3_.cancel();
               }
            }
         }
         else
         {
            _loc2_ = 0;
            _loc4_ = effects.length;
            while(_loc2_ < _loc4_)
            {
               _loc2_++;
               _loc5_ = _loc2_;
               _loc3_ = effects[_loc5_];
               if(_loc3_.skillCast.skill == param1.skillCast.skill && _loc3_.ident == param1.ident && _loc3_ != param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function removeEffectByName(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = effects.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            if(effects[_loc3_].ident == param1)
            {
               effects[_loc3_].cancel();
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function removeEffect(param1:Effect) : Boolean
      {
         var _loc2_:int = effects.indexOf(param1);
         if(_loc2_ == -1)
         {
            return false;
         }
         var _loc3_:Vector.<Effect> = effects;
         var _loc4_:* = int(_loc3_.length) - 1;
         if(_loc4_ >= 0)
         {
            _loc3_[_loc2_] = _loc3_[_loc4_];
            _loc3_.length = _loc4_;
         }
         statsInvalidator.invalidateStats();
         return true;
      }
      
      public function removeAllEffects() : void
      {
         while(int(effects.length) > 0)
         {
            effects[0].cancel();
         }
      }
      
      public function getSameEffect(param1:Effect) : Effect
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = effects.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            if(effects[_loc4_].ident == param1.ident && effects[_loc4_] != param1 && effects[_loc4_].skillCast.skill == param1.skillCast.skill)
            {
               return effects[_loc4_];
            }
         }
         return null;
      }
      
      public function getEffectBySkill(param1:BattleSkillDescription) : Effect
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = effects.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            if(effects[_loc4_].skillCast.skill == param1)
            {
               return effects[_loc4_];
            }
         }
         return null;
      }
      
      public function getEffect(param1:String, param2:Skill = undefined) : Effect
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = effects.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(effects[_loc5_].ident == param1)
            {
               return effects[_loc5_];
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = effects.length;
         var _loc2_:Vector.<Effect> = effects.concat();
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_[_loc1_].dispose();
         }
      }
      
      public function applyToTeam(param1:Team, param2:TeamEffect, param3:Number) : TeamEffect
      {
         var _loc4_:* = null as Vector.<Effect>;
         var _loc6_:* = null as Effect;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         _loc4_ = effects;
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
               _loc6_.hooks.applyEffect(_loc6_,param2);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         var _loc7_:Vector.<Hero> = param1.heroes;
         _loc5_ = _loc7_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc8_ = _loc7_[_loc5_];
            _loc4_ = effects;
            _loc9_ = _loc4_.length;
            while(true)
            {
               _loc9_--;
               if(_loc9_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc4_[_loc9_];
               if(_loc6_.hooks.applyEffect != null)
               {
                  _loc10_ = _loc6_.target;
                  _loc6_.setTarget(_loc8_);
                  _loc6_.hooks.applyEffect(_loc6_,param2);
                  _loc6_.setTarget(_loc10_);
               }
               while(_loc9_ > int(_loc4_.length))
               {
                  _loc9_--;
               }
            }
         }
         if(param2.disposed)
         {
            return null;
         }
         if(param3 != 1.0e100 && param3 > 0)
         {
            param2.updateDuration(param3);
         }
         effects.push(param2);
         param2.applyToTeam(param1);
         statsInvalidator.invalidateStats();
         return param2;
      }
      
      public function applyToHero(param1:Hero, param2:Effect, param3:Number) : Effect
      {
         var _loc6_:* = null as Effect;
         var _loc7_:* = null as Hero;
         var _loc4_:Vector.<Effect> = effects;
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
               _loc6_.hooks.applyEffect(_loc6_,param2);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         _loc4_ = param1.team.effects.effects;
         _loc5_ = _loc4_.length;
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
               _loc6_.hooks.applyEffect(_loc6_,param2);
               _loc6_.setTarget(_loc7_);
            }
            while(_loc5_ > int(_loc4_.length))
            {
               _loc5_--;
            }
         }
         if(param2.disposed)
         {
            return null;
         }
         if(param3 != 1.0e100 && param3 > 0)
         {
            param2.updateDuration(param3);
         }
         effects.push(param2);
         param2.apply(param1);
         statsInvalidator.invalidateStats();
         if(param2.disposed)
         {
            return null;
         }
         return param2;
      }
   }
}
