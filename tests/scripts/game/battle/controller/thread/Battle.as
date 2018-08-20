package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.Team;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import battle.proxy.empty.EmptySceneProxy;
   import battle.skills.Context;
   import game.assets.battle.BattleAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.RandomSequence;
   import game.battle.controller.BattleController;
   import game.battle.controller.BattleDataTraceableDescription;
   import game.battle.controller.BattleMediator;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.BattleGraphicsProvider;
   import game.battle.view.BattleScene;
   import game.battle.view.hero.BattleContext;
   import game.battle.view.hero.IBattleSubsystem;
   import game.screen.BattleScreen;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   
   public class Battle implements IAnimatable
   {
      
      public static var DEFAULT_TIME_RATE:Number = 1;
       
      
      public const signal_hasWinner:Signal = new Signal(Battle);
      
      public const onComplete:Signal = new Signal(Battle);
      
      private var screen:BattleScreen;
      
      private var controller:BattleController;
      
      private var config:BattleConfig;
      
      protected var _battleData:BattleData;
      
      protected var model:BattleEngine;
      
      protected var mediatorObjects:BattleMediatorObjects;
      
      protected const context:BattleContext = new BattleContext();
      
      protected var traceableResult:BattleDataTraceableDescription;
      
      private var playerTeam:Team;
      
      private var winTeam:Team;
      
      private var completed:Boolean;
      
      private var graphicsProvider:BattleGraphicsProvider;
      
      private var sceneProxy:BattleMediator;
      
      private var _subsystems:Vector.<IBattleSubsystem>;
      
      private var timeToPauseModelAt:Number;
      
      public function Battle(param1:BattleAsset, param2:BattleScreen, param3:BattleController, param4:BattlePresets)
      {
         super();
         this.screen = param2;
         this.controller = param3;
         this.config = param4.config;
         BattleLog.doLog = true;
         param3.signal_retreat.add(onRetreat);
         mediatorObjects = param2.objects;
         _battleData = param1.battleData;
         graphicsProvider = new BattleGraphicsProvider(param1);
         createBattleModel(param1,param4);
         param2.scene.prepareForBattle(param1,mediatorObjects.getAllHeroes());
         _subsystems = param1.getSubsystems();
         advanceTime(0);
      }
      
      public function dispose() : void
      {
         screen.juggler.remove(this);
         controller.signal_auto.remove(onAutoFightToggled);
         controller.signal_retreat.remove(onRetreat);
         controller.signal_selectHero.remove(onHeroToggledFromKeyboard);
         graphicsProvider.dispose();
         var _loc3_:int = 0;
         var _loc2_:* = _subsystems;
         for each(var _loc1_ in _subsystems)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function get playerWon() : Boolean
      {
         return winTeam == playerTeam;
      }
      
      public function get hasWinner() : Boolean
      {
         return winTeam != null;
      }
      
      public function get attackersWon() : Boolean
      {
         return winTeam.desc == model.data.attackers;
      }
      
      public function get battleData() : BattleData
      {
         return _battleData;
      }
      
      public function start() : void
      {
         screen.scene.signal_travelComplete.add(onTravelCompleted);
         screen.juggler.add(this);
         var _loc3_:int = 0;
         var _loc2_:* = _subsystems;
         for each(var _loc1_ in _subsystems)
         {
            _loc1_.startBattle(context);
         }
      }
      
      public function pauseAt(param1:Number = NaN) : void
      {
         timeToPauseModelAt = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:* = NaN;
         controller.advanceTime(param1);
         var _loc6_:BattleScene = screen.scene;
         var _loc5_:Number = _loc6_.timeScale;
         param1 = _loc6_.getTimeDelta(param1);
         var _loc4_:Number = param1 * DEFAULT_TIME_RATE;
         if(!completed)
         {
            _loc4_ = _loc4_ * controller.timeScale;
         }
         if(!completed && _loc6_.canBattle && _loc5_ > 0)
         {
            _loc3_ = Number(_loc4_ * _loc5_);
            if(timeToPauseModelAt == timeToPauseModelAt)
            {
               if(model.timeline.time < timeToPauseModelAt)
               {
                  if(model.timeline.time + _loc3_ >= timeToPauseModelAt)
                  {
                     _loc3_ = Number(timeToPauseModelAt - model.timeline.time);
                     Tutorial.events.triggerEvent_battlePauseReached();
                  }
               }
               else
               {
                  _loc3_ = 0;
               }
            }
            model.advanceTime(_loc3_);
         }
         else if(completed && _loc6_.canBattle && _loc5_ > 0)
         {
            model.displayTimeline.advanceTime(model.displayTimeline.time + _loc4_ * _loc5_);
         }
         if(_loc4_ * _loc5_ > 0)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _subsystems;
            for each(var _loc2_ in _subsystems)
            {
               _loc2_.advanceTime(_loc4_ * _loc5_);
            }
         }
         if(_loc6_.canBattle && _loc5_ > 0)
         {
            screen.objects.bodies.advanceTime(_loc4_ * _loc5_);
         }
         controller.progressInfo.setTime(model.timeline.time);
         screen.objects.advanceTime(_loc4_ * _loc5_);
         _loc6_.advanceTime(_loc4_);
         if(screen.gui)
         {
            screen.gui.advanceTime(param1,_loc4_);
         }
      }
      
      public function unlink() : void
      {
         Context.scene = new EmptySceneProxy();
         mediatorObjects.unlink();
      }
      
      public function fastComplete() : void
      {
         if(!completed && !screen.scene.canBattle)
         {
            controller.commitAutoStateFromPause();
         }
         completed = true;
         if(model.timeline.time == 0)
         {
            model.advanceTime(1.0e-7);
         }
         model.advanceToEnd();
         controller.pause();
         traceableResult.printWithResult(JSON.stringify(_battleData.serializeResult()));
         mediatorObjects.cleanUpBattle();
         controller.stop();
         dispose();
         onComplete.dispatch(this);
         onComplete.clear();
      }
      
      public function finishBattleSeries() : void
      {
         model.finishBattleSeries();
         screen.scene.whenAllBattlesCompleted();
      }
      
      protected function createBattleModel(param1:BattleAsset, param2:BattlePresets) : void
      {
         if(!param2.isReplay)
         {
            controller.signal_auto.add(onAutoFightToggled);
            controller.signal_selectHero.add(onHeroToggledFromKeyboard);
         }
         var _loc4_:BattleTeamDescription = param1.playerBattleTeam;
         mediatorObjects.playerSideTeamDescription = _loc4_;
         mediatorObjects.attackerIconDescription = param1.attackerIconDescription;
         mediatorObjects.defenderIconDescription = param1.defenderIconDescription;
         mediatorObjects.showBothTeamsPanels = param2.showBothTeams;
         screen.gui.setPlayerTeamHeroesCount(_loc4_.heroes.length);
         screen.gui.setAutoToggleable(param2.autoToggleable);
         if(!param2.isReplay)
         {
            _loc4_.setUserInput(!controller.auto);
         }
         var _loc5_:BattleGraphicsMethodProvider = new BattleGraphicsMethodProvider(graphicsProvider,screen.scene,screen.gui);
         sceneProxy = new BattleMediator(mediatorObjects,graphicsProvider,_loc5_);
         model = new BattleEngine(sceneProxy);
         model.onTeamEmpty.add(onTeamEmpty);
         model.onTimeUp.add(onTimeUp);
         var _loc3_:RandomSequence = new RandomSequence(_battleData.seed);
         model.load(_battleData,param2.config,AssetStorage.battle.effectFactory,_loc3_.generateInt);
         playerTeam = model.objects.getTeamByDescription(_loc4_);
         traceableResult = new BattleDataTraceableDescription(_battleData.seed,JSON.stringify(_battleData.serialize()));
         context.parent = this;
         context.engine = model;
         context.objects = mediatorObjects;
         context.mediator = sceneProxy;
         context.screen = screen;
         context.fx = graphicsProvider;
         context.graphics = _loc5_;
         context.scene = screen.scene;
         context.asset = param1;
         if(param2.isReplay)
         {
            playerTeam.onAutoFightToggle.add(onReplayAutoToggled);
         }
      }
      
      private function finishBattle() : void
      {
         if(completed)
         {
            return;
         }
         completed = true;
         traceableResult.printWithResult(JSON.stringify(_battleData.serializeResult()));
         mediatorObjects.endBattle();
         var _loc4_:int = 0;
         var _loc3_:* = _subsystems;
         for each(var _loc1_ in _subsystems)
         {
            _loc1_.endBattle();
         }
         controller.stop();
         screen.scene.endBattle();
         var _loc2_:* = 0.25;
         mediatorObjects.animationWaitor.waitForAllAnimationsToComplete(onBattleComplete,_loc2_);
      }
      
      protected function onTimeUp() : void
      {
         finishBattle();
      }
      
      protected function onTeamEmpty(param1:Team) : void
      {
         winTeam = param1.enemyTeam;
         signal_hasWinner.dispatch(this);
         finishBattle();
      }
      
      private function onRetreat() : void
      {
      }
      
      private function onAutoFightToggled() : void
      {
         playerTeam.onAutoFightToggle.fire();
      }
      
      private function onHeroToggledFromKeyboard(param1:int) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = playerTeam.desc.heroes.length;
         param1 = _loc4_ - param1;
         if(param1 >= playerTeam.desc.heroes.length || param1 < 0)
         {
            return;
         }
         var _loc2_:BattleHeroDescription = playerTeam.desc.heroes[param1];
         if(_loc2_)
         {
            _loc5_ = mediatorObjects.getHeroByDescription(_loc2_);
            if(_loc5_)
            {
               _loc3_ = _loc5_.currentController as BattleHeroControllerWithPanel;
               if(_loc3_ && _loc3_.userActionAvailable && this.controller.battleSettings.battleIsInteractive.value)
               {
                  _loc3_.action_userInput();
               }
            }
         }
      }
      
      private function onTravelCompleted() : void
      {
         controller.start();
      }
      
      protected function onBattleComplete() : void
      {
         mediatorObjects.cleanUpBattle();
         screen.scene.cleanUpBattle();
         screen.gui.cleanUpBattle();
         var _loc3_:int = 0;
         var _loc2_:* = _subsystems;
         for each(var _loc1_ in _subsystems)
         {
            _loc1_.cleanUpBattle();
         }
         onComplete.dispatch(this);
         onComplete.clear();
      }
      
      protected function onReplayAutoToggled(param1:Team) : void
      {
         controller.toggleAutoBattle();
      }
   }
}
