package game.view.popup.tower.screen
{
   import engine.core.animation.ZSortedSprite;
   import engine.core.assets.AssetLoader;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerScreenFloorTransitionController;
   import game.mediator.gui.popup.tower.TowerScreenHeroMediator;
   import game.view.hero.FreeTowerHero;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.Sprite;
   
   public class TowerScreenHeroes implements IAnimatable
   {
       
      
      private var timer:Timer;
      
      private var heroes:Vector.<FreeTowerHero>;
      
      private var assets:Vector.<HeroRsxAssetDisposable>;
      
      private var mediator:TowerScreenHeroMediator;
      
      private var walkSpeed:Number = 1.5;
      
      private var speed:Number = 1;
      
      private var teamStartPosition:Number = 0;
      
      private var teamTargetPosition:Number = 0;
      
      private var _graphics:Sprite;
      
      private var _signal_transitionComplete:Signal;
      
      public function TowerScreenHeroes(param1:TowerScreenHeroMediator)
      {
         timer = new Timer(1000,1);
         heroes = new Vector.<FreeTowerHero>();
         _signal_transitionComplete = new Signal();
         super();
         this.mediator = param1;
         _graphics = new Sprite();
         timer.addEventListener("timerComplete",handler_timer);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = heroes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            removeHero(heroes[_loc2_]);
            _loc2_++;
         }
         var _loc5_:int = 0;
         var _loc4_:* = assets;
         for each(var _loc3_ in assets)
         {
            if(_loc3_ != null)
            {
               _loc3_.dropUsage();
            }
         }
         assets.length = 0;
         timer.removeEventListener("timerComplete",handler_timer);
         timer.stop();
      }
      
      public function get graphics() : Sprite
      {
         return _graphics;
      }
      
      public function get signal_transitionComplete() : Signal
      {
         return _signal_transitionComplete;
      }
      
      public function init() : void
      {
         updateActiveHeroes();
      }
      
      public function update() : void
      {
         updateActiveHeroes();
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(heroes)
         {
            _loc2_ = heroes.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               heroes[_loc3_].advanceTime(param1 * speed);
               heroes[_loc3_].view.advanceTime(param1 * speed);
               _loc3_++;
            }
            _graphics.sortChildren(ZSortedSprite.sortMethod);
         }
      }
      
      public function action_moveFromRight() : void
      {
         setTeamPosition(1020);
         setTeamTargetPosition(520);
         startTimer();
      }
      
      public function action_moveToRight() : void
      {
         setTeamTargetPosition(1100);
         startTimer();
      }
      
      public function action_moveToLeft() : void
      {
         setTeamTargetPosition(-500);
         startTimer();
      }
      
      public function action_moveFromLeft() : void
      {
         setTeamPosition(-370);
         setTeamTargetPosition(250);
         startTimer();
      }
      
      public function action_gentlyHideHeroes() : void
      {
         Starling.juggler.tween(_graphics,TowerScreenFloorTransitionController.heroHideDelay,{"alpha":0});
      }
      
      protected function updateActiveHeroes() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function removeHero(param1:FreeTowerHero) : void
      {
         param1.view.transform.removeFromParent();
         param1.dispose();
      }
      
      private function setTeamPosition(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = heroes.length;
         teamStartPosition = param1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            heroes[_loc3_].setTeamPositionIndex(_loc3_);
            heroes[_loc3_].setPosition(teamStartPosition + 80 * _loc3_,0);
            _loc3_++;
         }
      }
      
      private function setTeamTargetPosition(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = heroes.length;
         teamTargetPosition = param1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            heroes[_loc3_].setTeamPositionIndex(_loc3_);
            heroes[_loc3_].targetPosition(teamTargetPosition + 80 * _loc3_,0);
            _loc3_++;
         }
      }
      
      private function startTimer() : void
      {
         _graphics.alpha = 1;
         timer.reset();
         timer.delay = TowerScreenFloorTransitionController.getHeroMovementDelay() * 1000;
         timer.start();
         speed = walkSpeed;
      }
      
      protected function onAssetsCompleted(param1:AssetLoader) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function handler_timer(param1:TimerEvent) : void
      {
         _signal_transitionComplete.dispatch();
         speed = 1;
      }
   }
}
