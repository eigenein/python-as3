package battle
{
   import battle.data.BattleHeroDescription;
   import battle.data.DamageType;
   import battle.data.HeroState;
   import battle.data.MainStat;
   import battle.data.ProjectileParam;
   import battle.hooks.GenericHookListener;
   import battle.hooks.GenericHook_Bool;
   import battle.hooks.GenericHook_Float;
   import battle.hooks.GenericHook_Int;
   import battle.hooks.GenericHook_battle_proxy_idents_HeroAnimationIdent;
   import battle.hooks.HeroHooks;
   import battle.hooks.HookableNumber;
   import battle.hooks.HookedValue;
   import battle.logic.Disabler;
   import battle.logic.MovingBody;
   import battle.logic.RangeBase;
   import battle.objects.EffectHolder;
   import battle.proxy.CustomManualAction;
   import battle.proxy.HeroViewAnchors;
   import battle.proxy.IHeroProxy;
   import battle.proxy.InputActionHolder;
   import battle.proxy.ViewPosition;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import battle.proxy.empty.EmptyHeroProxy;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.signals.SignalNotifier;
   import battle.skills.Context;
   import battle.skills.Effect;
   import battle.skills.EffectFactory;
   import battle.skills.EffectHooks;
   import battle.skills.Skill;
   import battle.skills.SkillCast;
   import battle.skills.SkillSet;
   import battle.skills.TargetSelectResolver;
   import battle.skills.UltSkill;
   import battle.stats.ElementStats;
   import battle.timeline.Scheduler;
   import battle.utils.Util;
   import battle.utils.Version;
   import flash.Boot;
   
   public class Hero extends EffectHolder
   {
      
      public static var TITAN_ID_136:Array = [4000,4001,4002,4003,4010,4011,4012,4013,4020,4021,4022,4023];
      
      public static var TITAN_ID_WATER:Array = [4000,4001,4002,4003];
      
      public static var TITAN_ID_FIRE:Array = [4010,4011,4012,4013];
      
      public static var TITAN_ID_EARTH:Array = [4020,4021,4022,4023];
       
      
      public var viewProxy:IHeroProxy;
      
      public var team:Team;
      
      public var targetSelector:TargetSelectResolver;
      
      public var speed:HookableNumber;
      
      public var skills:SkillSet;
      
      public var showShadow:Disabler;
      
      public var showEffects:Disabler;
      
      public var needGuiPanel:Boolean;
      
      public var hooks:HeroHooks;
      
      public var energyPerKill:Number;
      
      public var desc:BattleHeroDescription;
      
      public var canWalk:Disabler;
      
      public var canUseSkills:Disabler;
      
      public var canUseMagic:Disabler;
      
      public var canMove:Disabler;
      
      public var canDodge:Disabler;
      
      public var canBeTargetedByAliases:Disabler;
      
      public var canBeTargeted:Disabler;
      
      public var actions:InputActionHolder;
      
      public var _enemyTeam:Team;
      
      public function Hero(param1:Team = undefined, param2:BattleEngine = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         needGuiPanel = true;
         viewProxy = EmptyHeroProxy.instance;
         hooks = new HeroHooks();
         speed = new HookableNumber();
         canBeTargetedByAliases = new Disabler("canBeTargetedByAliases");
         canBeTargeted = new Disabler("canBeTargeted");
         canDodge = new Disabler("canDodge");
         canUseMagic = new Disabler("canUseMagic");
         canUseSkills = new Disabler("canUseSkills");
         canMove = new Disabler("canMove");
         canWalk = new Disabler("canWalk");
         showShadow = new Disabler("showShadow");
         showEffects = new Disabler("showEffects");
         super(param2,param2.config.heroSize);
         isHero = true;
         if(Version.current > 118)
         {
            targetSelector = new TargetSelectResolver(this);
         }
         energyPerKill = param2.config.energyPerKill;
         team = param1;
         lastDirection = param1.direction;
         if(param1 != null)
         {
            _enemyTeam = param1.enemyTeam;
            if(Version.current > 118)
            {
               targetSelector.setTargetTeam(_enemyTeam);
            }
         }
         canBeTargeted.onEnable.add(onCanBeTargetedEnabled);
         canBeTargeted.onDisable.add(onCanBeTargetedDisabled);
         canUseSkills.onDisable.add(onCanUseSkillsDisabled);
      }
      
      public function userActionAvailable() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(state.isDead)
         {
            return false;
         }
         var _loc1_:SkillSet = skills;
         if(!_loc1_.canCastManual.enabled)
         {
            return false;
         }
         _loc2_ = false;
         _loc3_ = 0;
         _loc4_ = _loc1_.skills.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(!!_loc1_.skills[_loc5_].desc.manualCastAvailable && _loc1_.skills[_loc5_].canBeCastedManual())
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      override public function updateStats() : void
      {
         stats.copyFromHeroStats(desc.stats);
         EffectHooks.hook_updateHeroStats(effects,stats);
         EffectHooks.hook_updateTeamStats(this,team.effects,stats);
         var _loc1_:HeroStats = stats;
         var _loc2_:MainStat = _loc1_.mainStat;
         _loc1_.physicalAttack = Number(_loc1_.physicalAttack + (Number((_loc2_ == MainStat.intelligence?_loc1_.intelligence:_loc2_ == MainStat.agility?_loc1_.agility:_loc1_.strength) + _loc1_.agility * 2)));
         _loc1_.hp = int(Number(_loc1_.hp + 40 * _loc1_.strength));
         _loc1_.armor = Number(_loc1_.armor + _loc1_.agility);
         _loc1_.magicPower = Number(_loc1_.magicPower + _loc1_.intelligence * 3);
         _loc1_.magicResist = Number(_loc1_.magicResist + _loc1_.intelligence);
         _loc2_ = _loc1_.mainStat;
         if(_loc2_ == MainStat.intelligence)
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.intelligence);
         }
         else if(_loc2_ == MainStat.agility)
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.agility);
         }
         else
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.strength);
         }
         _loc2_ = _loc1_.mainStat;
         if(_loc2_ == MainStat.intelligence)
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.intelligence);
         }
         else if(_loc2_ == MainStat.agility)
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.agility);
         }
         else
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.strength);
         }
         EffectHooks.hook_updateHeroProcessedStats(effects,stats);
         EffectHooks.hook_updateTeamProcessedStats(this,team.effects,stats);
         _loc1_ = stats;
         if(_loc1_.magicPower < 0)
         {
            _loc1_.magicPower = 0;
         }
         if(_loc1_.physicalAttack < 0)
         {
            _loc1_.physicalAttack = 0;
         }
         if(_loc1_.hp < 0)
         {
            _loc1_.hp = 0;
         }
         if(_loc1_.lifesteal < 0)
         {
            _loc1_.lifesteal = 0;
         }
         stats.round();
         statsInvalidated = false;
      }
      
      public function updateCurrentDirection() : void
      {
         var _loc1_:* = null as Hero;
         if(skills == null || skills.enemyTeam == null)
         {
            if(body.vx > 0)
            {
               lastDirection = 1;
            }
            else if(body.vx < 0)
            {
               lastDirection = -1;
            }
         }
         else
         {
            _loc1_ = skills.enemyTeam.targetSelector.getNearest(this);
            if(_loc1_ != null)
            {
               if(_loc1_.body.x > body.x)
               {
                  lastDirection = 1;
               }
               else
               {
                  lastDirection = -1;
               }
            }
         }
      }
      
      public function typeDamage(param1:Number, param2:SkillCast, param3:DamageType, param4:Boolean = false) : int
      {
         var _loc9_:* = null as Hero;
         if(param2.hero == this)
         {
            BattleEngine.trace("Hero " + param2.hero.desc.name + " tries to damage himself with " + param2.skill.behavior);
            return 0;
         }
         var _loc6_:DamageValue = new DamageValue();
         var _loc7_:int = param1;
         _loc6_.sourceValue = _loc7_;
         _loc6_.resultValue = _loc7_;
         _loc6_.source = param2;
         _loc6_.type = param3;
         var _loc8_:Boolean = false;
         _loc6_.blocked = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.immune = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.crited = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.dodged = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.missed = _loc8_;
         _loc6_.applied = _loc8_;
         _loc6_.hitLevel = 0;
         _loc6_.element = null;
         _loc6_.redirected = param4;
         _loc7_ = -1;
         _loc6_.dodgeRoll = _loc7_;
         _loc6_.critRoll = _loc7_;
         _loc6_.currentTarget = this;
         var _loc5_:DamageValue = _loc6_;
         EffectHooks.hook_applyDamage(this,_loc5_);
         engine.damage.dealDamage(_loc5_);
         if(!!_loc5_.applied && _loc5_.resultValue > int(_loc5_.currentTarget.getMaxHp()) * engine.config.stunRate)
         {
            _loc9_ = _loc5_.currentTarget;
            _loc9_.applyEffect(EffectFactory.ministunEffect(_loc5_,_loc9_.timeline),1,-1,EffectAnimationIdent.COMMON);
         }
         _loc5_.currentTarget.viewProxy.onTakeDamage(_loc5_);
         return _loc5_.resultValue;
      }
      
      override public function toString() : String
      {
         return (team == null?"null":team.direction > 0?"+":"-") + (desc == null?null:desc.id);
      }
      
      public function subscribe(param1:BattleEngine) : void
      {
         var _loc2_:* = null as HeroState;
         updateStats();
         if(state == null)
         {
            _loc2_ = desc.getInitialState(param1.config);
            desc.state = _loc2_;
            state = _loc2_;
         }
         param1.addStartListener(onStartListener);
         speed.onChange.add(onSpeedChanged);
         onHpZero.add(onHPZeroListener);
         canWalk.onEnable.add(adjustToTarget);
         canMove.onEnable.add(adjustToTarget);
         canMove.onDisable.add(updateCurrentDirection);
      }
      
      override public function stopMovement() : void
      {
         if(!!canMove.enabled && canWalk.enabled)
         {
            super.setVelocity(0);
         }
      }
      
      public function silentDamage(param1:Number, param2:SkillCast) : int
      {
         var _loc8_:* = null as Hero;
         var _loc4_:Boolean = false;
         var _loc5_:DamageValue = new DamageValue();
         var _loc6_:int = param1;
         _loc5_.sourceValue = _loc6_;
         _loc5_.resultValue = _loc6_;
         _loc5_.source = param2;
         _loc5_.type = DamageType.SILENT;
         var _loc7_:Boolean = false;
         _loc5_.blocked = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.immune = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.crited = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.dodged = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.missed = _loc7_;
         _loc5_.applied = _loc7_;
         _loc5_.hitLevel = 0;
         _loc5_.element = null;
         _loc5_.redirected = _loc4_;
         _loc6_ = -1;
         _loc5_.dodgeRoll = _loc6_;
         _loc5_.critRoll = _loc6_;
         _loc5_.currentTarget = this;
         var _loc3_:DamageValue = _loc5_;
         EffectHooks.hook_applyDamage(this,_loc3_);
         engine.damage.dealDamage(_loc3_);
         if(!!_loc3_.applied && _loc3_.resultValue > int(_loc3_.currentTarget.getMaxHp()) * engine.config.stunRate)
         {
            _loc8_ = _loc3_.currentTarget;
            _loc8_.applyEffect(EffectFactory.ministunEffect(_loc3_,_loc8_.timeline),1,-1,EffectAnimationIdent.COMMON);
         }
         _loc3_.currentTarget.viewProxy.onTakeDamage(_loc3_);
         return _loc3_.resultValue;
      }
      
      public function setProxy(param1:IHeroProxy) : void
      {
         if(param1 != null)
         {
            viewProxy = param1;
         }
      }
      
      public function setEnemyTeam(param1:Team) : void
      {
         _enemyTeam = param1;
         if(Version.current > 118)
         {
            targetSelector.setTargetTeam(param1);
         }
         else
         {
            adjustToTarget();
         }
      }
      
      public function setCurrentDirection(param1:int) : void
      {
         lastDirection = param1;
      }
      
      public function setAnimation(param1:HeroAnimationIdent) : void
      {
         var _loc4_:* = null as HookedValue;
         var _loc5_:* = null as GenericHookListener;
         var _loc2_:GenericHook_battle_proxy_idents_HeroAnimationIdent = hooks.setAnimation;
         var _loc3_:HeroAnimationIdent = param1;
         §§push(viewProxy);
         if(_loc2_.listeners == null)
         {
            §§push(_loc3_);
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc4_ = HookedValue.pool.pop();
               _loc4_.value = _loc3_;
            }
            else
            {
               _loc4_ = new HookedValue(_loc3_);
            }
            _loc5_ = _loc2_.listeners;
            do
            {
               _loc5_.callback(_loc4_);
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != null);
            
            _loc3_ = _loc4_.value;
            _loc4_.value = null;
            HookedValue.pool.push(_loc4_);
            §§push(_loc3_);
         }
         §§pop().setAnimation(§§pop(),null);
      }
      
      override public function rollHitrate(param1:int) : Boolean
      {
         var _loc2_:* = false;
         var _loc4_:int = 0;
         var _loc3_:int = desc.level;
         if(param1 < 0 || param1 >= _loc3_)
         {
            _loc2_ = true;
         }
         else if(param1 > 0)
         {
            _loc4_ = Context.engine.randomSource(1,4 + _loc3_ - param1);
            _loc2_ = _loc4_ < 4;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function remove() : void
      {
         canBeTargeted.block(this);
         onRemove.fire();
         dispose();
         setVelocity(0);
      }
      
      public function onStartListener(param1:Scheduler) : void
      {
         var _loc2_:Skill = skills.getAutoAttack();
         if(_loc2_ != null)
         {
            if(_loc2_.get_onMovementNeeded() != null)
            {
               _loc2_.get_onMovementNeeded().add(adjustToTarget);
            }
            if(_loc2_.get_onMovementNotNeeded() != null)
            {
               _loc2_.get_onMovementNotNeeded().add(stopMovement);
            }
         }
         var _loc3_:Objects = engine.objects;
         _loc3_.heroesByBody[body] = this;
         _loc3_.movement.add(body);
         adjustToTarget();
      }
      
      public function onSpeedChanged(param1:HookableNumber) : void
      {
         adjustToTarget();
      }
      
      public function onHPZeroListener() : void
      {
         var _loc4_:* = null as HookedValue;
         var _loc5_:* = null as GenericHookListener;
         var _loc1_:HeroState = state;
         if((_loc1_.hp ^ 1694084416) != _loc1_.hpLastHashed)
         {
            Context.engine.data.b = 1;
         }
         _loc1_.hpLastHashed = 1694084416;
         _loc1_.hp = 0;
         var _loc2_:GenericHook_Bool = hooks.die;
         var _loc3_:Boolean = true;
         if(_loc2_.listeners == null)
         {
            §§push(_loc3_);
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc4_ = HookedValue.pool.pop();
               _loc4_.value = _loc3_;
            }
            else
            {
               _loc4_ = new HookedValue(_loc3_);
            }
            _loc5_ = _loc2_.listeners;
            do
            {
               _loc5_.callback(_loc4_);
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != null);
            
            _loc3_ = _loc4_.value;
            _loc4_.value = null;
            HookedValue.pool.push(_loc4_);
            §§push(_loc3_);
         }
         if(§§pop())
         {
            claimDead();
            disable();
            animateDeath();
            remove();
         }
      }
      
      public function onCanUseSkillsDisabled() : void
      {
         var _loc1_:* = null as GenericHook_battle_proxy_idents_HeroAnimationIdent;
         var _loc2_:* = null as HeroAnimationIdent;
         var _loc3_:* = null as HookedValue;
         var _loc4_:* = null as GenericHookListener;
         if(!state.isDead)
         {
            _loc1_ = hooks.setAnimation;
            _loc2_ = HeroAnimationIdent.HURT;
            §§push(viewProxy);
            if(_loc1_.listeners == null)
            {
               §§push(_loc2_);
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc3_ = HookedValue.pool.pop();
                  _loc3_.value = _loc2_;
               }
               else
               {
                  _loc3_ = new HookedValue(_loc2_);
               }
               _loc4_ = _loc1_.listeners;
               do
               {
                  _loc4_.callback(_loc3_);
                  _loc4_ = _loc4_.next;
               }
               while(_loc4_ != null);
               
               _loc2_ = _loc3_.value;
               _loc3_.value = null;
               HookedValue.pool.push(_loc3_);
               §§push(_loc2_);
            }
            §§pop().setAnimation(§§pop(),null);
         }
      }
      
      public function onCanBeTargetedEnabled() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as RangeBase;
         var _loc5_:* = null as Vector.<TargetSelectResolver>;
         var _loc6_:* = null as TargetSelectResolver;
         var _loc1_:Team = team;
         var _loc2_:Vector.<RangeBase> = _loc1_.ranges;
         _loc3_ = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc4_.addObject(body);
         }
         if(Version.current > 118)
         {
            _loc5_ = _loc1_.targetSelectors;
            _loc3_ = _loc5_.length;
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc5_[_loc3_];
               _loc6_.heroIsAvailable(this);
            }
         }
      }
      
      public function onCanBeTargetedDisabled() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as RangeBase;
         var _loc5_:* = null as Vector.<TargetSelectResolver>;
         var _loc6_:* = null as TargetSelectResolver;
         var _loc1_:Team = team;
         var _loc2_:Vector.<RangeBase> = _loc1_.ranges;
         _loc3_ = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc4_.removeObject(body);
         }
         if(Version.current > 118)
         {
            _loc5_ = _loc1_.targetSelectors;
            _loc3_ = _loc5_.length;
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc5_[_loc3_];
               _loc6_.heroIsNotAvailable(this);
            }
         }
      }
      
      override public function modifyHp(param1:Number) : int
      {
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null as HookedValue;
         var _loc6_:* = null as GenericHookListener;
         var _loc7_:* = null as HeroState;
         var _loc8_:* = 0;
         var _loc9_:Number = NaN;
         if(BattleLog.doLog)
         {
            BattleLog.m.heroHp(this,state.hp,param1);
         }
         if(param1 > 0)
         {
            state.statistics.healingReceived = Number(state.statistics.healingReceived + param1);
         }
         var _loc3_:GenericHook_Int = hooks.modifyHp;
         _loc4_ = int(param1);
         if(_loc3_.listeners == null)
         {
            _loc2_ = int(_loc4_);
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc5_ = HookedValue.pool.pop();
               _loc5_.value = _loc4_;
            }
            else
            {
               _loc5_ = new HookedValue(_loc4_);
            }
            _loc6_ = _loc3_.listeners;
            do
            {
               _loc6_.callback(_loc5_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != null);
            
            _loc4_ = int(_loc5_.value);
            _loc5_.value = null;
            HookedValue.pool.push(_loc5_);
            _loc2_ = int(_loc4_);
         }
         if(get_isDead())
         {
            return 0;
         }
         if(_loc2_ > 0)
         {
            _loc4_ = int(getMaxHp());
            if(state.hp >= _loc4_)
            {
               return 0;
            }
            _loc7_ = state;
            _loc8_ = _loc7_.hp + _loc2_;
            if((_loc7_.hp ^ 1694084416) != _loc7_.hpLastHashed)
            {
               Context.engine.data.b = 1;
            }
            _loc7_.hpLastHashed = _loc8_ ^ 1694084416;
            _loc7_.hp = _loc8_;
            if(state.hp >= _loc4_)
            {
               _loc2_ = _loc2_ - (state.hp - _loc4_);
               _loc7_ = state;
               if((_loc7_.hp ^ 1694084416) != _loc7_.hpLastHashed)
               {
                  Context.engine.data.b = 1;
               }
               _loc7_.hpLastHashed = _loc4_ ^ 1694084416;
               _loc7_.hp = _loc4_;
            }
            viewProxy.onTakeHeal(_loc2_);
            viewProxy.onHpModify(_loc2_);
         }
         else
         {
            if(state.hp <= 0)
            {
               return 0;
            }
            _loc7_ = state;
            _loc4_ = _loc7_.hp + _loc2_;
            if((_loc7_.hp ^ 1694084416) != _loc7_.hpLastHashed)
            {
               Context.engine.data.b = 1;
            }
            _loc7_.hpLastHashed = _loc4_ ^ 1694084416;
            _loc7_.hp = _loc4_;
            if(state.hp <= 0)
            {
               _loc2_ = _loc2_ - state.hp;
               _loc7_ = state;
               if((_loc7_.hp ^ 1694084416) != _loc7_.hpLastHashed)
               {
                  Context.engine.data.b = 1;
               }
               _loc7_.hpLastHashed = 1694084416;
               _loc7_.hp = 0;
            }
            _loc9_ = -engine.config.energyHurtMultiplyer * 1000 * _loc2_ / int(getMaxHp());
            _loc4_ = int(_loc9_);
            increaseEnergy(_loc4_);
            viewProxy.onHpModify(_loc2_);
            if(state.hp == 0)
            {
               onHpZero.fire();
            }
         }
         return _loc2_;
      }
      
      public function ministun(param1:DamageValue) : void
      {
         applyEffect(EffectFactory.ministunEffect(param1,timeline),1,-1,EffectAnimationIdent.COMMON);
      }
      
      public function loadData(param1:BattleHeroDescription) : Hero
      {
         desc = param1;
         var _loc2_:* = int(Hero.TITAN_ID_136.indexOf(param1.heroId)) != -1;
         if(Version.current < 136)
         {
            param1.scale = 1;
         }
         else if(param1.scale == 0)
         {
            if(_loc2_)
            {
               param1.scale = 0.8;
            }
            else
            {
               param1.scale = 1;
            }
         }
         if(!!_loc2_ && param1.element == null)
         {
            param1.element = new ElementStats();
            if(int(Hero.TITAN_ID_WATER.indexOf(param1.heroId)) != -1)
            {
               param1.element.element = "water";
            }
            else if(int(Hero.TITAN_ID_FIRE.indexOf(param1.heroId)) != -1)
            {
               param1.element.element = "fire";
            }
            else if(int(Hero.TITAN_ID_EARTH.indexOf(param1.heroId)) != -1)
            {
               param1.element.element = "earth";
            }
         }
         state = param1.state;
         speed.set_value(engine.config.defaultHeroSpeed);
         team.addHero(this);
         skills = new SkillSet(timeline);
         skills.init(this,param1.skills);
         subscribe(engine);
         return this;
      }
      
      public function increaseEnergyWithText(param1:Number) : void
      {
         var _loc2_:Number = state.energy;
         increaseEnergy(param1);
         if(state.energy != _loc2_)
         {
            viewProxy.energyGenerated(int(state.energy - _loc2_));
         }
      }
      
      public function increaseEnergy(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null as HookedValue;
         var _loc6_:* = null as GenericHookListener;
         var _loc3_:GenericHook_Int = hooks.increaseEnergy;
         var _loc4_:int = param1;
         if(_loc3_.listeners == null)
         {
            _loc2_ = _loc4_;
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc5_ = HookedValue.pool.pop();
               _loc5_.value = _loc4_;
            }
            else
            {
               _loc5_ = new HookedValue(_loc4_);
            }
            _loc6_ = _loc3_.listeners;
            do
            {
               _loc6_.callback(_loc5_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != null);
            
            _loc4_ = _loc5_.value;
            _loc5_.value = null;
            HookedValue.pool.push(_loc5_);
            _loc2_ = _loc4_;
         }
         if(BattleLog.doLog)
         {
            BattleLog.m.heroEnergy(this,state.energy,_loc2_);
         }
         if(_loc2_ > 0)
         {
            if(_loc2_ > 1000 - state.energy)
            {
               state.statistics.energyGained = Number(state.statistics.energyGained + (1000 - state.energy));
            }
            else
            {
               state.statistics.energyGained = Number(state.statistics.energyGained + _loc2_);
            }
         }
         if(_loc2_ < 0)
         {
            state.statistics.energySpent = state.statistics.energySpent - _loc2_;
         }
         if(_loc2_ <= 0 || state.energy >= 1000)
         {
            return;
         }
         var _loc7_:Number = 1000 - state.energy;
         var _loc8_:Boolean = false;
         if(_loc2_ > _loc7_)
         {
            _loc2_ = _loc7_;
            _loc8_ = true;
         }
         _loc3_ = hooks.energyChanged;
         _loc4_ = _loc2_;
         if(_loc3_.listeners == null)
         {
            _loc2_ = _loc4_;
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc5_ = HookedValue.pool.pop();
               _loc5_.value = _loc4_;
            }
            else
            {
               _loc5_ = new HookedValue(_loc4_);
            }
            _loc6_ = _loc3_.listeners;
            do
            {
               _loc6_.callback(_loc5_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != null);
            
            _loc4_ = _loc5_.value;
            _loc5_.value = null;
            HookedValue.pool.push(_loc5_);
            _loc2_ = _loc4_;
         }
         state.energy = Number(state.energy + _loc2_);
         viewProxy.onEnergyModify(_loc2_);
         if(_loc8_)
         {
            onEnergyFull.fire();
         }
      }
      
      override public function heal(param1:Number, param2:SkillCast) : void
      {
         var _loc3_:* = null as HookedValue;
         if(Version.current >= 140)
         {
            _loc3_ = HookedValue.getValue(int(Util.skillInt(param1)));
            EffectHooks.hook_applyHeal(this,param2,_loc3_);
            param1 = int(HookedValue.dispose(_loc3_));
         }
      }
      
      public function get_name() : String
      {
         return "cat";
      }
      
      override public function get_isAvailable() : Boolean
      {
         return (state == null || !state.isDead) && canBeTargeted.enabled;
      }
      
      public function get enemyTeam() : Team
      {
         return _enemyTeam;
      }
      
      public function get_enemyTeam() : Team
      {
         if(_enemyTeam == null && team.enemyTeam != null)
         {
            setEnemyTeam(team.enemyTeam);
         }
         return _enemyTeam;
      }
      
      override public function getVisualPosition() : Number
      {
         var _loc5_:* = null as HookedValue;
         var _loc6_:* = null as GenericHookListener;
         var _loc2_:MovingBody = body;
         var _loc1_:Number = _loc2_.x + _loc2_.vx * (engine.timeline.time - engine.movement.oldTime);
         var _loc3_:GenericHook_Float = hooks.getVisualPosition;
         var _loc4_:Number = _loc1_;
         if(_loc3_.listeners == null)
         {
            _loc1_ = _loc4_;
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc5_ = HookedValue.pool.pop();
               _loc5_.value = _loc4_;
            }
            else
            {
               _loc5_ = new HookedValue(_loc4_);
            }
            _loc6_ = _loc3_.listeners;
            do
            {
               _loc6_.callback(_loc5_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != null);
            
            _loc4_ = _loc5_.value;
            _loc5_.value = null;
            HookedValue.pool.push(_loc5_);
            _loc1_ = _loc4_;
         }
         return _loc1_;
      }
      
      override public function getVisualDirection() : int
      {
         var _loc1_:* = null as Hero;
         if(canMove.enabled)
         {
            if(skills == null || skills.enemyTeam == null)
            {
               if(body.vx > 0)
               {
                  return 1;
               }
               if(body.vx < 0)
               {
                  return -1;
               }
            }
            else
            {
               _loc1_ = skills.enemyTeam.targetSelector.getNearest(this);
               if(_loc1_ != null)
               {
                  if(_loc1_.body.x > body.x)
                  {
                     return 1;
                  }
                  return -1;
               }
            }
         }
         return lastDirection;
      }
      
      public function getUltSkillBehavior() : String
      {
         return skills.getUlt().desc.behavior;
      }
      
      public function getTeamPosition() : int
      {
         return int(team.getHeroIndex(this));
      }
      
      public function getTargetHero() : Hero
      {
         return skills.enemyTeam.targetSelector.getNearest(this);
      }
      
      public function getRelativeHealth() : Number
      {
         if(Version.current >= 135)
         {
            return state.hp / updatedStats().hp;
         }
         return state.hp / stats.hp;
      }
      
      public function getRelativeEnergy() : Number
      {
         return state.energy / 1000;
      }
      
      public function getProjectileSpawnPosition(param1:ProjectileParam) : ViewPosition
      {
         if(param1 == null)
         {
            return new ViewPosition();
         }
         var _loc2_:ViewPosition = viewProxy.getAnchors().ground.clonePosition();
         _loc2_.x = Number(_loc2_.x + param1.x * BattleEngine.ASSET_SCALE * int(getVisualDirection()) * desc.scale);
         _loc2_.y = Number(_loc2_.y + param1.y * BattleEngine.ASSET_SCALE * desc.scale);
         return _loc2_;
      }
      
      override public function getPrimaryStats() : HeroStats
      {
         return desc.stats;
      }
      
      override public function getCurrentDirection() : int
      {
         var _loc1_:* = null as Hero;
         if(canMove.enabled)
         {
            if(skills == null || skills.enemyTeam == null)
            {
               if(body.vx > 0)
               {
                  lastDirection = 1;
               }
               else if(body.vx < 0)
               {
                  lastDirection = -1;
               }
            }
            else
            {
               _loc1_ = skills.enemyTeam.targetSelector.getNearest(this);
               if(_loc1_ != null)
               {
                  if(_loc1_.body.x > body.x)
                  {
                     lastDirection = 1;
                  }
                  else
                  {
                     lastDirection = -1;
                  }
               }
            }
         }
         return lastDirection;
      }
      
      public function fullEnergy() : Boolean
      {
         return state.energy >= 1000;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         onDie.removeAll();
         onHpZero.removeAll();
         onEnergyFull.removeAll();
         skills.dispose();
      }
      
      public function disable() : void
      {
         canUseSkills.block(this);
      }
      
      public function defaultUltEnergyDecrease() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null as GenericHook_Int;
         var _loc3_:int = 0;
         var _loc4_:* = null as HookedValue;
         var _loc5_:* = null as GenericHookListener;
         if(Version.current >= 131)
         {
            _loc1_ = 1000;
            _loc2_ = hooks.burnUltEnergy;
            _loc3_ = _loc1_;
            if(_loc2_.listeners == null)
            {
               _loc1_ = _loc3_;
            }
            else
            {
               if(int(HookedValue.pool.length) > 0)
               {
                  _loc4_ = HookedValue.pool.pop();
                  _loc4_.value = _loc3_;
               }
               else
               {
                  _loc4_ = new HookedValue(_loc3_);
               }
               _loc5_ = _loc2_.listeners;
               do
               {
                  _loc5_.callback(_loc4_);
                  _loc5_ = _loc5_.next;
               }
               while(_loc5_ != null);
               
               _loc3_ = _loc4_.value;
               _loc4_.value = null;
               HookedValue.pool.push(_loc4_);
               _loc1_ = _loc3_;
            }
            decreaseEnergy(_loc1_);
         }
         else
         {
            decreaseEnergy(1000);
         }
      }
      
      public function decreaseEnergy(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null as HookedValue;
         var _loc6_:* = null as GenericHookListener;
         var _loc3_:GenericHook_Int = hooks.decreaseEnergy;
         var _loc4_:int = param1;
         if(_loc3_.listeners == null)
         {
            _loc2_ = _loc4_;
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc5_ = HookedValue.pool.pop();
               _loc5_.value = _loc4_;
            }
            else
            {
               _loc5_ = new HookedValue(_loc4_);
            }
            _loc6_ = _loc3_.listeners;
            do
            {
               _loc6_.callback(_loc5_);
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != null);
            
            _loc4_ = _loc5_.value;
            _loc5_.value = null;
            HookedValue.pool.push(_loc5_);
            _loc2_ = _loc4_;
         }
         var _loc7_:Number = -_loc2_;
         if(BattleLog.doLog)
         {
            BattleLog.m.heroEnergy(this,state.energy,_loc7_);
         }
         if(_loc7_ > 0)
         {
            if(_loc7_ > 1000 - state.energy)
            {
               state.statistics.energyGained = Number(state.statistics.energyGained + (1000 - state.energy));
            }
            else
            {
               state.statistics.energyGained = Number(state.statistics.energyGained + _loc7_);
            }
         }
         if(_loc7_ < 0)
         {
            state.statistics.energySpent = state.statistics.energySpent - _loc7_;
         }
         if(_loc2_ <= 0 || state.energy <= 0)
         {
            return;
         }
         state.energy = state.energy - _loc2_;
         viewProxy.onEnergyModify(-_loc2_);
         if(state.energy <= 0)
         {
            state.energy = 0;
         }
      }
      
      override public function damageOverTime(param1:Number, param2:SkillCast) : int
      {
         var _loc8_:* = null as Hero;
         var _loc4_:Boolean = false;
         var _loc5_:DamageValue = new DamageValue();
         var _loc6_:int = param1;
         _loc5_.sourceValue = _loc6_;
         _loc5_.resultValue = _loc6_;
         _loc5_.source = param2;
         _loc5_.type = DamageType.DOT;
         var _loc7_:Boolean = false;
         _loc5_.blocked = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.immune = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.crited = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.dodged = _loc7_;
         _loc7_ = _loc7_;
         _loc5_.missed = _loc7_;
         _loc5_.applied = _loc7_;
         _loc5_.hitLevel = 0;
         _loc5_.element = null;
         _loc5_.redirected = _loc4_;
         _loc6_ = -1;
         _loc5_.dodgeRoll = _loc6_;
         _loc5_.critRoll = _loc6_;
         _loc5_.currentTarget = this;
         var _loc3_:DamageValue = _loc5_;
         EffectHooks.hook_applyDamage(this,_loc3_);
         engine.damage.dealDamage(_loc3_);
         if(!!_loc3_.applied && _loc3_.resultValue > int(_loc3_.currentTarget.getMaxHp()) * engine.config.stunRate)
         {
            _loc8_ = _loc3_.currentTarget;
            _loc8_.applyEffect(EffectFactory.ministunEffect(_loc3_,_loc8_.timeline),1,-1,EffectAnimationIdent.COMMON);
         }
         _loc3_.currentTarget.viewProxy.onTakeDamage(_loc3_);
         return _loc3_.resultValue;
      }
      
      public function customActionUserInput(param1:int) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.customHeroInput(this,param1);
         }
         if(actions == null)
         {
            return;
         }
         actions.trigger(param1);
      }
      
      public function claimDead() : void
      {
         var _loc1_:HeroState = state;
         if((_loc1_.hp ^ 1694084416) != _loc1_.hpLastHashed)
         {
            Context.engine.data.b = 1;
         }
         _loc1_.hpLastHashed = 0 ^ 1694084416;
         _loc1_.hp = 0;
         _loc1_.isDead = true;
         _loc1_.energy = 0;
         viewProxy.onHpModify(0);
         viewProxy.onEnergyModify(0);
         onDie.fire();
      }
      
      public function beforeTakeDamage(param1:DamageValue) : void
      {
         EffectHooks.hook_takeDamage(this,param1);
      }
      
      public function availableToAllies() : Boolean
      {
         return !state.isDead && canBeTargetedByAliases.enabled;
      }
      
      public function applyDamage(param1:DamageValue) : int
      {
         var _loc2_:* = null as Hero;
         EffectHooks.hook_applyDamage(this,param1);
         engine.damage.dealDamage(param1);
         if(!!param1.applied && param1.resultValue > int(param1.currentTarget.getMaxHp()) * engine.config.stunRate)
         {
            _loc2_ = param1.currentTarget;
            _loc2_.applyEffect(EffectFactory.ministunEffect(param1,_loc2_.timeline),1,-1,EffectAnimationIdent.COMMON);
         }
         param1.currentTarget.viewProxy.onTakeDamage(param1);
         return param1.resultValue;
      }
      
      public function animateDeath() : void
      {
         var _loc3_:* = null as HookedValue;
         var _loc4_:* = null as GenericHookListener;
         canMove.block(this);
         var _loc1_:GenericHook_battle_proxy_idents_HeroAnimationIdent = hooks.setAnimation;
         var _loc2_:HeroAnimationIdent = HeroAnimationIdent.DIE;
         §§push(viewProxy);
         if(_loc1_.listeners == null)
         {
            §§push(_loc2_);
         }
         else
         {
            if(int(HookedValue.pool.length) > 0)
            {
               _loc3_ = HookedValue.pool.pop();
               _loc3_.value = _loc2_;
            }
            else
            {
               _loc3_ = new HookedValue(_loc2_);
            }
            _loc4_ = _loc1_.listeners;
            do
            {
               _loc4_.callback(_loc3_);
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != null);
            
            _loc2_ = _loc3_.value;
            _loc3_.value = null;
            HookedValue.pool.push(_loc3_);
            §§push(_loc2_);
         }
         §§pop().setAnimation(§§pop(),null);
         viewProxy.onDie();
      }
      
      public function adjustToTarget() : void
      {
         if(desc == null)
         {
            return;
         }
         if(!canMove.enabled)
         {
            return;
         }
         if(!canWalk.enabled)
         {
            if(body.vx > 0 || body.vx < 0)
            {
               setVelocity(0);
            }
            return;
         }
         var _loc1_:Skill = skills.getAutoAttack();
         if(_loc1_ == null || !_loc1_.get_movementNeeded())
         {
            if(body.vx > 0 || body.vx < 0)
            {
               setVelocity(0);
            }
            return;
         }
         var _loc2_:Hero = skills.enemyTeam.targetSelector.getNearest(this);
         if(_loc2_ == null || !_loc2_.get_isAvailable())
         {
            if(body.vx > 0 || body.vx < 0)
            {
               setVelocity(0);
            }
            return;
         }
         if(_loc2_.body.x > body.x)
         {
            lastDirection = 1;
         }
         else
         {
            lastDirection = -1;
         }
         viewProxy.setAnimation(HeroAnimationIdent.NONE,null);
         setVelocity(speed.get_value() * lastDirection);
      }
      
      public function addCustomInputAction(param1:CustomManualAction) : void
      {
         if(actions == null)
         {
            actions = new InputActionHolder(engine,this,team);
         }
         actions.add(param1);
         Context.scene.displayEvent(new CustomManualActionEvent(param1,desc));
      }
      
      public function actionUserInput() : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.heroInput(this);
         }
         engine.movement.update(timeline);
         if(team.desc.logInput)
         {
            team.desc.logCastEvent(this,timeline.time,timeline.eventIndex);
         }
         skills.manualCast();
      }
   }
}
