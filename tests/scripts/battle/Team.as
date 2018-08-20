package battle
{
   import battle.data.BattleTeamDescription;
   import battle.effects.IStatsInvalidator;
   import battle.events.BattleSignal;
   import battle.logic.MovingBody;
   import battle.logic.RangeBase;
   import battle.objects.EffectContainer;
   import battle.proxy.CustomManualAction;
   import battle.proxy.InputActionHolder;
   import battle.signals.SignalNotifier;
   import battle.skills.Skill;
   import battle.skills.SkillCast;
   import battle.skills.TargetSelectResolver;
   import battle.skills.TeamAllyTargetSelector;
   import battle.skills.TeamEffect;
   import battle.skills.TeamTargetAreaSelector;
   import battle.skills.TeamTargetSelector;
   import battle.stats.PercentBuffData;
   import battle.utils.Version;
   import flash.Boot;
   
   public class Team implements IStatsInvalidator
   {
       
      
      public var targetSelectors:Vector.<TargetSelectResolver>;
      
      public var targetSelector:TeamTargetSelector;
      
      public var targetAreaSelector:TeamTargetAreaSelector;
      
      public var ranges:Vector.<RangeBase>;
      
      public var onEmpty:BattleSignal;
      
      public var onAutoFightToggle:SignalNotifier;
      
      public var onAutoFightEnabled:SignalNotifier;
      
      public var immediateUltimates:Boolean;
      
      public var heroes:Vector.<Hero>;
      
      public var engine:BattleEngine;
      
      public var enemyTeam:Team;
      
      public var effects:EffectContainer;
      
      public var direction:int;
      
      public var desc:BattleTeamDescription;
      
      public var bodies:Vector.<MovingBody>;
      
      public var autoFight:Boolean;
      
      public var allyTargetSelector:TeamAllyTargetSelector;
      
      public var actions:InputActionHolder;
      
      public var _environmentEffectSource:SkillCast;
      
      public function Team(param1:BattleEngine = undefined, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         engine = param1;
         direction = param2;
         autoFight = true;
         onAutoFightEnabled = new SignalNotifier(null,"Team.onAutoFightEnabled");
         onAutoFightToggle = new SignalNotifier(this,"Team.onAutoFightToggled");
         onAutoFightToggle.add(onAutoFightToggledHandler);
         onEmpty = new BattleSignal();
         heroes = Vector.<Hero>([]);
         ranges = new Vector.<RangeBase>();
         targetSelectors = new Vector.<TargetSelectResolver>();
         _environmentEffectSource = SkillCast.createEnvironment(Skill.environmentSkill(param1),param1.timeline);
         allyTargetSelector = new TeamAllyTargetSelector(this);
         targetSelector = new TeamTargetSelector(this);
         targetAreaSelector = new TeamTargetAreaSelector(this);
         effects = new EffectContainer(this);
      }
      
      public function toString() : String
      {
         if(direction > 0)
         {
            return "team left";
         }
         return "team right";
      }
      
      public function removeTargetSelector(param1:TargetSelectResolver) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function removeRange(param1:RangeBase) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function removeFromRanges(param1:Hero) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function onHeroDie() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function onAutoFightToggledHandler(param1:Team) : void
      {
         engine.movement.update(engine.timeline);
         autoFight = !autoFight;
         if(BattleLog.doLog)
         {
            BattleLog.m.toggleAuto(param1);
         }
         if(autoFight)
         {
            onAutoFightEnabled.fire();
         }
      }
      
      public function isAutoFightToggled() : Boolean
      {
         return autoFight;
      }
      
      public function invalidateStats() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = heroes.length;
         while(_loc1_ < _loc2_)
         {
            _loc1_++;
            _loc3_ = _loc1_;
            heroes[_loc3_].invalidateStats();
         }
      }
      
      public function initializeHeroesPositions(param1:BattleConfig) : void
      {
         var _loc2_:Number = NaN;
         var _loc5_:int = 0;
         if(direction > 0)
         {
            _loc2_ = param1.leftTeamStartPosition;
         }
         else
         {
            _loc2_ = param1.rightTeamStartPosition;
         }
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            heroes[_loc5_].body.x = _loc2_ - _loc5_ * direction * param1.inTeamHeroInterval;
         }
      }
      
      public function init(param1:BattleTeamDescription) : void
      {
         desc = param1;
      }
      
      public function getHeroIndex(param1:Hero) : int
      {
         return int(heroes.indexOf(param1));
      }
      
      public function getHeroByIndex(param1:int) : Hero
      {
         if(param1 > 0 && param1 < int(heroes.length))
         {
            return heroes[param1];
         }
         return null;
      }
      
      public function getHeroById(param1:int) : Hero
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(heroes[_loc5_].desc.id == param1)
            {
               return heroes[_loc5_];
            }
         }
         return null;
      }
      
      public function getCenter() : Number
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = heroes[_loc5_];
            if(!_loc6_.get_isDead())
            {
               _loc1_++;
               _loc2_ = Number(_loc2_ + _loc6_.body.x);
            }
         }
         if(_loc1_ == 0)
         {
            return 0;
         }
         return _loc2_ / _loc1_;
      }
      
      public function getBodies() : Vector.<MovingBody>
      {
         return bodies;
      }
      
      public function getAll() : Vector.<Hero>
      {
         return heroes;
      }
      
      public function dispose() : void
      {
         onAutoFightToggle.removeAll();
      }
      
      public function customActionTeamInput(param1:int) : void
      {
         if(BattleLog.doLog)
         {
            BattleLog.m.teamInput(this,param1);
         }
         if(actions == null)
         {
            return;
         }
         actions.trigger(param1);
      }
      
      public function applyInitialBehavior() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = heroes.length;
         while(_loc1_ < _loc2_)
         {
            _loc1_++;
            _loc3_ = _loc1_;
            heroes[_loc3_].skills.applyInitialBehavior();
         }
      }
      
      public function applyEnvironmentEffects(param1:Hero) : void
      {
         var _loc5_:* = null as String;
         var _loc6_:* = null as String;
         var _loc7_:* = null;
         var _loc2_:PercentBuffData = null;
         var _loc3_:int = 0;
         var _loc4_:Array = Reflect.fields(desc.effectsObject);
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            if(int(_loc5_.indexOf("percentBuff_")) == 0)
            {
               if(_loc2_ == null)
               {
                  _loc2_ = new PercentBuffData();
               }
               _loc6_ = _loc5_.substr(12);
               _loc7_ = Reflect.field(desc.effectsObject,_loc5_);
               _loc2_[_loc6_] = _loc7_;
            }
         }
         if(_loc2_ != null)
         {
            _environmentEffectSource.targetEffect(param1,"PercentBuff",-1,-1,[_loc2_]);
         }
      }
      
      public function applyEffect(param1:TeamEffect, param2:Number) : TeamEffect
      {
         return effects.applyToTeam(this,param1,param2);
      }
      
      public function addToRanges(param1:Hero) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addTargetSelector(param1:TargetSelectResolver) : void
      {
         if(int(targetSelectors.indexOf(param1)) == -1)
         {
            targetSelectors.push(param1);
         }
      }
      
      public function addRange(param1:RangeBase) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addHero(param1:Hero) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addCustomInputAction(param1:CustomManualAction) : void
      {
         if(actions == null)
         {
            actions = new InputActionHolder(engine,null,this);
         }
         actions.add(param1);
      }
   }
}
