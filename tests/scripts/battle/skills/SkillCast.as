package battle.skills
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.data.DamageType;
   import battle.data.ProjectileParam;
   import battle.objects.ProjectileFactory;
   import battle.proxy.ViewTransformProvider;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import battle.signals.SignalNotifier;
   import battle.timeline.CallbackNode;
   import battle.timeline.Scheduler;
   import battle.timeline.Timeline;
   import battle.utils.Util;
   import battle.utils.Version;
   import flash.Boot;
   
   public class SkillCast extends SkillCastActor
   {
      
      public static var pool:Vector.<SkillCast> = new Vector.<SkillCast>();
       
      
      public var unitSkill:Skill;
      
      public var uninterruptedCallbacks:Vector.<CallbackNode>;
      
      public var targetsCount:int;
      
      public var targets:Vector.<Hero>;
      
      public var target:Hero;
      
      public var onStop:SignalNotifier;
      
      public var index:int;
      
      public var enemyTeam:TeamTargetSelector;
      
      public var enemyArea:TeamTargetAreaSelector;
      
      public var displayScheduler:Scheduler;
      
      public var createdObjectsCount:int;
      
      public var behavior;
      
      public var allyTeam:TeamAllyTargetSelector;
      
      public var active:Boolean;
      
      public function SkillCast(param1:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         createdObjectsCount = 0;
         uninterruptedCallbacks = new Vector.<CallbackNode>();
         super(param1);
      }
      
      public static function create(param1:Skill, param2:Hero, param3:Timeline) : SkillCast
      {
         var _loc4_:SkillCast = new SkillCast(param3);
         _loc4_.engine = param2.engine;
         if(param1 != null)
         {
            _loc4_.skill = param1.desc;
         }
         _loc4_.hero = param2;
         _loc4_.hero.canUseSkills.onDisable.add(_loc4_.interrupt);
         _loc4_.unitSkill = param1;
         _loc4_.index = -1;
         _loc4_.targetsCount = 0;
         _loc4_.targets = new Vector.<Hero>();
         _loc4_.allyTeam = param2.team.allyTargetSelector;
         _loc4_.enemyTeam = param2.get_enemyTeam().targetSelector;
         _loc4_.enemyArea = param2.get_enemyTeam().targetAreaSelector;
         _loc4_.active = true;
         return _loc4_;
      }
      
      public static function createEnvironment(param1:Skill, param2:Timeline, param3:Team = undefined) : SkillCast
      {
         var _loc4_:SkillCast = new SkillCast(param2);
         _loc4_.skill = param1.desc;
         _loc4_.index = -1;
         _loc4_.targetsCount = 0;
         _loc4_.targets = new Vector.<Hero>();
         if(param3 != null)
         {
            _loc4_.engine = param3.engine;
            _loc4_.allyTeam = param3.allyTargetSelector;
            _loc4_.enemyTeam = param3.enemyTeam.targetSelector;
            _loc4_.enemyArea = param3.enemyTeam.targetAreaSelector;
         }
         return _loc4_;
      }
      
      public function updateEffectDuration(param1:String, param2:Number = -1, param3:Array = undefined, param4:EffectAnimationIdent = undefined) : Effect
      {
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         var _loc11_:* = null as Effect;
         var _loc5_:Effect = null;
         var _loc6_:int = getHitrate();
         var _loc7_:int = 0;
         var _loc8_:int = targetsCount;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            _loc10_ = targets[_loc9_];
            _loc11_ = _loc10_.getEffect(param1);
            if(_loc11_ != null)
            {
               _loc11_.updateDuration(param2);
            }
            else
            {
               _loc5_ = _loc10_.applyEffect(EffectFactory.normal(this,param1,param3),param2,_loc6_,param4);
            }
         }
         return _loc5_;
      }
      
      override public function toString() : String
      {
         var _loc1_:* = null as String;
         if(skill == null)
         {
            _loc1_ = "null";
         }
         else
         {
            _loc1_ = skill.behavior;
         }
         return "skillCast " + (hero == null?"null":hero.toString()) + " " + _loc1_;
      }
      
      public function tiledFx(param1:*, param2:EffectAnimationIdent, param3:String = undefined, param4:Number = 1.0E100) : void
      {
         Context.scene.addTiledFx(new ViewTransformProvider(param1,param4),skill,param2,param3);
      }
      
      public function targetEffectEnvironmental(param1:Hero, param2:String, param3:Number = -1, param4:int = -1, param5:Array = undefined, param6:EffectAnimationIdent = undefined) : Effect
      {
         return param1.applyEffect(EffectFactory.normal(this,param2,param5,true),param3,param4,param6);
      }
      
      public function targetEffect(param1:Hero, param2:String, param3:Number = -1, param4:int = -1, param5:Array = undefined, param6:EffectAnimationIdent = undefined) : Effect
      {
         return param1.applyEffect(EffectFactory.normal(this,param2,param5,false),param3,param4,param6);
      }
      
      public function stop() : Boolean
      {
         var _loc1_:* = null as Scheduler;
         var _loc2_:int = 0;
         var _loc3_:* = null as CallbackNode;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null as CallbackNode;
         if(!active)
         {
            return false;
         }
         active = false;
         if(skill != null && skill.tier <= 4)
         {
            hero.viewProxy.stopAnimation(HeroAnimationIdent.skillByTier[skill.tier],true);
         }
         if(displayScheduler != null)
         {
            _loc1_ = displayScheduler;
            _loc2_ = _loc1_.callbacks.length;
            while(true)
            {
               _loc2_--;
               if(_loc2_ <= 0)
               {
                  break;
               }
               _loc3_ = _loc1_.callbacks[_loc2_];
               if(_loc3_ != null)
               {
                  Scheduler.pool.push(_loc3_);
                  _loc3_.callback = null;
                  _loc1_.callbacks[_loc2_] = null;
               }
            }
            _loc1_.timeline.update(_loc1_,Timeline.INFINITY_TIME);
         }
         var _loc4_:Vector.<CallbackNode> = new Vector.<CallbackNode>();
         if(Version.current < 126)
         {
            _loc2_ = 0;
            _loc5_ = callbacks.length;
            while(_loc2_ < _loc5_)
            {
               _loc2_++;
               _loc6_ = _loc2_;
               _loc3_ = callbacks[_loc6_];
               if(_loc3_ != null)
               {
                  if(int(uninterruptedCallbacks.indexOf(_loc3_)) == -1)
                  {
                     _loc7_ = callbacks[_loc6_];
                     if(_loc7_ != null)
                     {
                        Scheduler.pool.push(_loc7_);
                        _loc7_.callback = null;
                        callbacks[_loc6_] = null;
                     }
                  }
                  else
                  {
                     _loc4_.push(_loc3_);
                  }
               }
            }
         }
         hero.canUseSkills.onDisable.remove(interrupt);
         if(onStop != null)
         {
            onStop.fire();
            onStop.removeAll();
            onStop = null;
         }
         if(Version.current >= 126)
         {
            _loc2_ = 0;
            _loc5_ = callbacks.length;
            while(_loc2_ < _loc5_)
            {
               _loc2_++;
               _loc6_ = _loc2_;
               _loc3_ = callbacks[_loc6_];
               if(_loc3_ != null)
               {
                  if(int(uninterruptedCallbacks.indexOf(_loc3_)) == -1)
                  {
                     _loc7_ = callbacks[_loc6_];
                     if(_loc7_ != null)
                     {
                        Scheduler.pool.push(_loc7_);
                        _loc7_.callback = null;
                        callbacks[_loc6_] = null;
                     }
                  }
                  else
                  {
                     _loc4_.push(_loc3_);
                  }
               }
            }
         }
         uninterruptedCallbacks = _loc4_;
         if(int(_loc4_.length) == 0)
         {
            dispose();
         }
         hero.skills.canCastManual.unblock(this);
         return false;
      }
      
      public function sortTargets(param1:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         if(param1 == 0 || param1 > targetsCount)
         {
            param1 = targetsCount;
         }
         var _loc2_:int = 0;
         var _loc3_:* = param1 - 1;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            _loc5_ = hero.engine.randomSource(_loc4_,param1 - 1);
            if(_loc5_ != 0)
            {
               _loc6_ = targets[_loc5_];
               targets[_loc5_] = targets[_loc4_];
               targets[_loc4_] = _loc6_;
            }
         }
      }
      
      public function skillSecondaryValue(param1:BattleSkillDescription) : Number
      {
         return Number(hero.getSkillValue(param1,param1.secondary));
      }
      
      public function skillPrimeValue(param1:BattleSkillDescription) : Number
      {
         return Number(hero.getSkillValue(param1,param1.prime));
      }
      
      public function skillPrimeDot(param1:BattleSkillDescription, param2:EffectAnimationIdent = undefined) : Effect
      {
         var _loc8_:* = null as Hero;
         var _loc3_:Number = hero.getSkillValue(param1,param1.prime);
         var _loc4_:Array = [int(_loc3_),param1.duration / 0.5];
         var _loc5_:Effect = null;
         var _loc6_:int = targetsCount;
         var _loc7_:Vector.<Hero> = targets;
         while(true)
         {
            _loc6_--;
            if(_loc6_ <= 0)
            {
               break;
            }
            _loc8_ = _loc7_[_loc6_];
            if(_loc8_.get_isAvailable())
            {
               _loc5_ = _loc8_.applyEffect(EffectFactory.normal(this,"Dot",_loc4_),-1,-1,param2);
            }
         }
         return _loc5_;
      }
      
      public function shuffleTargets(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         if(Version.current > 123)
         {
            if(param1 == 0 || param1 > targetsCount)
            {
               param1 = targetsCount;
            }
            _loc2_ = 0;
            _loc3_ = param1 - 1;
            while(_loc2_ < _loc3_)
            {
               _loc2_++;
               _loc4_ = _loc2_;
               _loc5_ = hero.engine.randomSource(_loc4_,targetsCount - 1);
               if(_loc5_ != 0)
               {
                  _loc6_ = targets[_loc5_];
                  targets[_loc5_] = targets[_loc4_];
                  targets[_loc4_] = _loc6_;
               }
            }
         }
         else
         {
            if(param1 == 0 || param1 > targetsCount)
            {
               param1 = targetsCount;
            }
            _loc2_ = 0;
            _loc3_ = param1 - 1;
            while(_loc2_ < _loc3_)
            {
               _loc2_++;
               _loc4_ = _loc2_;
               _loc5_ = hero.engine.randomSource(_loc4_,param1 - 1);
               if(_loc5_ != 0)
               {
                  _loc6_ = targets[_loc5_];
                  targets[_loc5_] = targets[_loc4_];
                  targets[_loc4_] = _loc6_;
               }
            }
         }
      }
      
      public function setTargets(param1:Vector.<Hero>) : void
      {
         targets = param1.concat();
         targetsCount = int(param1.length);
         index = -1;
      }
      
      public function selfEffect(param1:String, param2:Array = undefined, param3:EffectAnimationIdent = undefined) : Effect
      {
         return hero.applyEffect(EffectFactory.normal(this,param1,param2),-1,-1,param3);
      }
      
      public function select(param1:Hero) : void
      {
         targets.length = 0;
         if(param1 != null)
         {
            target = param1;
            targets.push(param1);
            targetsCount = 1;
         }
         else
         {
            target = null;
            targetsCount = 0;
         }
         index = -1;
      }
      
      public function secondaryValue() : Number
      {
         return Number(hero.getSkillValue(skill,skill.secondary));
      }
      
      public function secondaryDot(param1:EffectAnimationIdent = undefined, param2:Boolean = false) : Effect
      {
         var _loc8_:* = null as Hero;
         var _loc3_:Number = hero.getSkillValue(skill,skill.secondary);
         var _loc4_:Array = [int(_loc3_),skill.duration / 0.5];
         var _loc5_:Effect = null;
         var _loc6_:int = targetsCount;
         var _loc7_:Vector.<Hero> = targets;
         while(true)
         {
            _loc6_--;
            if(_loc6_ <= 0)
            {
               break;
            }
            _loc8_ = _loc7_[_loc6_];
            if(_loc8_.get_isAvailable())
            {
               _loc5_ = _loc8_.applyEffect(EffectFactory.normal(this,"Dot",_loc4_),-1,-1,param1);
               if(_loc5_ != null)
               {
                  _loc5_.keepHeroDirection = param2;
               }
            }
         }
         return _loc5_;
      }
      
      public function secondaryDamage(param1:Number = 1) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = Util.skillInt(param1 * hero.getSkillValue(skill,skill.secondary));
         var _loc3_:int = 0;
         var _loc4_:int = targetsCount;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(targets[_loc5_].get_isAvailable())
            {
               targets[_loc5_].typeDamage(_loc2_,this,skill.secondary.type);
            }
         }
      }
      
      public function reset(param1:Skill, param2:SkillSet) : void
      {
         if(onStop != null)
         {
            onStop.removeAll();
            param2.skillCast.hero.canUseMagic.onDisable.remove(interrupt);
         }
         skill = param1.desc;
         unitSkill = param1;
         if(param1.isAffectedBySilence())
         {
            param2.skillCast.hero.canUseMagic.onDisable.add(interrupt);
         }
         index = -1;
         targetsCount = 0;
         allyTeam = param2.allyTeam.allyTargetSelector;
         enemyTeam = param2.enemyTeam.targetSelector;
         enemyArea = hero.get_enemyTeam().targetAreaSelector;
         active = true;
      }
      
      public function replicate() : SkillCast
      {
         var _loc1_:SkillCast = new SkillCast(timeline);
         _loc1_.targets = new Vector.<Hero>();
         _loc1_.hero = hero;
         _loc1_.unitSkill = unitSkill;
         _loc1_.hero.canUseSkills.onDisable.add(_loc1_.interrupt);
         _loc1_.engine = engine;
         return _loc1_;
      }
      
      public function projectile() : ProjectileFactory
      {
         var _loc1_:ProjectileFactory = ProjectileFactory.instance;
         _loc1_.skillCast = this;
         _loc1_.targetTeam = hero.get_enemyTeam();
         _loc1_.position = hero.body.x;
         var _loc2_:ProjectileParam = skill.projectile;
         if(_loc2_ != null)
         {
            _loc1_.spawnOffset = _loc2_.x * hero.desc.scale * BattleEngine.ASSET_SCALE;
            _loc1_.speed = _loc2_.speed;
         }
         else
         {
            _loc1_.spawnOffset = 0;
            _loc1_.speed = 0;
         }
         _loc1_.direction = int(hero.getCurrentDirection());
         _loc1_.fxSkill = skill;
         _loc1_.targetBothTeams = false;
         _loc1_.disposeRange = 1300;
         _loc1_.fxTransform = null;
         _loc1_.fxIdent = EffectAnimationIdent.BULLET;
         return _loc1_;
      }
      
      public function primeValueInt() : int
      {
         var _loc1_:Number = hero.getSkillValue(skill,skill.prime);
         return int(_loc1_);
      }
      
      public function primeValue() : Number
      {
         return Number(hero.getSkillValue(skill,skill.prime));
      }
      
      public function primeType() : DamageType
      {
         return skill.prime.type;
      }
      
      public function primeDot(param1:EffectAnimationIdent = undefined) : Effect
      {
         var _loc7_:* = null as Hero;
         var _loc2_:Number = hero.getSkillValue(skill,skill.prime);
         var _loc3_:Array = [int(_loc2_),skill.duration / 0.5];
         var _loc4_:Effect = null;
         var _loc5_:int = targetsCount;
         var _loc6_:Vector.<Hero> = targets;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc7_ = _loc6_[_loc5_];
            if(_loc7_.get_isAvailable())
            {
               _loc4_ = _loc7_.applyEffect(EffectFactory.normal(this,"Dot",_loc3_),-1,-1,param1);
            }
         }
         return _loc4_;
      }
      
      public function primeDisableProxy(param1:BattleSkillDescription, param2:Array = undefined, param3:EffectAnimationIdent = undefined) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.effect != null)
         {
            _loc4_ = 0;
            _loc5_ = targetsCount;
            while(_loc4_ < _loc5_)
            {
               _loc4_++;
               _loc6_ = _loc4_;
               if(targets[_loc6_].get_isAvailable())
               {
                  targets[_loc6_].applyEffect(EffectFactory.normal(this,param1.effect,param2),param1.duration,int(getSkillHitrate(param1)),param3);
               }
            }
         }
      }
      
      public function primeDisableCurrent(param1:Hero, param2:Array = undefined, param3:EffectAnimationIdent = undefined) : Effect
      {
         return param1.applyEffect(EffectFactory.normal(this,skill.effect,param2),skill.duration,int(getHitrate()),param3);
      }
      
      public function primeDisable(param1:Array = undefined, param2:EffectAnimationIdent = undefined) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(skill.effect != null)
         {
            _loc3_ = 0;
            _loc4_ = targetsCount;
            while(_loc3_ < _loc4_)
            {
               _loc3_++;
               _loc5_ = _loc3_;
               if(targets[_loc5_].get_isAvailable())
               {
                  targets[_loc5_].applyEffect(EffectFactory.normal(this,skill.effect,param1),skill.duration,int(getHitrate()),param2);
               }
            }
         }
      }
      
      public function primeDamageProxy(param1:BattleSkillDescription, param2:Number = 1, param3:Number = 0) : void
      {
         var _loc9_:int = 0;
         var _loc5_:Number = param2 * hero.getSkillValue(param1,param1.prime);
         var _loc4_:int = _loc5_;
         var _loc6_:Vector.<Hero> = targets.concat();
         var _loc7_:int = 0;
         var _loc8_:int = targetsCount;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            if(_loc6_[_loc9_].get_isAvailable())
            {
               _loc6_[_loc9_].typeDamage(_loc4_,this,param1.prime.type);
            }
         }
      }
      
      public function primeDamageMultiply(param1:Number) : int
      {
         var _loc7_:int = 0;
         var _loc3_:Number = param1 * hero.getSkillValue(skill,skill.prime);
         var _loc2_:int = _loc3_;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = targetsCount;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            if(targets[_loc7_].get_isAvailable())
            {
               _loc4_ = targets[_loc7_].typeDamage(_loc2_,this,skill.prime.type);
            }
         }
         return _loc4_;
      }
      
      public function primeDamageCurrentProxy(param1:BattleSkillDescription, param2:Hero, param3:Number = 1) : int
      {
         var _loc4_:int = Util.skillInt(param3 * hero.getSkillValue(param1,param1.prime));
         return int(param2.typeDamage(_loc4_,this,param1.prime.type));
      }
      
      public function primeDamageCurrentMultiply(param1:Hero, param2:Number) : int
      {
         var _loc3_:int = Util.skillInt(param2 * hero.getSkillValue(skill,skill.prime));
         return int(param1.typeDamage(_loc3_,this,skill.prime.type));
      }
      
      public function primeDamageCurrentAdd(param1:Hero, param2:Number) : int
      {
         var _loc3_:int = Util.skillInt(Number(Number(hero.getSkillValue(skill,skill.prime)) + param2));
         return int(param1.typeDamage(_loc3_,this,skill.prime.type));
      }
      
      public function primeDamageCurrent(param1:Hero) : int
      {
         var _loc2_:int = Util.skillInt(Number(hero.getSkillValue(skill,skill.prime)));
         return int(param1.typeDamage(_loc2_,this,skill.prime.type));
      }
      
      public function primeDamageAdd(param1:Number) : void
      {
         var _loc6_:int = 0;
         var _loc3_:Number = Number(hero.getSkillValue(skill,skill.prime)) + param1;
         var _loc2_:int = _loc3_;
         var _loc4_:int = 0;
         var _loc5_:int = targetsCount;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            if(targets[_loc6_].get_isAvailable())
            {
               targets[_loc6_].typeDamage(_loc2_,this,skill.prime.type);
            }
         }
      }
      
      public function primeDamage() : void
      {
         var _loc5_:int = 0;
         var _loc2_:Number = hero.getSkillValue(skill,skill.prime);
         var _loc1_:int = _loc2_;
         var _loc3_:int = 0;
         var _loc4_:int = targetsCount;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(targets[_loc5_].get_isAvailable())
            {
               targets[_loc5_].typeDamage(_loc1_,this,skill.prime.type);
            }
         }
      }
      
      public function iterator() : SkillCastReversedIterator
      {
         return new SkillCastReversedIterator(this);
      }
      
      public function isFree() : Boolean
      {
         return createdObjectsCount == 0 && time == Timeline.INFINITY_TIME;
      }
      
      public function interrupt() : void
      {
         if(skill != null && skill.tier <= 4)
         {
            hero.viewProxy.stopAnimation(HeroAnimationIdent.skillByTier[skill.tier],false);
         }
         stop();
      }
      
      public function incrementCreatedObjects() : void
      {
         createdObjectsCount = createdObjectsCount + 1;
      }
      
      public function hasTargets() : Boolean
      {
         return targetsCount > 0;
      }
      
      public function getSkillLevel() : int
      {
         var _loc1_:BattleSkillDescription = skill;
         return int(EffectHooks.hook_getSkillLevel(hero.effects,_loc1_,_loc1_.level));
      }
      
      public function getSkillHitrate(param1:BattleSkillDescription) : int
      {
         if(param1.hitrate == 1)
         {
            return int(EffectHooks.hook_getSkillLevel(hero.effects,param1,param1.level));
         }
         return param1.hitrate;
      }
      
      public function getNextTargetOrStop() : Boolean
      {
         var _loc1_:int = targetsCount;
         var _loc2_:int = _loc1_;
         do
         {
            index = int((index + 1) % _loc1_);
            _loc2_--;
         }
         while(_loc2_ > 0 && !targets[index].get_isAvailable());
         
         if(_loc2_ != -1)
         {
            target = targets[index];
            return true;
         }
         return Boolean(stop());
      }
      
      public function getNextTargetOnceOrStop() : Boolean
      {
         do
         {
            index = index + 1;
         }
         while(index < targetsCount && !targets[index].get_isAvailable());
         
         if(index < targetsCount)
         {
            target = targets[index];
            return true;
         }
         return Boolean(stop());
      }
      
      public function getNextTargetOnce() : Boolean
      {
         do
         {
            index = index + 1;
         }
         while(index < targetsCount && !targets[index].get_isAvailable());
         
         if(index < targetsCount)
         {
            target = targets[index];
            return true;
         }
         return false;
      }
      
      public function getNextTarget() : Boolean
      {
         var _loc1_:int = targetsCount;
         var _loc2_:int = _loc1_;
         do
         {
            index = int((index + 1) % _loc1_);
            _loc2_--;
         }
         while(_loc2_ > 0 && !targets[index].get_isAvailable());
         
         if(_loc2_ != -1)
         {
            target = targets[index];
            return true;
         }
         return false;
      }
      
      public function getNextAllyOnceOrStop() : Boolean
      {
         do
         {
            index = index + 1;
         }
         while(index < targetsCount && targets[index].get_isDead());
         
         if(index < targetsCount)
         {
            target = targets[index];
            return true;
         }
         return Boolean(stop());
      }
      
      public function getHitrate() : int
      {
         var _loc1_:* = null as BattleSkillDescription;
         if(skill.hitrate == 1)
         {
            _loc1_ = skill;
            return int(EffectHooks.hook_getSkillLevel(hero.effects,_loc1_,_loc1_.level));
         }
         return skill.hitrate;
      }
      
      public function getHeroList(param1:Boolean) : HeroCollection
      {
         var _loc2_:Vector.<Hero> = targets.slice(0,targetsCount);
         _loc2_.length = targetsCount;
         var _loc3_:HeroCollection = new HeroCollection(_loc2_);
         _loc3_.filterAvailableOnly = param1;
         return _loc3_;
      }
      
      public function fx(param1:EffectAnimationIdent, param2:BattleSkillDescription = undefined) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2 == null)
         {
            _loc3_ = 0;
            _loc4_ = targetsCount;
            while(_loc3_ < _loc4_)
            {
               _loc3_++;
               _loc5_ = _loc3_;
               if(targets[_loc5_].get_isAvailable())
               {
                  Context.scene.addFx(targets[_loc5_],param1,this);
               }
            }
         }
         else
         {
            _loc3_ = 0;
            _loc4_ = targetsCount;
            while(_loc3_ < _loc4_)
            {
               _loc3_++;
               _loc5_ = _loc3_;
               if(targets[_loc5_].get_isAvailable())
               {
                  Context.scene.addFx(targets[_loc5_],param1,this,param2);
               }
            }
         }
      }
      
      public function effect(param1:String, param2:Array = undefined, param3:EffectAnimationIdent = undefined) : Effect
      {
         var _loc8_:int = 0;
         var _loc4_:Effect = null;
         var _loc5_:int = getHitrate();
         var _loc6_:int = 0;
         var _loc7_:int = targetsCount;
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc4_ = targets[_loc8_].applyEffect(EffectFactory.normal(this,param1,param2),skill.duration,_loc5_,param3);
         }
         return _loc4_;
      }
      
      public function deferredUninterruptedSequence(param1:Number, param2:Number, param3:*, param4:* = undefined) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = param2;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            uninterruptedCallbacks.push(add(param3,Number(timeline.time + param1 * (_loc7_ + 1))));
         }
         if(param4 != null)
         {
            uninterruptedCallbacks.push(add(param4,Number(timeline.time + param1 * int(param2))));
         }
      }
      
      public function deferredUninterruptedAction(param1:Number, param2:*) : void
      {
         uninterruptedCallbacks.push(add(param2,Number(timeline.time + param1)));
      }
      
      public function deferredDisplayAction(param1:Number, param2:*) : void
      {
         var callback:* = param2;
         if(displayScheduler == null)
         {
            displayScheduler = new Scheduler(Context.engine.displayTimeline);
         }
         var sc:SkillCast = this;
         displayScheduler.add(function(param1:Scheduler):void
         {
         },Number(timeline.time + param1));
      }
      
      public function decrementCreatedObjects() : void
      {
         createdObjectsCount = createdObjectsCount - 1;
      }
      
      public function complexFx(param1:*, param2:EffectAnimationIdent, param3:String = undefined, param4:Number = 1.0E100, param5:Number = 20) : void
      {
         Context.scene.addComplexFx(new ViewTransformProvider(param1,param4,param5),skill,param2,param3);
      }
      
      public function compareCloserToHero(param1:Hero, param2:Hero) : Boolean
      {
         var _loc3_:Number = param1.body.x;
         var _loc4_:Number = param2.body.x;
         var _loc5_:Number = hero.body.x;
         return int(Number((_loc5_ - _loc3_) * (_loc5_ - _loc3_) + 0.5)) < int(Number((_loc5_ - _loc4_) * (_loc5_ - _loc4_) + 0.5));
      }
      
      public function clearTargets() : void
      {
         target = null;
         targetsCount = 0;
         index = -1;
      }
      
      public function applyTeamEffect(param1:Team, param2:String, param3:Number = -1, param4:int = -1, param5:Array = undefined, param6:EffectAnimationIdent = undefined, param7:Boolean = false) : TeamEffect
      {
         var _loc8_:TeamEffect = new TeamEffect(timeline,param2,param5,param7);
         _loc8_.setSkillCast(this);
         _loc8_ = param1.applyEffect(_loc8_,param3);
         if(_loc8_ == null)
         {
            if(BattleLog.doLog)
            {
               BattleLog.m.logString("team effect canceled " + param2);
            }
         }
         return _loc8_;
      }
      
      public function applyEffect(param1:String, param2:Number = -1, param3:int = -1, param4:Array = undefined, param5:EffectAnimationIdent = undefined) : Effect
      {
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         var _loc6_:Effect = null;
         var _loc7_:int = 0;
         var _loc8_:int = targetsCount;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            _loc10_ = targets[_loc9_];
            _loc6_ = _loc10_.applyEffect(EffectFactory.normal(this,param1,param4),param2,param3,param5);
         }
         return _loc6_;
      }
      
      public function addOnStop(param1:Function) : void
      {
         if(onStop == null)
         {
            onStop = new SignalNotifier(this,"skillCast.onStop");
         }
         onStop.add(param1);
      }
   }
}
