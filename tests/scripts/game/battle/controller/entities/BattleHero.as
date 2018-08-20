package game.battle.controller.entities
{
   import battle.Hero;
   import battle.data.BattleHeroDescription;
   import battle.objects.BattleEntity;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.hero.BattleHeroController;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.controller.hero.BattleHeroInspector;
   import game.battle.controller.position.BattleBodyState;
   import game.battle.controller.position.IHeroController;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.hero.HeroView;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   
   public class BattleHero implements IBattleEntityMediator
   {
      
      public static var BATTLE_INSPECTOR:Boolean = false;
       
      
      private var controllers:Vector.<IHeroController>;
      
      private var controller:IHeroController;
      
      private var battleController:BattleHeroController;
      
      private var _view:HeroView;
      
      private var _model:Hero;
      
      private var _heroEntry:HeroEntryValueObject;
      
      protected var graphics:BattleGraphicsMethodProvider;
      
      private var objects:BattleMediatorObjects;
      
      public function BattleHero(param1:BattleHeroDescription, param2:BattleMediatorObjects, param3:BattleGraphicsMethodProvider)
      {
         controllers = new Vector.<IHeroController>();
         super();
         _view = param3.getOrCreateHeroView(param1);
         this.objects = param2;
         param2.addHero(this);
      }
      
      public function dispose() : void
      {
         objects.removeHero(this);
      }
      
      public function unlink() : void
      {
         if(battleController)
         {
            battleController.unlink();
         }
      }
      
      public function get view() : HeroView
      {
         return _view;
      }
      
      public function get hero() : Hero
      {
         return _model;
      }
      
      public function get currentController() : IHeroController
      {
         return controller;
      }
      
      public function get modelState() : BattleBodyState
      {
         return !!battleController?battleController.modelState:null;
      }
      
      public function updateGraphicsMethodProvider(param1:BattleGraphicsMethodProvider) : void
      {
         this.graphics = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(controller != null)
         {
            controller.advanceTime(param1);
         }
      }
      
      public function setHappy() : void
      {
         view.win();
         view.position.movement = 0;
         view.updatePosition();
      }
      
      public function onDisposeAnimationCompleteSignal() : Signal
      {
         if(view.isDying)
         {
            return view.onDeath;
         }
         return null;
      }
      
      public function travelTo(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = battleController.hero.speed.initialValue;
         var _loc4_:TravelHeroController = new TravelHeroController(view,param1,param2,_loc5_,param3);
         _loc4_.onCompleted.add(nextController);
         this.controller = _loc4_;
      }
      
      public function stopTravel() : void
      {
         if(controller is TravelHeroController)
         {
            (controller as TravelHeroController).stop();
         }
      }
      
      private function nextController() : void
      {
         this.controller = controllers.shift();
      }
      
      public function setEntity(param1:BattleEntity) : void
      {
         subscribe(param1 as Hero);
      }
      
      public function subscribe(param1:Hero) : void
      {
         if(objects.isPlayerSideTeam(param1.team))
         {
            view.statusBar.setGreenBar();
         }
         else
         {
            view.statusBar.setRedBar();
         }
         if(objects.isHeroWithPanel(param1))
         {
            battleController = new BattleHeroControllerWithPanel(param1,view,graphics,objects);
         }
         else
         {
            battleController = new BattleHeroController(param1,view,graphics,objects);
         }
         view.statusBar.headYOffset = view.initialBounds.y;
         if(BattleHero.BATTLE_INSPECTOR)
         {
            view.statusBar.battleInspector = new BattleHeroInspector(param1,objects.inspector);
         }
         battleController.signal_deathAnimationBegin.add(handler_deathAnimationBegin);
         battleController.signal_deathAnimationEnd.add(handler_deathAnimationEnd);
         controllers.unshift(battleController);
         this.controller = battleController;
         this._model = param1;
         param1.setProxy(battleController);
         param1.showEffects.onDisable.add(onEffectsVisibilityAltered);
         param1.showEffects.onEnable.add(onEffectsVisibilityAltered);
         param1.showShadow.onDisable.add(onShadowVisibilityAltered);
         param1.showShadow.onEnable.add(onShadowVisibilityAltered);
      }
      
      public function removeEntity() : void
      {
      }
      
      protected function onEffectsVisibilityAltered() : void
      {
         view.tweenEffectsAlpha(!!hero.showEffects.enabled?1:0);
      }
      
      protected function onShadowVisibilityAltered() : void
      {
         view.tweenShadowAlpha(!!hero.showShadow.enabled?1:0);
      }
      
      private function handler_deathAnimationBegin() : void
      {
         var _loc1_:RewardData = objects.getReward(this);
         if(_loc1_)
         {
            graphics.dropReward(this,_loc1_);
         }
         objects.animationWaitor.heroDeathAnimationStarted();
      }
      
      protected function handler_deathAnimationEnd() : void
      {
         if(Tutorial.flags.tutorialMission)
         {
            Tutorial.events.triggerEvent_battle_heroDead(hero.desc.heroId);
         }
         view.setEffectsText("");
         graphics.freeHeroView(hero.desc);
         dispose();
         objects.animationWaitor.heroDeathAnimationEnded();
      }
   }
}
