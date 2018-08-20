package battle.skills
{
   import battle.BattleLog;
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.hooks.GenericHookListener;
   import battle.hooks.GenericHook_Int;
   import battle.hooks.GenericHook_battle_proxy_idents_HeroAnimationIdent;
   import battle.hooks.GenericHook_battle_skills_SkillCast;
   import battle.hooks.HookableNumber;
   import battle.hooks.HookedValue;
   import battle.logic.Disabler;
   import battle.logic.PrimeRange;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.signals.SignalNotifier;
   import battle.timeline.Scheduler;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   import flash.Boot;
   
   public class SkillSet extends Scheduler
   {
       
      
      public var ult:UltSkill;
      
      public var skills:Vector.<Skill>;
      
      public var skillCast:SkillCast;
      
      public var isInCast:Boolean;
      
      public var enemyTeam:Team;
      
      public var currentlyCasting:Boolean;
      
      public var castSpeed:HookableNumber;
      
      public var canCastManual:Disabler;
      
      public var canCast:Disabler;
      
      public var animationEndTime:Number;
      
      public var allyTeam:Team;
      
      public var active:Vector.<Skill>;
      
      public function SkillSet(param1:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         isInCast = false;
         castSpeed = new HookableNumber();
         canCastManual = new Disabler("canCastManual");
         canCast = new Disabler("canCast");
         super(param1);
         skills = new Vector.<Skill>();
         active = new Vector.<Skill>();
         castSpeed.set_value(1);
         currentlyCasting = false;
      }
      
      public function userActionAvailable() : Boolean
      {
         var _loc4_:int = 0;
         if(!canCastManual.enabled)
         {
            return false;
         }
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = skills.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            if(!!skills[_loc4_].desc.manualCastAvailable && skills[_loc4_].canBeCastedManual())
            {
               _loc1_ = true;
               break;
            }
         }
         return _loc1_;
      }
      
      public function unlockHero(param1:SkillCast) : void
      {
         isInCast = false;
         skillCast.hero.canWalk.unblock(this);
      }
      
      public function tweakCooldowns(param1:Number) : void
      {
         var _loc2_:int = active.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            active[_loc2_].nextCastTime = Number(active[_loc2_].nextCastTime + param1);
         }
         if(timeline.time < time)
         {
            timeline.update(this,Number(time + param1));
         }
      }
      
      override public function toString() : String
      {
         return (skills != null && int(skills.length) > 0?skillCast.hero.toString():"unknown") + "`skills";
      }
      
      public function stopCurrentSkillCast() : void
      {
         if(skillCast != null && skillCast.active)
         {
            skillCast.stop();
         }
      }
      
      public function skillCastSetCooldown(param1:SkillCast) : void
      {
         var _loc2_:* = null as Skill;
         var _loc3_:Number = NaN;
         if(Version.current >= 128)
         {
            _loc2_ = param1.unitSkill;
            _loc3_ = _loc2_.desc.cooldown - _loc2_.desc.animationDelay * 0.1;
            if(_loc2_.desc.cooldown > 0 && _loc3_ > param1.hero.engine.config.defaultCastCooldown)
            {
               _loc2_.nextCastTime = Number(timeline.time + _loc3_ / castSpeed.get_value());
               Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc2_.desc.animationDelay * 0.9);
            }
         }
         else
         {
            _loc2_ = param1.unitSkill;
            if(_loc2_.desc.cooldown > 0 && _loc2_.desc.cooldown > param1.hero.engine.config.defaultCastCooldown)
            {
               _loc2_.nextCastTime = Number(timeline.time + _loc2_.desc.cooldown / castSpeed.get_value());
               Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc2_.desc.animationDelay);
            }
         }
      }
      
      public function skillCastHalfAnimation(param1:SkillCast) : void
      {
         var _loc2_:* = null as Hero;
         var _loc3_:int = 0;
         var _loc4_:* = null as GenericHook_Int;
         var _loc5_:int = 0;
         var _loc6_:* = null as HookedValue;
         var _loc7_:* = null as GenericHookListener;
         if(param1.skill.manualCastAvailable)
         {
            _loc2_ = param1.hero;
            if(Version.current >= 131)
            {
               _loc3_ = 1000;
               _loc4_ = _loc2_.hooks.burnUltEnergy;
               _loc5_ = _loc3_;
               if(_loc4_.listeners == null)
               {
                  _loc3_ = _loc5_;
               }
               else
               {
                  if(int(HookedValue.pool.length) > 0)
                  {
                     _loc6_ = HookedValue.pool.pop();
                     _loc6_.value = _loc5_;
                  }
                  else
                  {
                     _loc6_ = new HookedValue(_loc5_);
                  }
                  _loc7_ = _loc4_.listeners;
                  do
                  {
                     _loc7_.callback(_loc6_);
                     _loc7_ = _loc7_.next;
                  }
                  while(_loc7_ != null);
                  
                  _loc5_ = _loc6_.value;
                  _loc6_.value = null;
                  HookedValue.pool.push(_loc6_);
                  _loc3_ = _loc5_;
               }
               _loc2_.decreaseEnergy(_loc3_);
            }
            else
            {
               _loc2_.decreaseEnergy(1000);
            }
            if(Version.current < 131)
            {
               _loc4_ = param1.hero.hooks.burnUltEnergy;
               _loc3_ = 1000;
               if(_loc4_.listeners == null)
               {
                  _loc3_;
               }
               else
               {
                  if(int(HookedValue.pool.length) > 0)
                  {
                     _loc6_ = HookedValue.pool.pop();
                     _loc6_.value = _loc3_;
                  }
                  else
                  {
                     _loc6_ = new HookedValue(_loc3_);
                  }
                  _loc7_ = _loc4_.listeners;
                  do
                  {
                     _loc7_.callback(_loc6_);
                     _loc7_ = _loc7_.next;
                  }
                  while(_loc7_ != null);
                  
                  _loc3_ = _loc6_.value;
                  _loc6_.value = null;
                  HookedValue.pool.push(_loc6_);
                  _loc3_;
               }
            }
         }
         var _loc8_:Skill = param1.unitSkill;
         if(_loc8_.desc.cooldown > 0 && _loc8_.desc.cooldown > param1.hero.engine.config.defaultCastCooldown)
         {
            _loc8_.nextCastTime = timeline.time + _loc8_.desc.cooldown / castSpeed.get_value() - _loc8_.desc.animationDelay * 0.5;
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc8_.desc.animationDelay * 0.5);
         }
      }
      
      public function skillCastBurnEnergy(param1:SkillCast) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as GenericHook_Int;
         var _loc5_:int = 0;
         var _loc6_:* = null as HookedValue;
         var _loc7_:* = null as GenericHookListener;
         var _loc2_:Hero = param1.hero;
         if(Version.current >= 131)
         {
            _loc3_ = 1000;
            _loc4_ = _loc2_.hooks.burnUltEnergy;
            _loc5_ = _loc3_;
            if(_loc4_.listeners == null)
            {
               _loc3_ = _loc5_;
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc6_ = HookedValue.pool.pop();
                  _loc6_.value = _loc5_;
               }
               else
               {
                  _loc6_ = new HookedValue(_loc5_);
               }
               _loc7_ = _loc4_.listeners;
               do
               {
                  _loc7_.callback(_loc6_);
                  _loc7_ = _loc7_.next;
               }
               while(_loc7_ != null);
               
               _loc5_ = _loc6_.value;
               _loc6_.value = null;
               HookedValue.pool.push(_loc6_);
               _loc3_ = _loc5_;
            }
            _loc2_.decreaseEnergy(_loc3_);
         }
         else
         {
            _loc2_.decreaseEnergy(1000);
         }
         if(Version.current < 131)
         {
            _loc4_ = param1.hero.hooks.burnUltEnergy;
            _loc3_ = 1000;
            if(_loc4_.listeners == null)
            {
               _loc3_;
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc6_ = HookedValue.pool.pop();
                  _loc6_.value = _loc3_;
               }
               else
               {
                  _loc6_ = new HookedValue(_loc3_);
               }
               _loc7_ = _loc4_.listeners;
               do
               {
                  _loc7_.callback(_loc6_);
                  _loc7_ = _loc7_.next;
               }
               while(_loc7_ != null);
               
               _loc3_ = _loc6_.value;
               _loc6_.value = null;
               HookedValue.pool.push(_loc6_);
               _loc3_;
            }
         }
      }
      
      public function skillCastApplyBehavior(param1:SkillCast) : void
      {
         if(currentlyCasting)
         {
            throw "SkillSet.applyBehavior double call";
         }
         currentlyCasting = true;
         if(BattleLog.doLog)
         {
            BattleLog.m.heroSkillCast(skillCast.hero,param1);
         }
         param1.skill.applyCast(param1);
         currentlyCasting = false;
         isInCast = false;
         skillCast.hero.canWalk.unblock(this);
         param1.hero.increaseEnergy(param1.hero.engine.config.energyPerAttack);
         if(ult != null)
         {
            ult.checkConditions();
         }
      }
      
      override public function onTime(param1:Timeline) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as Skill;
         var _loc2_:Skill = null;
         var _loc3_:Number = Timeline.INFINITY_TIME;
         if(ult != null && ult.canBeCasted())
         {
            _loc2_ = ult;
         }
         else
         {
            _loc4_ = active.length;
            while(true)
            {
               _loc4_--;
               if(_loc4_ <= 0)
               {
                  break;
               }
               if(active[_loc4_].nextCastTime <= param1.time)
               {
                  _loc5_ = active[_loc4_];
                  if(_loc5_.previousCastTime < _loc3_ && _loc5_.canBeCasted())
                  {
                     _loc2_ = _loc5_;
                     _loc3_ = _loc5_.previousCastTime;
                  }
               }
            }
         }
         if(_loc2_ != null)
         {
            castSkill(_loc2_);
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc2_.desc.animationDelay);
         }
         else
         {
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),0);
         }
      }
      
      public function onCastSpeedChanged(param1:HookableNumber) : void
      {
         var _loc2_:Number = param1.get_value();
         if(_loc2_ == 0 || _loc2_ == Number(Math.POSITIVE_INFINITY))
         {
            return;
         }
         var _loc3_:Number = param1.previousValue;
         var _loc4_:int = active.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            active[_loc4_].nextCastTime = Math.round((timeline.time + (active[_loc4_].nextCastTime - timeline.time) / _loc2_ * _loc3_) * 1000000000000) / 1000000000000;
         }
         var _loc5_:Number = Math.round((timeline.time + (time - timeline.time) / _loc2_ * _loc3_) * 1000000000000) / 1000000000000;
         timeline.update(this,_loc5_);
      }
      
      public function modifySkill(param1:int, param2:BattleSkillDescription) : void
      {
         if(param1 < int(skills.length))
         {
            skills[param1].modify(param2);
         }
      }
      
      public function manualCast() : void
      {
         var _loc4_:int = 0;
         if(!canCastManual.enabled)
         {
            return;
         }
         var _loc1_:Skill = null;
         var _loc2_:int = 0;
         var _loc3_:int = skills.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            if(!!skills[_loc4_].desc.manualCastAvailable && skills[_loc4_].canBeCastedManual())
            {
               _loc1_ = skills[_loc4_];
            }
         }
         if(_loc1_ != null)
         {
            castSkill(_loc1_);
         }
      }
      
      public function init(param1:Hero, param2:Vector.<BattleSkillDescription>) : void
      {
         var _loc8_:int = 0;
         var _loc9_:* = null as Skill;
         skillCast = SkillCast.create(null,param1,timeline);
         enemyTeam = param1.get_enemyTeam();
         allyTeam = param1.team;
         var _loc4_:* = 0.6;
         var _loc5_:Number = int(param1.getTeamPosition()) * 2 + (1 - param1.team.direction) * 0.5;
         var _loc3_:Number = _loc5_ * _loc4_;
         var _loc6_:int = 0;
         var _loc7_:int = param2.length;
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            if(param2[_loc8_].manualCastAvailable)
            {
               _loc9_ = new UltSkill(this,param2[_loc8_]);
               if(_loc9_.desc.cooldown <= 0)
               {
                  ult = _loc9_;
               }
            }
            else
            {
               _loc9_ = new Skill(this,param2[_loc8_]);
            }
            skills.push(_loc9_);
            if(_loc9_.desc.cooldown > 0)
            {
               if(_loc9_.desc.tier != 0)
               {
                  if(_loc9_.desc.cooldownInitial > 0)
                  {
                     _loc9_.nextCastTime = Number(_loc9_.desc.cooldownInitial + _loc3_);
                  }
                  else
                  {
                     _loc9_.nextCastTime = Number(_loc9_.desc.cooldown + _loc3_);
                  }
               }
               else
               {
                  _loc9_.nextCastTime = Number(0.5 + _loc3_);
               }
               active.push(_loc9_);
            }
         }
         castSpeed.onChange.add(onCastSpeedChanged);
         param1.team.onAutoFightEnabled.add(manualCast);
         _loc4_ = Number(findNextSkillTime());
         timeline.update(this,_loc4_);
      }
      
      public function implicitlyCastAnySkill(param1:int) : void
      {
         if(int(skills.length) > param1)
         {
            castSkill(skills[param1]);
         }
      }
      
      public function get_hero() : Hero
      {
         return skillCast.hero;
      }
      
      public function getUlt() : UltSkill
      {
         return ult;
      }
      
      public function getSkillRange(param1:Number) : PrimeRange
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as Skill;
         var _loc2_:int = 0;
         var _loc3_:int = skills.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            _loc5_ = skills[_loc4_];
            if(_loc5_.range != null && Number(_loc5_.range.getRadius()) == param1)
            {
               return _loc5_.range;
            }
         }
         return null;
      }
      
      public function getSkillByTier(param1:int) : Skill
      {
         var _loc2_:int = skills.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(skills[_loc2_].desc.tier == param1)
            {
               return skills[_loc2_];
            }
         }
         return null;
      }
      
      public function getSkillByBehavior(param1:String) : Skill
      {
         var _loc2_:int = skills.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(skills[_loc2_].desc.behavior == param1)
            {
               return skills[_loc2_];
            }
         }
         return null;
      }
      
      public function getInitialCooldownOffset(param1:Hero) : Number
      {
         var _loc2_:* = 0.6;
         var _loc3_:Number = int(param1.getTeamPosition()) * 2 + (1 - param1.team.direction) * 0.5;
         return _loc3_ * _loc2_;
      }
      
      public function getAutoAttack() : Skill
      {
         if(int(skills.length) > 0)
         {
            return skills[0];
         }
         return null;
      }
      
      public function findNextSkillTime() : Number
      {
         var _loc2_:Number = NaN;
         var _loc5_:int = 0;
         var _loc1_:Number = Timeline.INFINITY_TIME;
         var _loc3_:int = 0;
         var _loc4_:int = active.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc2_ = active[_loc5_].nextCastTime;
            if(_loc2_ < _loc1_ && _loc2_ > timeline.time)
            {
               _loc1_ = _loc2_;
            }
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:int = skills.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            skills[_loc1_].dispose();
         }
      }
      
      public function changeTargetTeam(param1:Team) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as PrimeRange;
         if(Version.current > 118)
         {
            skillCast.hero.targetSelector.setTargetTeam(param1);
         }
         else
         {
            _loc2_ = skills.length;
            while(true)
            {
               _loc2_--;
               if(_loc2_ <= 0)
               {
                  break;
               }
               _loc3_ = skills[_loc2_].range;
               if(_loc3_ != null)
               {
                  enemyTeam.removeRange(_loc3_);
                  param1.addRange(_loc3_);
               }
            }
         }
         enemyTeam = param1;
      }
      
      public function castSkill(param1:Skill) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as SkillCast;
         var _loc10_:* = null as GenericHook_battle_skills_SkillCast;
         var _loc11_:* = null as HookedValue;
         var _loc12_:* = null as GenericHookListener;
         var _loc13_:* = null as Hero;
         var _loc14_:* = null as GenericHook_Int;
         var _loc15_:int = 0;
         var _loc16_:* = null as Skill;
         var _loc17_:* = null as GenericHook_battle_proxy_idents_HeroAnimationIdent;
         var _loc18_:* = null as HeroAnimationIdent;
         if(currentlyCasting)
         {
            throw "error in invocation order";
         }
         var _loc2_:Boolean = false;
         skillCast.hero.canWalk.block(this);
         skillCast.hero.adjustToTarget();
         if(!!param1.desc.manualCastAvailable && !param1.canBeCastedManual() || !param1.desc.manualCastAvailable && !param1.canBeCasted())
         {
            if(BattleLog.doLog)
            {
               BattleLog.m.logString("cast interrupted by stoppage");
            }
            skillCast.hero.canWalk.unblock(this);
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),0);
            return;
         }
         isInCast = true;
         var _loc3_:Number = skillCast.hero.engine.config.defaultCastCooldown / castSpeed.get_value();
         if(Version.current == 132)
         {
            if(_loc3_ > param1.desc.animationDelay)
            {
               _loc3_ = param1.desc.animationDelay;
            }
         }
         else if(Version.current >= 133)
         {
            if(_loc3_ < Number(param1.desc.animationDelay + 0.1))
            {
               _loc3_ = param1.desc.animationDelay + 0.1;
            }
         }
         var _loc4_:Number = timeline.time + _loc3_;
         _loc5_ = active.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            if(active[_loc5_].nextCastTime < _loc4_)
            {
               active[_loc5_].nextCastTime = _loc4_;
            }
         }
         if(Version.current < 126)
         {
            if(param1.desc.cooldown > 0 && param1.desc.cooldown / castSpeed.get_value() > _loc3_)
            {
               param1.nextCastTime = Number(timeline.time + param1.desc.cooldown / castSpeed.get_value());
            }
         }
         if(Version.current > 116 && Version.current < 126 && param1.desc.behavior == "TitanEarthMeleeUlt")
         {
            skillCast.hero.skills.canCast.block(this);
         }
         if(Version.current >= 126 && skillCast.onStop != null)
         {
            skillCast.onStop.remove(unlockHero);
         }
         skillCast.interrupt();
         _loc6_ = skillCast;
         var _loc7_:SkillCast = new SkillCast(_loc6_.timeline);
         _loc7_.targets = new Vector.<Hero>();
         _loc7_.hero = _loc6_.hero;
         _loc7_.unitSkill = _loc6_.unitSkill;
         _loc7_.hero.canUseSkills.onDisable.add(_loc7_.interrupt);
         _loc7_.engine = _loc6_.engine;
         skillCast = _loc7_;
         _loc6_ = skillCast;
         if(_loc6_.onStop != null)
         {
            _loc6_.onStop.removeAll();
            skillCast.hero.canUseMagic.onDisable.remove(_loc6_.interrupt);
         }
         _loc6_.skill = param1.desc;
         _loc6_.unitSkill = param1;
         if(param1.isAffectedBySilence())
         {
            skillCast.hero.canUseMagic.onDisable.add(_loc6_.interrupt);
         }
         _loc6_.index = -1;
         _loc6_.targetsCount = 0;
         _loc6_.allyTeam = allyTeam.allyTargetSelector;
         _loc6_.enemyTeam = enemyTeam.targetSelector;
         _loc6_.enemyArea = _loc6_.hero.get_enemyTeam().targetAreaSelector;
         _loc6_.active = true;
         var _loc8_:BattleSkillDescription = param1.desc;
         var _loc9_:Boolean = false;
         if(_loc8_.manualCastAvailable)
         {
            if(_loc8_.startCast != null)
            {
               _loc8_.startCast(skillCast);
            }
            _loc10_ = skillCast.hero.hooks.castSkill;
            _loc6_ = skillCast;
            if(_loc10_.listeners == null)
            {
               _loc6_;
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc11_ = HookedValue.pool.pop();
                  _loc11_.value = _loc6_;
               }
               else
               {
                  _loc11_ = new HookedValue(_loc6_);
               }
               _loc12_ = _loc10_.listeners;
               do
               {
                  _loc12_.callback(_loc11_);
                  _loc12_ = _loc12_.next;
               }
               while(_loc12_ != null);
               
               _loc6_ = _loc11_.value;
               _loc11_.value = null;
               HookedValue.pool.push(_loc11_);
               _loc6_;
            }
            if(_loc8_.applyCast != null && skillCast.active)
            {
               if(skillCast.hero.team.immediateUltimates)
               {
                  if(Version.current < 126)
                  {
                     _loc6_ = skillCast;
                     _loc13_ = _loc6_.hero;
                     if(Version.current >= 131)
                     {
                        _loc5_ = 1000;
                        _loc14_ = _loc13_.hooks.burnUltEnergy;
                        _loc15_ = _loc5_;
                        if(_loc14_.listeners == null)
                        {
                           _loc5_ = _loc15_;
                        }
                        else
                        {
                           if(int(HookedValue.pool.length) > 0)
                           {
                              _loc11_ = HookedValue.pool.pop();
                              _loc11_.value = _loc15_;
                           }
                           else
                           {
                              _loc11_ = new HookedValue(_loc15_);
                           }
                           _loc12_ = _loc14_.listeners;
                           do
                           {
                              _loc12_.callback(_loc11_);
                              _loc12_ = _loc12_.next;
                           }
                           while(_loc12_ != null);
                           
                           _loc15_ = _loc11_.value;
                           _loc11_.value = null;
                           HookedValue.pool.push(_loc11_);
                           _loc5_ = _loc15_;
                        }
                        _loc13_.decreaseEnergy(_loc5_);
                     }
                     else
                     {
                        _loc13_.decreaseEnergy(1000);
                     }
                     if(Version.current < 131)
                     {
                        _loc14_ = _loc6_.hero.hooks.burnUltEnergy;
                        _loc5_ = 1000;
                        if(_loc14_.listeners == null)
                        {
                           _loc5_;
                        }
                        else
                        {
                           if(int(HookedValue.pool.length) > 0)
                           {
                              _loc11_ = HookedValue.pool.pop();
                              _loc11_.value = _loc5_;
                           }
                           else
                           {
                              _loc11_ = new HookedValue(_loc5_);
                           }
                           _loc12_ = _loc14_.listeners;
                           do
                           {
                              _loc12_.callback(_loc11_);
                              _loc12_ = _loc12_.next;
                           }
                           while(_loc12_ != null);
                           
                           _loc5_ = _loc11_.value;
                           _loc11_.value = null;
                           HookedValue.pool.push(_loc11_);
                           _loc5_;
                        }
                     }
                  }
                  else
                  {
                     _loc6_ = skillCast;
                     if(_loc6_.skill.manualCastAvailable)
                     {
                        _loc13_ = _loc6_.hero;
                        if(Version.current >= 131)
                        {
                           _loc5_ = 1000;
                           _loc14_ = _loc13_.hooks.burnUltEnergy;
                           _loc15_ = _loc5_;
                           if(_loc14_.listeners == null)
                           {
                              _loc5_ = _loc15_;
                           }
                           else
                           {
                              if(int(HookedValue.pool.length) > 0)
                              {
                                 _loc11_ = HookedValue.pool.pop();
                                 _loc11_.value = _loc15_;
                              }
                              else
                              {
                                 _loc11_ = new HookedValue(_loc15_);
                              }
                              _loc12_ = _loc14_.listeners;
                              do
                              {
                                 _loc12_.callback(_loc11_);
                                 _loc12_ = _loc12_.next;
                              }
                              while(_loc12_ != null);
                              
                              _loc15_ = _loc11_.value;
                              _loc11_.value = null;
                              HookedValue.pool.push(_loc11_);
                              _loc5_ = _loc15_;
                           }
                           _loc13_.decreaseEnergy(_loc5_);
                        }
                        else
                        {
                           _loc13_.decreaseEnergy(1000);
                        }
                        if(Version.current < 131)
                        {
                           _loc14_ = _loc6_.hero.hooks.burnUltEnergy;
                           _loc5_ = 1000;
                           if(_loc14_.listeners == null)
                           {
                              _loc5_;
                           }
                           else
                           {
                              if(int(HookedValue.pool.length) > 0)
                              {
                                 _loc11_ = HookedValue.pool.pop();
                                 _loc11_.value = _loc5_;
                              }
                              else
                              {
                                 _loc11_ = new HookedValue(_loc5_);
                              }
                              _loc12_ = _loc14_.listeners;
                              do
                              {
                                 _loc12_.callback(_loc11_);
                                 _loc12_ = _loc12_.next;
                              }
                              while(_loc12_ != null);
                              
                              _loc5_ = _loc11_.value;
                              _loc11_.value = null;
                              HookedValue.pool.push(_loc11_);
                              _loc5_;
                           }
                        }
                     }
                     _loc16_ = _loc6_.unitSkill;
                     if(_loc16_.desc.cooldown > 0 && _loc16_.desc.cooldown > _loc6_.hero.engine.config.defaultCastCooldown)
                     {
                        _loc16_.nextCastTime = timeline.time + _loc16_.desc.cooldown / castSpeed.get_value() - _loc16_.desc.animationDelay * 0.5;
                        Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc16_.desc.animationDelay * 0.5);
                     }
                     _loc9_ = true;
                  }
                  _loc6_ = skillCast;
                  _loc6_.add(skillCastApplyBehavior,_loc6_.timeline.time);
                  animationEndTime = Number(timeline.time + 0.2);
                  if(skillCast.hero.engine.doNotInterruptTimeAdvancement)
                  {
                     if(BattleLog.doLog)
                     {
                        BattleLog.m.heroUltImmediate(skillCast.hero);
                     }
                  }
                  else
                  {
                     if(BattleLog.doLog)
                     {
                        BattleLog.m.heroUltImmediateInterrupting(skillCast.hero);
                     }
                     timeline.interruptTimeAdvancement();
                  }
               }
               else
               {
                  canCastManual.block(skillCast);
                  if(Version.current < 126)
                  {
                     _loc6_ = skillCast;
                     _loc6_.add(skillCastBurnEnergy,Number(_loc6_.timeline.time + _loc8_.animationDelay * 0.5));
                  }
                  _loc6_ = skillCast;
                  _loc6_.add(skillCastApplyBehavior,Number(_loc6_.timeline.time + _loc8_.animationDelay));
                  animationEndTime = Number(Number(timeline.time + _loc8_.animationDelay) + 0.2);
                  if(BattleLog.doLog)
                  {
                     BattleLog.m.heroUlt(skillCast.hero);
                  }
               }
               skillCast.addOnStop(unlockHero);
            }
            else
            {
               isInCast = false;
               skillCast.hero.canWalk.unblock(this);
            }
         }
         else
         {
            param1.previousCastTime = timeline.time;
            if(_loc8_.startCast != null)
            {
               _loc8_.startCast(skillCast);
            }
            if(_loc8_.applyCast != null && skillCast.active)
            {
               _loc6_ = skillCast;
               _loc6_.add(skillCastApplyBehavior,Number(_loc6_.timeline.time + _loc8_.animationDelay));
               skillCast.addOnStop(unlockHero);
            }
            else
            {
               isInCast = false;
               skillCast.hero.canWalk.unblock(this);
            }
            animationEndTime = Number(Number(timeline.time + _loc8_.animationDelay) + 0.2);
            _loc10_ = skillCast.hero.hooks.castSkill;
            _loc6_ = skillCast;
            if(_loc10_.listeners == null)
            {
               _loc6_;
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc11_ = HookedValue.pool.pop();
                  _loc11_.value = _loc6_;
               }
               else
               {
                  _loc11_ = new HookedValue(_loc6_);
               }
               _loc12_ = _loc10_.listeners;
               do
               {
                  _loc12_.callback(_loc11_);
                  _loc12_ = _loc12_.next;
               }
               while(_loc12_ != null);
               
               _loc6_ = _loc11_.value;
               _loc11_.value = null;
               HookedValue.pool.push(_loc11_);
               _loc6_;
            }
         }
         if(Version.current >= 126)
         {
            if(!_loc9_)
            {
               if(_loc2_)
               {
                  _loc6_ = skillCast;
                  _loc6_.add(skillCastHalfAnimation,Number(_loc6_.timeline.time + _loc8_.animationDelay * 0.5));
               }
               else
               {
                  if(!!_loc8_.manualCastAvailable && _loc8_.applyCast != null && skillCast.active)
                  {
                     _loc6_ = skillCast;
                     _loc6_.add(skillCastBurnEnergy,Number(_loc6_.timeline.time + _loc8_.animationDelay * 0.5));
                  }
                  if(Version.current >= 128)
                  {
                     _loc6_ = skillCast;
                     _loc6_.add(skillCastSetCooldown,Number(_loc6_.timeline.time + _loc8_.animationDelay * 0.1));
                  }
                  else
                  {
                     _loc6_ = skillCast;
                     _loc6_.add(skillCastSetCooldown,Number(_loc6_.timeline.time + _loc8_.animationDelay * 0));
                  }
               }
            }
         }
         if(skillCast.active)
         {
            if(skillCast.skill.manualCastAvailable)
            {
               skillCast.hero.viewProxy.ultAnimation(skillCast);
            }
            else
            {
               _loc13_ = skillCast.hero;
               _loc17_ = _loc13_.hooks.setAnimation;
               _loc18_ = HeroAnimationIdent.skillByTier[skillCast.skill.tier];
               §§push(_loc13_.viewProxy);
               if(_loc17_.listeners == null)
               {
                  §§push(_loc18_);
               }
               else
               {
                  if(int(HookedValue.pool.length) > 0)
                  {
                     _loc11_ = HookedValue.pool.pop();
                     _loc11_.value = _loc18_;
                  }
                  else
                  {
                     _loc11_ = new HookedValue(_loc18_);
                  }
                  _loc12_ = _loc17_.listeners;
                  do
                  {
                     _loc12_.callback(_loc11_);
                     _loc12_ = _loc12_.next;
                  }
                  while(_loc12_ != null);
                  
                  _loc18_ = _loc11_.value;
                  _loc11_.value = null;
                  HookedValue.pool.push(_loc11_);
                  §§push(_loc18_);
               }
               §§pop().setAnimation(§§pop(),null);
            }
         }
         if(_loc8_.applyCast == null)
         {
            skillCast.hero.increaseEnergy(skillCast.hero.engine.config.energyPerAttack);
         }
         if(Version.current > 116 && Version.current < 126 && param1.desc.behavior == "TitanEarthMeleeUlt")
         {
            skillCast.hero.skills.canCast.unblock(this);
         }
      }
      
      public function castAvailable(param1:Skill) : void
      {
         var _loc5_:* = null as Skill;
         if(!param1.canBeCasted())
         {
            return;
         }
         if(Version.current >= 128 && isInCast)
         {
            return;
         }
         if(currentlyCasting)
         {
            timeline.update(this,Number(timeline.time + 0.3));
            return;
         }
         if(Version.current >= 126)
         {
            timeline.update(this,timeline.time);
            return;
         }
         var _loc2_:Skill = null;
         var _loc3_:Number = Timeline.INFINITY_TIME;
         var _loc4_:int = skills.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            if(skills[_loc4_].nextCastTime <= timeline.time)
            {
               _loc5_ = skills[_loc4_];
               if(_loc5_.previousCastTime < _loc3_ && (_loc5_ == param1 || _loc5_.canBeCasted()))
               {
                  _loc2_ = _loc5_;
                  _loc3_ = _loc5_.previousCastTime;
               }
            }
         }
         if(_loc2_ != null)
         {
            castSkill(_loc2_);
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),_loc2_.desc.animationDelay);
         }
         else if(Version.current < 126)
         {
            Context.engine.cooldownWatcher.update(this,Number(findNextSkillTime()),0);
         }
      }
      
      public function applyInitialBehavior() : void
      {
         var _loc1_:int = skills.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            skills[_loc1_].applyInitialBehavior(timeline);
         }
      }
      
      public function addCommonCooldown(param1:Number) : void
      {
         var _loc2_:int = active.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(active[_loc2_].nextCastTime < param1)
            {
               active[_loc2_].nextCastTime = param1;
            }
         }
      }
   }
}
