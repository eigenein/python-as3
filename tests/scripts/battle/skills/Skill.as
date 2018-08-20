package battle.skills
{
   import battle.BattleConfig;
   import battle.BattleCore;
   import battle.BattleEngine;
   import battle.Team;
   import battle.action.Action;
   import battle.data.BattleSkillDescription;
   import battle.data.DamageType;
   import battle.logic.PrimeRange;
   import battle.signals.SignalNotifier;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   import flash.Boot;
   
   public class Skill
   {
      
      public static var skillNumCounter:int = 0;
       
      
      public var skillSet:SkillSet;
      
      public var skillNum:int;
      
      public var range:PrimeRange;
      
      public var previousCastTime:Number;
      
      public var onMovementNotNeeded:SignalNotifier;
      
      public var onMovementNeeded:SignalNotifier;
      
      public var nextCastTime:Number;
      
      public var movementNeeded:Boolean;
      
      public var isActive:Boolean;
      
      public var desc:BattleSkillDescription;
      
      public var conditions:Vector.<SkillCondition>;
      
      public function Skill(param1:SkillSet = undefined, param2:BattleSkillDescription = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         var _loc3_:int = Skill.skillNumCounter;
         Skill.skillNumCounter = Skill.skillNumCounter + 1;
         skillNum = _loc3_;
         skillSet = param1;
         desc = param2;
         nextCastTime = Timeline.INFINITY_TIME;
         previousCastTime = 0;
         conditions = new Vector.<SkillCondition>();
         if(param1 != null)
         {
            initCastConditions();
         }
      }
      
      public static function environmentSkill(param1:BattleEngine) : Skill
      {
         return new Skill(null,null);
      }
      
      public function toString() : String
      {
         var _loc1_:int = 0;
         if(desc != null)
         {
            _loc1_ = desc.tier;
         }
         else
         {
            _loc1_ = 0;
         }
         return "`" + Std.string(skillSet.skillCast.hero) + " skill " + _loc1_ + "`";
      }
      
      public function setRange(param1:Number, param2:Timeline) : void
      {
         var _loc3_:* = null as BattleConfig;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as Team;
         var _loc6_:* = null as PrimeRange;
         var _loc7_:* = null as SkillCondition;
         var _loc8_:int = 0;
         var _loc9_:* = null as Vector.<SkillCondition>;
         var _loc10_:* = 0;
         if(param1 == param1)
         {
            _loc3_ = skillSet.skillCast.hero.engine.config;
            if(desc.modifyRangeByTeamPosition)
            {
               _loc4_ = int(skillSet.skillCast.hero.getTeamPosition()) * _loc3_.inTeamHeroInterval;
               param1 = param1 * 0.75 + _loc4_ * 0.25;
            }
            if(range == null)
            {
               if(Version.current > 111)
               {
                  range = skillSet.getSkillRange(param1);
               }
               if(range == null)
               {
                  _loc5_ = skillSet.skillCast.hero.get_enemyTeam();
                  _loc6_ = new PrimeRange(param2,skillSet.skillCast.hero.body,param1);
                  if(Version.current < 119)
                  {
                     _loc5_.addRange(_loc6_);
                  }
                  range = _loc6_;
                  if(Version.current > 118)
                  {
                     skillSet.skillCast.hero.targetSelector.addRange(range);
                  }
               }
               _loc7_ = new SkillCondition(range.isOccupied,"rangeOccupied");
               conditions.push(_loc7_);
               range.onOccupied.add(checkConditions);
            }
            else if(Number(range.getRadius()) != param1)
            {
               range.setRadius(param1);
            }
         }
         else if(range != null)
         {
            range.dispose();
            _loc8_ = conditions.length;
            while(true)
            {
               _loc8_--;
               if(_loc8_ > 0)
               {
                  if(conditions[_loc8_]._method == range.isOccupied)
                  {
                     _loc9_ = conditions;
                     _loc10_ = int(_loc9_.length) - 1;
                     if(_loc10_ >= 0)
                     {
                        _loc9_[_loc8_] = _loc9_[_loc10_];
                        _loc9_.length = _loc10_;
                     }
                     break;
                  }
                  continue;
               }
               break;
            }
         }
      }
      
      public function modify(param1:BattleSkillDescription) : void
      {
         if(desc.modify != null)
         {
            desc.modify(param1);
         }
      }
      
      public function isAffectedBySilence() : Boolean
      {
         return desc.prime == null || desc.prime.type != DamageType.PHYSICAL || desc.prime.getBase() == "MP";
      }
      
      public function initCastConditions() : void
      {
         var _loc1_:* = null as SkillCondition;
         if(desc.applyCast != null)
         {
            _loc1_ = new SkillCondition(skillSet.canCast.isEnabled,"canDoActions");
            conditions.push(_loc1_);
            skillSet.canCast.onEnable.add(checkConditions);
            if(desc.initSkillConditions != null)
            {
               desc.initSkillConditions(this,skillSet.skillCast.hero);
            }
            else
            {
               _loc1_ = new SkillCondition(skillSet.skillCast.hero.canUseSkills.isEnabled,"canUseSkills");
               conditions.push(_loc1_);
               skillSet.skillCast.hero.canUseSkills.onEnable.add(checkConditions);
               if(isAffectedBySilence())
               {
                  _loc1_ = new SkillCondition(skillSet.skillCast.hero.canUseMagic.isEnabled,"canUseMagic");
                  conditions.push(_loc1_);
                  skillSet.skillCast.hero.canUseMagic.onEnable.add(checkConditions);
               }
            }
         }
      }
      
      public function get_onMovementNotNeeded() : SignalNotifier
      {
         if(range != null)
         {
            return range.onOccupied;
         }
         return null;
      }
      
      public function get_onMovementNeeded() : SignalNotifier
      {
         if(range != null)
         {
            return range.onEmpty;
         }
         return null;
      }
      
      public function get_movementNeeded() : Boolean
      {
         if(range != null)
         {
            return !range.isOccupied();
         }
         return false;
      }
      
      public function get_isActive() : Boolean
      {
         return Boolean(desc.applyCast);
      }
      
      public function dispose() : void
      {
         conditions = null;
         skillSet.canCast.onEnable.remove(checkConditions);
         skillSet.skillCast.hero.onEnergyFull.remove(checkConditions);
         skillSet.skillCast.hero.canUseSkills.onEnable.remove(checkConditions);
         if(range != null)
         {
            range.dispose();
         }
      }
      
      public function conditionsString() : String
      {
         var _loc1_:String = "";
         if(conditions == null)
         {
            return "none";
         }
         var _loc2_:int = conditions.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc1_ = _loc1_ + (conditions[_loc2_]._name + (!!conditions[_loc2_]._method()?"+":"-") + " ");
         }
         return _loc1_;
      }
      
      public function checkConditions() : void
      {
         var _loc1_:int = 0;
         if(Version.current < 126)
         {
            if(conditions == null)
            {
               return;
            }
            _loc1_ = conditions.length;
            while(true)
            {
               _loc1_--;
               if(_loc1_ <= 0)
               {
                  break;
               }
               if(!conditions[_loc1_]._method())
               {
                  return;
               }
            }
         }
         skillSet.castAvailable(this);
      }
      
      public function canBeCastedManual() : Boolean
      {
         return false;
      }
      
      public function canBeCasted() : Boolean
      {
         if(conditions == null)
         {
            return false;
         }
         if(skillSet.isInCast)
         {
            return false;
         }
         var _loc1_:int = conditions.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            if(!conditions[_loc1_]._method())
            {
               return false;
            }
         }
         return true;
      }
      
      public function applyInitialBehavior(param1:Timeline) : void
      {
         var _loc4_:* = null as SkillCast;
         var _loc2_:Boolean = desc.range > 0 && desc.range < Number(Math.POSITIVE_INFINITY);
         var _loc3_:Number = BattleCore.getSkillRange(desc.range,skillSet.skillCast.hero,skillSet.skillCast.hero.engine.config);
         if(desc.range < 0 && _loc3_ > 0)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            setRange(_loc3_,param1);
         }
         if(desc.initCast != null)
         {
            _loc4_ = SkillCast.create(this,skillSet.skillCast.hero,param1);
            desc.initCast(_loc4_);
         }
      }
      
      public function addCondition(param1:Function, param2:SignalNotifier, param3:String = undefined) : void
      {
         if(param3 == null)
         {
            param3 = "fullEnergy";
         }
         conditions.push(new SkillCondition(param1,param3));
         param2.add(checkConditions);
      }
      
      public function addBasicCondition(param1:SkillCondition, param2:SignalNotifier) : void
      {
         conditions.push(param1);
         param2.add(checkConditions);
      }
   }
}
