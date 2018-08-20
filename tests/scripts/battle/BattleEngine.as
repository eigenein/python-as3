package battle
{
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import battle.data.BattleTeamDescription;
   import battle.data.HeroState;
   import battle.logic.MovementManager;
   import battle.logic.RangeFactory;
   import battle.proxy.ComplexAnimationProxy;
   import battle.proxy.ISceneProxy;
   import battle.proxy.ViewTransformProvider;
   import battle.proxy.empty.EmptySceneProxy;
   import battle.signals.SignalNotifier;
   import battle.skills.Context;
   import battle.skills.Effect;
   import battle.skills.GlobalCooldownWatcher;
   import battle.skills.ValueOverTime;
   import battle.timeline.BucketTimeline;
   import battle.timeline.EmptyUpdateTimeManager;
   import battle.timeline.Scheduler;
   import battle.timeline.Timeline;
   import battle.utils.Exception;
   import battle.utils.ExceptionType;
   import battle.utils.Util;
   import battle.utils.VectorIndex;
   import battle.utils.Version;
   import flash.Boot;
   import vm.Interpreter;
   
   public class BattleEngine
   {
      
      public static var ASSET_SCALE:Number = 0.7;
      
      public static var DOT_DELAY:Number = 0.5;
      
      public static function trace(param1:Array):void
      {
      }
      public static function log(param1:String, param2:*):void
      {
      } 
      
      public var timeline:BucketTimeline;
      
      public var scheduler:Scheduler;
      
      public var replayRecursionInterruptor:int;
      
      public var randomSource:Function;
      
      public var printer:BattlePrint;
      
      public var onTimeUp:SignalNotifier;
      
      public var onTeamEmpty:SignalNotifier;
      
      public var onStart:SignalNotifier;
      
      public var objects:Objects;
      
      public var movement:MovementManager;
      
      public var input:InputEventHolder;
      
      public var effectFactory:Function;
      
      public var doNotInterruptTimeAdvancement:Boolean;
      
      public var displayTimeline:Timeline;
      
      public var data:BattleData;
      
      public var damage:DamageManager;
      
      public var cooldownWatcher:GlobalCooldownWatcher;
      
      public var config:BattleConfig;
      
      public var complete:Boolean;
      
      public function BattleEngine(param1:ISceneProxy = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         replayRecursionInterruptor = 10000;
         doNotInterruptTimeAdvancement = false;
         onTimeUp = new SignalNotifier();
         onStart = new SignalNotifier();
         movement = new MovementManager();
         objects = new Objects(movement);
         BattleLog.m.engine = this;
         timeline = new BucketTimeline("main",movement);
         scheduler = new Scheduler(timeline);
         BattleLog.timeline = timeline;
         printer = new BattlePrint(this);
         Context.printer = printer;
         Context.engine = this;
         if(param1 != null)
         {
            Context.scene = param1;
         }
         else
         {
            Context.scene = new EmptySceneProxy();
         }
         displayTimeline = new BucketTimeline("display",new EmptyUpdateTimeManager());
         onTeamEmpty = objects.onTeamEmpty;
         objects.onTeamEmpty.add(battleEnd);
         ViewTransformProvider;
         ComplexAnimationProxy;
         ValueOverTime;
         BattleCore;
         Util;
         VectorIndex;
         Interpreter;
         return;
         §§push(RangeFactory);
      }
      
      public static function main() : void
      {
      }
      
      public static function purge() : void
      {
         Context.engine = null;
         Context.printer = null;
         Context.scene = null;
      }
      
      public static function getHeroInitialState(param1:BattleHeroDescription, param2:BattleConfig) : *
      {
         var _loc4_:* = null as BattleSkillDescription;
         var _loc5_:int = 0;
         var _loc8_:* = null as Class;
         var _loc3_:Vector.<BattleSkillDescription> = param1.skills;
         var _loc6_:int = 0;
         var _loc7_:int = _loc3_.length;
         while(true)
         {
            _loc6_++;
            if(_loc6_ >= _loc7_)
            {
               break;
            }
            _loc4_ = _loc3_[_loc6_];
            _loc5_ = _loc6_;
            while(_loc5_ > 0 && _loc3_[_loc5_ - 1].tier > _loc4_.tier)
            {
               _loc3_[_loc5_] = _loc3_[_loc5_ - 1];
               _loc5_--;
            }
            _loc3_[_loc5_] = _loc4_;
         }
         _loc5_ = _loc3_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc8_ = Type.resolveClass("code." + _loc3_[_loc5_].behavior);
            _loc3_[_loc5_].initialize(Type.createInstance(_loc8_,BattleTeamDescription.EMPTY_ARRAY));
         }
         return param1.getInitialState(param2).serialize();
      }
      
      public static function getTeamInitialStates(param1:BattleTeamDescription, param2:BattleConfig) : Vector.<Object>
      {
         var _loc6_:* = null as BattleHeroDescription;
         var _loc3_:Vector.<Object> = new Vector.<Object>();
         var _loc4_:Vector.<BattleHeroDescription> = param1.heroes;
         var _loc5_:int = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_];
            _loc3_[_loc6_.id] = _loc6_.getInitialState(param2).serialize();
         }
         return _loc3_;
      }
      
      public function replay() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(input == null)
         {
            timeline.advanceTime(Timeline.INFINITY_TIME);
         }
         else
         {
            _loc1_ = input.getNextTime();
            _loc2_ = input.getNextIndex();
            do
            {
               timeline.advanceTime(_loc1_,_loc2_);
               checkReplayLoop();
               if(timeline.time != Timeline.INFINITY_TIME)
               {
                  while(_loc2_ == timeline.eventIndex)
                  {
                     _loc1_ = input.next();
                     _loc2_ = input.getNextIndex();
                     checkReplayLoop();
                  }
               }
               else
               {
                  _loc1_ = Timeline.INFINITY_TIME;
               }
            }
            while(_loc1_ < Timeline.INFINITY_TIME);
            
            timeline.advanceTime(Timeline.INFINITY_TIME);
         }
      }
      
      public function onTimeIsOver(param1:Scheduler) : void
      {
         var _loc2_:Team = objects.get_attackers();
         var _loc3_:Team = objects.get_defenders();
         if(BattleLog.doLog)
         {
            BattleLog.m.timesUp(_loc2_,_loc3_);
         }
         objects.disableAll();
         battleEnd(null);
         onTimeUp.fire();
      }
      
      public function load(param1:BattleData, param2:BattleConfig, param3:Function, param4:Function) : void
      {
         if(param3 == null)
         {
            throw new Exception(ExceptionType.ArgumentError,"Invalid effectFactory provided");
         }
         if(param4 == null)
         {
            throw new Exception(ExceptionType.ArgumentError,"Invalid randomSource provided");
         }
         if(param2 == null)
         {
            throw new Exception(ExceptionType.ArgumentError,"Invalid BattleConfig provided");
         }
         effectFactory = param3;
         randomSource = param4;
         config = param2;
         data = param1;
         complete = false;
         param1.b = 0;
         Version.current = param1.v;
         cooldownWatcher = new GlobalCooldownWatcher(this,timeline);
         damage = new DamageManager(param4,param2);
         var _loc5_:Team = objects.createEmptyTeam(this,1,param2.immediateAttackersUltimates);
         var _loc6_:Team = objects.createEmptyTeam(this,-1,param2.immediateDefendersUltimates);
         objects.createTeam(_loc5_,param1.attackers,this);
         objects.createTeam(_loc6_,param1.defenders,this);
         objects.initTeams(this);
         scheduler.add(onTimeIsOver,param2.battleDuration);
         onStart.fire();
      }
      
      public function finishBattleSeries() : void
      {
         var _loc3_:* = null as Team;
         var _loc4_:* = null as Vector.<Hero>;
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc1_:Vector.<Team> = objects.teams;
         var _loc2_:int = _loc1_.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = _loc3_.heroes;
            _loc5_ = _loc4_.length;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc4_[_loc5_];
               _loc6_.effects.removeAllEffects();
            }
         }
      }
      
      public function createEffect(param1:Effect) : void
      {
         effectFactory(param1);
      }
      
      public function checkReplayLoop() : void
      {
         var _loc1_:int = replayRecursionInterruptor;
         replayRecursionInterruptor = replayRecursionInterruptor - 1;
         if(_loc1_ <= 0)
         {
            throw "possible infinite replay loop entered at t=" + timeline.time;
         }
      }
      
      public function battleEnd(param1:Team) : void
      {
         objects.get_attackers().dispose();
         objects.get_defenders().dispose();
         objects.onTeamEmpty.removeAll();
         timeline.clear();
         displayTimeline.clear();
         complete = true;
      }
      
      public function advanceToEnd() : void
      {
         while(timeline.time < config.battleDuration && !data.isOver())
         {
            timeline.advanceTime(Timeline.INFINITY_TIME);
         }
         if(!data.isOver())
         {
            objects.disableAll();
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(input == null)
         {
            timeline.advanceTime(Number(timeline.time + param1));
            displayTimeline.advanceTime(timeline.time);
         }
         else
         {
            _loc2_ = timeline.time + param1;
            _loc3_ = input.getNextTime();
            timeline.timeAdvancementInterrupted = false;
            while((timeline.time < _loc2_ || _loc3_ <= _loc2_) && !timeline.timeAdvancementInterrupted && timeline.time < Timeline.INFINITY_TIME)
            {
               if(_loc3_ <= _loc2_ && _loc3_ != Timeline.INFINITY_TIME)
               {
                  _loc4_ = input.getNextIndex();
                  timeline.advanceTime(_loc3_,_loc4_);
                  if(!timeline.timeAdvancementInterrupted)
                  {
                     _loc3_ = input.next();
                     continue;
                  }
                  break;
               }
               timeline.advanceTime(_loc2_);
            }
            displayTimeline.advanceTime(timeline.time);
         }
      }
      
      public function advanceDisplayTimeline() : void
      {
         displayTimeline.advanceTime(timeline.time);
      }
      
      public function addStartListener(param1:Function) : void
      {
         scheduler.add(param1,0);
      }
   }
}
