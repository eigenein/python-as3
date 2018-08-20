package battle
{
   import battle.data.BattleHeroStatistics;
   import battle.data.DamageType;
   import battle.hooks.GenericHookListener;
   import battle.hooks.GenericHook_battle_DamageValue;
   import battle.hooks.HookedValue;
   import battle.skills.Context;
   import battle.stats.ElementStats;
   import battle.utils.Version;
   import flash.Boot;
   
   public class DamageManager
   {
      
      public static var DAMAGE_MISSED:String = "missed";
      
      public static var DAMAGE_DODGED:String = "dodged";
      
      public static var DAMAGE_CRITED:String = "crited";
      
      public static var DAMAGE_NORMAL:String = "normal";
       
      
      public var randomSource:Function;
      
      public var config:BattleConfig;
      
      public function DamageManager(param1:Function = undefined, param2:BattleConfig = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         randomSource = param1;
         config = param2;
      }
      
      public function dealDamage(param1:DamageValue) : void
      {
         var _loc2_:* = null as HeroStats;
         var _loc4_:int = 0;
         var _loc5_:* = null as BattleHeroStatistics;
         var _loc7_:* = NaN;
         var _loc8_:* = 0;
         var _loc9_:* = NaN;
         var _loc10_:* = null as GenericHook_battle_DamageValue;
         var _loc11_:* = null as DamageValue;
         var _loc12_:* = null as HookedValue;
         var _loc13_:* = null as GenericHookListener;
         var _loc14_:* = null as BattleHeroStatistics;
         var _loc15_:* = null as Vector.<int>;
         if(param1.currentTarget.get_isDead())
         {
            return;
         }
         if(param1.sourceValue <= 0 || param1.resultValue <= 0)
         {
            return;
         }
         if(param1.source.hero == null)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = param1.source.hero.updatedStats();
         }
         var _loc3_:HeroStats = param1.currentTarget.updatedStats();
         if(param1.type == DamageType.PHYSICAL && _loc2_ != null)
         {
            if(_loc2_.accuracy != 0)
            {
               _loc4_ = Context.engine.randomSource(1,100);
               BattleCore.lastRandomRoll = _loc4_;
               param1.missed = Number(100 + _loc2_.accuracy) < _loc4_;
            }
            if(param1.currentTarget.canDodge.enabled)
            {
               _loc4_ = Context.engine.randomSource(1,int(Number(_loc3_.dodge + _loc2_.antidodge)));
               BattleCore.lastRandomRoll = _loc4_;
               param1.dodged = _loc3_.dodge >= _loc4_;
               param1.dodgeRoll = BattleCore.lastRandomRoll;
            }
         }
         if(param1.missed || param1.dodged)
         {
            if(BattleLog.doLog)
            {
               BattleLog.m.damage(param1);
               BattleLog.m.damageEvent(param1);
            }
            _loc5_ = param1.currentTarget.state.statistics;
            if(param1.missed)
            {
               _loc5_.damageMissed = _loc5_.damageMissed + param1.resultValue;
            }
            if(param1.dodged)
            {
               _loc5_.damageDodged = _loc5_.damageDodged + param1.resultValue;
            }
            param1.resultValue = 0;
            return;
         }
         var _loc6_:* = 0;
         if(_loc2_ == null)
         {
            if(param1.type == DamageType.PHYSICAL)
            {
               _loc7_ = Number(_loc3_.armor);
               _loc7_ = Number(_loc7_);
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               param1.resultValue = int(param1.resultValue / (Number(1 + _loc7_ / 3000)));
            }
            else if(param1.type == DamageType.MAGIC)
            {
               _loc7_ = Number(_loc3_.magicResist);
               _loc7_ = Number(_loc7_);
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               param1.resultValue = int(param1.resultValue / (Number(1 + _loc7_ / 3000)));
            }
            if(param1.element != null && param1.currentTarget.desc.element != null)
            {
               _loc4_ = 10;
               if(!ElementStats.stringIsCounterToString(param1.element,param1.currentTarget.desc.element.element))
               {
               }
               if(param1.currentTarget.team.direction == -1 || ElementStats.stringIsCounterToString(param1.currentTarget.desc.element.element,param1.element))
               {
                  _loc8_ = param1.hitLevel - param1.currentTarget.desc.level;
                  if(_loc8_ > 0)
                  {
                     _loc7_ = Number(_loc4_ / (_loc4_ + _loc8_));
                  }
                  else
                  {
                     _loc7_ = 1;
                  }
                  _loc9_ = Number(param1.currentTarget.desc.element.elementArmor * _loc7_);
                  if(_loc9_ < 0)
                  {
                     _loc9_ = 0;
                  }
                  param1.resultValue = int(param1.resultValue / (Number(1 + _loc9_ / 300000)));
               }
            }
         }
         else
         {
            if(param1.type == DamageType.PHYSICAL)
            {
               _loc4_ = Context.engine.randomSource(1,int(Number(_loc2_.physicalCritChance + _loc3_.anticrit)));
               BattleCore.lastRandomRoll = _loc4_;
               param1.crited = _loc2_.physicalCritChance >= _loc4_;
               param1.critRoll = BattleCore.lastRandomRoll;
               _loc7_ = Number(_loc3_.armor);
               _loc7_ = Number(_loc7_ - _loc2_.armorPenetration);
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               param1.resultValue = int(param1.resultValue / (Number(1 + _loc7_ / 3000)));
            }
            else if(param1.type == DamageType.MAGIC)
            {
               _loc7_ = Number(_loc3_.magicResist);
               _loc7_ = Number(_loc7_ - _loc2_.magicPenetration);
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               param1.resultValue = int(param1.resultValue / (Number(1 + _loc7_ / 3000)));
            }
            if(param1.source.hero.desc.element != null && param1.currentTarget.desc.element != null)
            {
               _loc4_ = 10;
               if(param1.source.hero.desc.element.isCounterTo(param1.currentTarget.desc.element))
               {
                  _loc8_ = param1.currentTarget.desc.level - param1.source.hero.desc.level;
                  if(_loc8_ > 0)
                  {
                     _loc7_ = Number(_loc4_ / (_loc4_ + _loc8_));
                  }
                  else
                  {
                     _loc7_ = 1;
                  }
                  _loc9_ = Number(param1.resultValue / _loc2_.physicalAttack * (_loc2_.physicalAttack + param1.source.hero.desc.element.elementAttack * _loc7_));
                  param1.resultValue = int(Number(_loc9_ + 0.5));
               }
               if(param1.currentTarget.team.direction == -1 || param1.currentTarget.desc.element.isCounterTo(param1.source.hero.desc.element))
               {
                  _loc8_ = param1.source.hero.desc.level - param1.currentTarget.desc.level;
                  if(_loc8_ > 0)
                  {
                     _loc7_ = Number(_loc4_ / (_loc4_ + _loc8_));
                  }
                  else
                  {
                     _loc7_ = 1;
                  }
                  _loc9_ = Number(param1.currentTarget.desc.element.elementArmor * _loc7_);
                  if(_loc9_ < 0)
                  {
                     _loc9_ = 0;
                  }
                  param1.resultValue = int(param1.resultValue / (Number(1 + _loc9_ / 300000)));
               }
            }
         }
         if(param1.crited)
         {
            param1.resultValue = int(param1.resultValue * config.critMultiplier);
         }
         param1.currentTarget.beforeTakeDamage(param1);
         if(param1.missed || param1.dodged || param1.resultValue <= 0)
         {
            if(BattleLog.doLog)
            {
               BattleLog.m.damage(param1);
               BattleLog.m.damageEvent(param1);
            }
            _loc5_ = param1.currentTarget.state.statistics;
            if(param1.missed)
            {
               _loc5_.damageMissed = _loc5_.damageMissed + param1.resultValue;
            }
            if(param1.dodged)
            {
               _loc5_.damageDodged = _loc5_.damageDodged + param1.resultValue;
            }
         }
         else
         {
            if(param1.source.hero != null)
            {
               _loc10_ = param1.source.hero.hooks.dealDamage;
               _loc11_ = param1;
               if(_loc10_.listeners == null)
               {
                  param1 = _loc11_;
               }
               else
               {
                  if(int(HookedValue.pool.length) > 0)
                  {
                     _loc12_ = HookedValue.pool.pop();
                     _loc12_.value = _loc11_;
                  }
                  else
                  {
                     _loc12_ = new HookedValue(_loc11_);
                  }
                  _loc13_ = _loc10_.listeners;
                  do
                  {
                     _loc13_.callback(_loc12_);
                     _loc13_ = _loc13_.next;
                  }
                  while(_loc13_ != null);
                  
                  _loc11_ = _loc12_.value;
                  _loc12_.value = null;
                  HookedValue.pool.push(_loc12_);
                  param1 = _loc11_;
               }
            }
            param1.applied = true;
            if(BattleLog.doLog)
            {
               BattleLog.m.damage(param1);
            }
            _loc5_ = param1.currentTarget.state.statistics;
            if(param1.source.hero == null)
            {
               _loc14_ = null;
            }
            else
            {
               _loc14_ = param1.source.hero.state.statistics;
            }
            if(param1.type == DamageType.PHYSICAL)
            {
               _loc5_.physicalDamageRecieved = _loc5_.physicalDamageRecieved + param1.resultValue;
               _loc5_.physicalDamageResisted = _loc5_.physicalDamageResisted + (param1.sourceValue - param1.resultValue);
               if(_loc14_ != null)
               {
                  _loc14_.physicalDamageDealt = _loc14_.physicalDamageDealt + param1.resultValue;
               }
            }
            else if(param1.type == DamageType.MAGIC)
            {
               _loc5_.magicDamageRecieved = _loc5_.magicDamageRecieved + param1.resultValue;
               _loc5_.magicDamageResisted = _loc5_.magicDamageResisted + (param1.sourceValue - param1.resultValue);
               if(_loc14_ != null)
               {
                  _loc14_.magicDamageDealt = _loc14_.magicDamageDealt + param1.resultValue;
               }
            }
            _loc5_.damageRecieved = _loc5_.damageRecieved + param1.resultValue;
            if(_loc14_ != null)
            {
               _loc14_.damageDealt = _loc14_.damageDealt + param1.resultValue;
               if(param1.source.skill.tier < int(_loc14_.damageBySkill.length))
               {
                  _loc15_ = _loc14_.damageBySkill;
                  _loc15_[param1.source.skill.tier] = _loc15_[param1.source.skill.tier] + param1.resultValue;
               }
            }
            _loc4_ = -int(param1.currentTarget.modifyHp(int(-param1.resultValue)));
            if(_loc2_ != null)
            {
               if(Version.current > 103)
               {
                  if(_loc2_.lifesteal > 0 && param1.currentTarget != param1.source.hero)
                  {
                     param1.source.hero.heal(param1.resultValue * _loc2_.lifesteal / 100,param1.source);
                  }
               }
               else if(_loc2_.lifesteal > 0)
               {
                  param1.source.hero.heal(param1.resultValue * _loc2_.lifesteal / 100,param1.source);
               }
            }
            if(param1.currentTarget.get_isDead())
            {
               if(param1.source.hero != null)
               {
                  param1.source.hero.increaseEnergy(param1.currentTarget.energyPerKill);
               }
               if(BattleLog.doLog)
               {
                  BattleLog.m.heroDead(param1.currentTarget);
               }
            }
         }
      }
   }
}
