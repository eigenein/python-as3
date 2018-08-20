package battle.skills
{
   import battle.BattleCore;
   import battle.data.BattleSkillDescription;
   import battle.logic.PrimeRange;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   import flash.Boot;
   
   public class UltSkill extends Skill
   {
       
      
      public function UltSkill(param1:SkillSet = undefined, param2:BattleSkillDescription = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
         nextCastTime = 0;
         previousCastTime = -7777;
      }
      
      override public function initCastConditions() : void
      {
         var _loc1_:* = null as SkillCondition;
         if(desc.applyCast != null)
         {
            if(desc.initSkillConditions != null)
            {
               desc.initSkillConditions(this,skillSet.skillCast.hero);
            }
            else
            {
               if(isAffectedBySilence())
               {
                  _loc1_ = new SkillCondition(skillSet.skillCast.hero.canUseMagic.isEnabled,"canUseMagic");
                  conditions.push(_loc1_);
                  skillSet.skillCast.hero.canUseMagic.onEnable.add(checkConditions);
               }
               _loc1_ = new SkillCondition(skillSet.skillCast.hero.canUseSkills.isEnabled,"canUseSkills");
               conditions.push(_loc1_);
               skillSet.skillCast.hero.canUseSkills.onEnable.add(checkConditions);
               addCondition(skillSet.skillCast.hero.fullEnergy,skillSet.skillCast.hero.onEnergyFull);
            }
            _loc1_ = new SkillCondition(skillSet.canCastManual.isEnabled,"canCastManual");
            conditions.push(_loc1_);
            skillSet.canCastManual.onEnable.add(checkConditions);
         }
      }
      
      override public function dispose() : void
      {
         conditions = null;
         skillSet.skillCast.hero.canUseSkills.onEnable.remove(checkConditions);
         if(range != null)
         {
            range.dispose();
         }
      }
      
      override public function checkConditions() : void
      {
         var _loc1_:int = 0;
         if(Version.current < 126)
         {
            if(conditions == null)
            {
               return;
            }
            if(!skillSet.skillCast.hero.team.autoFight)
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
      
      override public function canBeCastedManual() : Boolean
      {
         if(conditions == null)
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
      
      override public function canBeCasted() : Boolean
      {
         if(conditions == null)
         {
            return false;
         }
         if(!skillSet.skillCast.hero.team.autoFight || skillSet.isInCast)
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
      
      override public function applyInitialBehavior(param1:Timeline) : void
      {
         if(desc.range > 0 && desc.range < Number(Math.POSITIVE_INFINITY))
         {
            setRange(Number(BattleCore.getSkillRange(desc.range,skillSet.skillCast.hero,skillSet.skillCast.hero.engine.config)),param1);
         }
         if(desc.initCast != null)
         {
            desc.initCast(SkillCast.create(this,skillSet.skillCast.hero,param1));
         }
      }
   }
}
