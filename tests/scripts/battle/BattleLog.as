package battle
{
   import battle.data.BattleHeroStatistics;
   import battle.data.DamageType;
   import battle.log.BattleLogBase;
   import battle.objects.BattleBody;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   import battle.timeline.Timeline;
   
   public class BattleLog
   {
      
      public static var m:BattleLogBase = new BattleLogBase();
      
      public static var timeline:Timeline;
      
      public static var currentTimestamp:String;
      
      public static var doLog:Boolean = false;
      
      public static var doPrint:Boolean = true;
       
      
      public function BattleLog()
      {
      }
      
      public static function getLog() : String
      {
         var _loc1_:String = BattleLog.m.getLog();
         BattleLog.m.clear();
         return _loc1_;
      }
      
      public static function clear() : void
      {
         BattleLog.m.clear();
      }
      
      public static function attachEngine(param1:BattleEngine) : void
      {
         BattleLog.m.engine = param1;
      }
      
      public static function logString(param1:String) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.logString(param1);
         }
      }
      
      public static function heroInput(param1:Hero) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroInput(param1);
         }
      }
      
      public static function customHeroInput(param1:Hero, param2:int) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.customHeroInput(param1,param2);
         }
      }
      
      public static function toggleAuto(param1:Team) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.toggleAuto(param1);
         }
      }
      
      public static function teamInput(param1:Team, param2:int) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.teamInput(param1,param2);
         }
      }
      
      public static function heroSkillCast(param1:Hero, param2:SkillCast) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroSkillCast(param1,param2);
         }
      }
      
      public static function heroUlt(param1:Hero) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroUlt(param1);
         }
      }
      
      public static function heroUltImmediate(param1:Hero) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroUltImmediate(param1);
         }
      }
      
      public static function heroUltImmediateInterrupting(param1:Hero) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroUltImmediateInterrupting(param1);
         }
      }
      
      public static function timesUp(param1:Team, param2:Team) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.timesUp(param1,param2);
         }
      }
      
      public static function teamEmpty(param1:Team) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.teamEmpty(param1);
         }
      }
      
      public static function heroDead(param1:Hero) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroDead(param1);
         }
      }
      
      public static function heroMove(param1:BattleBody, param2:Number, param3:Number) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroMove(param1,param2,param3);
         }
      }
      
      public static function heroHp(param1:Hero, param2:Number, param3:Number) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroHp(param1,param2,param3);
         }
         if(param3 > 0)
         {
            param1.state.statistics.healingReceived = Number(param1.state.statistics.healingReceived + param3);
         }
      }
      
      public static function heroEnergy(param1:Hero, param2:Number, param3:Number) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroEnergy(param1,param2,param3);
         }
         if(param3 > 0)
         {
            if(param3 > 1000 - param1.state.energy)
            {
               param1.state.statistics.energyGained = Number(param1.state.statistics.energyGained + (1000 - param1.state.energy));
            }
            else
            {
               param1.state.statistics.energyGained = Number(param1.state.statistics.energyGained + param3);
            }
         }
         if(param3 < 0)
         {
            param1.state.statistics.energySpent = param1.state.statistics.energySpent - param3;
         }
      }
      
      public static function heroEffect(param1:Hero, param2:Effect) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroEffect(param1,param2);
         }
      }
      
      public static function heroEffectRemove(param1:Hero, param2:Effect) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroEffectRemove(param1,param2);
         }
      }
      
      public static function absorb(param1:SkillCast, param2:SkillCast, param3:int) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.absorb(param1,param2,param3);
         }
      }
      
      public static function damageEvent(param1:DamageValue) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.damage(param1);
            BattleLog.m.damageEvent(param1);
         }
         var _loc2_:BattleHeroStatistics = param1.currentTarget.state.statistics;
         if(param1.missed)
         {
            _loc2_.damageMissed = _loc2_.damageMissed + param1.resultValue;
         }
         if(param1.dodged)
         {
            _loc2_.damageDodged = _loc2_.damageDodged + param1.resultValue;
         }
      }
      
      public static function damage(param1:DamageValue) : void
      {
         var _loc3_:* = null as BattleHeroStatistics;
         var _loc4_:* = null as Vector.<int>;
         if(BattleLog.doLog)
         {
            BattleLog.m.damage(param1);
         }
         var _loc2_:BattleHeroStatistics = param1.currentTarget.state.statistics;
         if(param1.source.hero == null)
         {
            _loc3_ = null;
         }
         else
         {
            _loc3_ = param1.source.hero.state.statistics;
         }
         if(param1.type == DamageType.PHYSICAL)
         {
            _loc2_.physicalDamageRecieved = _loc2_.physicalDamageRecieved + param1.resultValue;
            _loc2_.physicalDamageResisted = _loc2_.physicalDamageResisted + (param1.sourceValue - param1.resultValue);
            if(_loc3_ != null)
            {
               _loc3_.physicalDamageDealt = _loc3_.physicalDamageDealt + param1.resultValue;
            }
         }
         else if(param1.type == DamageType.MAGIC)
         {
            _loc2_.magicDamageRecieved = _loc2_.magicDamageRecieved + param1.resultValue;
            _loc2_.magicDamageResisted = _loc2_.magicDamageResisted + (param1.sourceValue - param1.resultValue);
            if(_loc3_ != null)
            {
               _loc3_.magicDamageDealt = _loc3_.magicDamageDealt + param1.resultValue;
            }
         }
         _loc2_.damageRecieved = _loc2_.damageRecieved + param1.resultValue;
         if(_loc3_ != null)
         {
            _loc3_.damageDealt = _loc3_.damageDealt + param1.resultValue;
            if(param1.source.skill.tier < int(_loc3_.damageBySkill.length))
            {
               _loc4_ = _loc3_.damageBySkill;
               _loc4_[param1.source.skill.tier] = _loc4_[param1.source.skill.tier] + param1.resultValue;
            }
         }
      }
   }
}
