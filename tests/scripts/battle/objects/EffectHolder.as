package battle.objects
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.Hero;
   import battle.action.Action;
   import battle.data.BattleSkillDescription;
   import battle.data.HeroState;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.signals.SignalNotifier;
   import battle.skills.Context;
   import battle.skills.Effect;
   import battle.skills.EffectFactory;
   import battle.skills.EffectHooks;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class EffectHolder extends StatsHolder
   {
       
      
      public var onHpZero:SignalNotifier;
      
      public var onEnergyFull:SignalNotifier;
      
      public var onDie:SignalNotifier;
      
      public var effects:EffectContainer;
      
      public function EffectHolder(param1:BattleEngine = undefined, param2:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onEnergyFull = new SignalNotifier(null,"Hero.onEnergyFull");
         onHpZero = new SignalNotifier(null,"Hero.onHpZero");
         onDie = new SignalNotifier(null,"Hero.onDie");
         super(param1,param2);
         effects = new EffectContainer(this);
      }
      
      public function updateEffectDuration(param1:SkillCast, param2:String, param3:Number = -1, param4:int = -1, param5:Array = undefined, param6:EffectAnimationIdent = undefined) : Effect
      {
         var _loc7_:Effect = effects.getEffect(param2);
         if(_loc7_ != null)
         {
            _loc7_.updateDuration(param3);
            return null;
         }
         return applyEffect(EffectFactory.normal(param1,param2,param5),param3,param4,param6);
      }
      
      public function rollHitrate(param1:int) : Boolean
      {
         return false;
      }
      
      public function modifyHp(param1:Number) : int
      {
         var _loc3_:* = null as HeroState;
         var _loc4_:* = 0;
         var _loc2_:int = param1;
         if(get_isDead())
         {
            return 0;
         }
         if(_loc2_ > 0)
         {
            if(state.hp >= int(getMaxHp()))
            {
               return 0;
            }
            _loc3_ = state;
            _loc4_ = _loc3_.hp + _loc2_;
            if((_loc3_.hp ^ 1694084416) != _loc3_.hpLastHashed)
            {
               Context.engine.data.b = 1;
            }
            _loc3_.hpLastHashed = _loc4_ ^ 1694084416;
            _loc3_.hp = _loc4_;
            if(state.hp > int(getMaxHp()))
            {
               _loc3_ = state;
               _loc4_ = int(getMaxHp());
               if((_loc3_.hp ^ 1694084416) != _loc3_.hpLastHashed)
               {
                  Context.engine.data.b = 1;
               }
               _loc3_.hpLastHashed = _loc4_ ^ 1694084416;
               _loc3_.hp = _loc4_;
            }
         }
         else
         {
            if(state.hp <= 0)
            {
               return 0;
            }
            _loc3_ = state;
            _loc4_ = _loc3_.hp + _loc2_;
            if((_loc3_.hp ^ 1694084416) != _loc3_.hpLastHashed)
            {
               Context.engine.data.b = 1;
            }
            _loc3_.hpLastHashed = _loc4_ ^ 1694084416;
            _loc3_.hp = _loc4_;
            if(state.hp <= 0)
            {
               _loc3_ = state;
               if((_loc3_.hp ^ 1694084416) != _loc3_.hpLastHashed)
               {
                  Context.engine.data.b = 1;
               }
               _loc3_.hpLastHashed = 1694084416;
               _loc3_.hp = 0;
            }
            if(state.hp == 0)
            {
               onHpZero.fire();
            }
         }
         return _loc2_;
      }
      
      public function heal(param1:Number, param2:SkillCast) : void
      {
         modifyHp(param1);
         state.statistics.healingReceived = Number(state.statistics.healingReceived + param1);
         if(param2.hero != null)
         {
            param2.hero.state.statistics.healingDealt = param2.hero.state.statistics.healingDealt + int(param1);
         }
      }
      
      public function getSkillValue(param1:BattleSkillDescription, param2:Action) : Number
      {
         if(statsInvalidated)
         {
            updateStats();
         }
         return Number(param2.getValue(stats,int(EffectHooks.hook_getSkillLevel(effects,param1,param1.level))));
      }
      
      public function getSkillLevel(param1:BattleSkillDescription) : int
      {
         return int(EffectHooks.hook_getSkillLevel(effects,param1,param1.level));
      }
      
      public function getEffect(param1:String) : Effect
      {
         return effects.getEffect(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         effects.dispose();
      }
      
      public function damageOverTime(param1:Number, param2:SkillCast) : int
      {
         modifyHp(-param1);
         state.statistics.damageRecieved = state.statistics.damageRecieved + int(param1);
         param2.hero.state.statistics.damageDealt = param2.hero.state.statistics.damageDealt + int(param1);
         var _loc3_:Vector.<int> = param2.hero.state.statistics.damageBySkill;
         _loc3_[param2.skill.tier] = _loc3_[param2.skill.tier] + int(param1);
         return int(param1);
      }
      
      public function applyEffect(param1:Effect, param2:Number = -1, param3:int = -1, param4:EffectAnimationIdent = undefined) : Effect
      {
         var _loc6_:* = null as Hero;
         if(schedulerDisposed)
         {
            return null;
         }
         if(!rollHitrate(param3))
         {
            return null;
         }
         var _loc5_:Hero = this;
         param1 = effects.applyToHero(_loc5_,param1,param2);
         if(param1 == null)
         {
            return null;
         }
         if(isHero)
         {
            _loc6_ = this;
            if(BattleLog.doLog)
            {
               BattleLog.m.heroEffect(_loc6_,param1);
            }
         }
         if(param4 != EffectAnimationIdent.NONE)
         {
            Context.scene.addEffect(param1,this,param4);
         }
         return param1;
      }
   }
}
