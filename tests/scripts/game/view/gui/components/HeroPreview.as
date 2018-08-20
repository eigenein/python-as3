package game.view.gui.components
{
   import game.assets.HeroAssetProvider;
   import game.assets.HeroRsxAssetDisposable;
   import game.battle.view.hero.AnimationIdent;
   import game.battle.view.hero.HeroView;
   import game.battle.view.hero.HeroViewContainer;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class HeroPreview extends HeroViewContainer
   {
       
      
      private var heroView:HeroView;
      
      private var assetLoader:HeroAssetProvider;
      
      private var scheduledAnimations:Vector.<ScheduledAnimationIdent>;
      
      private var prefix:String = null;
      
      private var _playbackSpeed:Number = 1;
      
      public var isPlaying:Boolean = true;
      
      public function HeroPreview()
      {
         assetLoader = new HeroAssetProvider(onAssetLoaded);
         scheduledAnimations = new Vector.<ScheduledAnimationIdent>();
         super();
         graphics.addEventListener("enterFrame",handler_enterFrame);
         graphics.addEventListener("disposed",handler_disposeGraphics);
      }
      
      public function dispose() : void
      {
         if(heroView)
         {
            heroView.dispose();
            heroView = null;
         }
         assetLoader.dispose();
         graphics.removeEventListener("enterFrame",handler_enterFrame);
         graphics.removeEventListener("disposed",handler_disposeGraphics);
      }
      
      public function get graphics() : DisplayObject
      {
         return heroesContainer;
      }
      
      public function get isBusy() : Boolean
      {
         if(heroView)
         {
            return !heroView.canStrafe;
         }
         return true;
      }
      
      public function set playbackSpeed(param1:Number) : void
      {
         _playbackSpeed = param1;
         if(heroView)
         {
            heroView.globalPlaybackSpeed = param1;
         }
      }
      
      public function loadHero(param1:UnitDescription, param2:int = 0, param3:String = "") : void
      {
         if(!param1)
         {
            return;
         }
         this.prefix = param3;
         assetLoader.request(param1.id,param2);
      }
      
      public function loadTitan(param1:TitanDescription, param2:int = 0, param3:String = "") : void
      {
         this.prefix = param3;
         assetLoader.request(param1.id,param2);
      }
      
      public function scheduleAnimation(param1:AnimationIdent, param2:String) : void
      {
         var _loc3_:* = null;
         if(assetLoader.complete)
         {
            heroView.setAnimation(param1,param2);
         }
         else
         {
            _loc3_ = new ScheduledAnimationIdent();
            _loc3_.ident = param1;
            _loc3_.animationClipName = param2;
            scheduledAnimations.push(_loc3_);
         }
      }
      
      public function playRandomAnimation() : void
      {
         if(!heroView)
         {
            return;
         }
         var _loc1_:int = Math.random() * 6;
         if(_loc1_ == 5)
         {
            heroView.isMoving = 1;
         }
         else if(_loc1_ == 4)
         {
            heroView.isMoving = 0;
         }
         else
         {
            heroView.attack(_loc1_);
         }
      }
      
      public function attack() : void
      {
         if(!heroView)
         {
            return;
         }
         heroView.attack(0);
      }
      
      public function strafe() : void
      {
         if(heroView)
         {
            if(!heroView.canStrafe)
            {
               heroView.stopAny();
            }
            heroView.isMoving = 2;
         }
      }
      
      public function stay() : void
      {
         if(heroView)
         {
            heroView.pose();
         }
      }
      
      public function win() : int
      {
         if(heroView)
         {
            heroView.win();
            return heroView.getAnimationDuration(AnimationIdent.WIN);
         }
         return 1;
      }
      
      public function die(param1:Function = null) : int
      {
         if(heroView)
         {
            heroView.die();
            heroView.disableAndStopWhenCompleted();
            if(param1)
            {
               heroView.onDeath.add(param1);
            }
            return heroView.getAnimationDuration(AnimationIdent.DIE);
         }
         return 1;
      }
      
      public function hit() : void
      {
         if(heroView)
         {
            heroView.setAnimation(AnimationIdent.HURT);
         }
      }
      
      protected function onAssetLoaded(param1:HeroRsxAssetDisposable) : void
      {
         var _loc2_:* = null;
         if(!heroView)
         {
            heroView = new HeroView();
            addHero(heroView);
         }
         heroView.applyAsset(param1.getHeroData(1.42857142857143,prefix));
         heroView.globalPlaybackSpeed = _playbackSpeed;
         heroView.updatePosition();
         heroView.pose();
         if(scheduledAnimations.length > 0)
         {
            _loc2_ = scheduledAnimations.shift();
            heroView.setAnimation(_loc2_.ident,_loc2_.animationClipName);
         }
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(isPlaying)
         {
            _loc2_ = param1.data as Number;
            advanceHeroesTime(_loc2_);
            if(heroView)
            {
               heroView.updatePosition();
            }
         }
      }
      
      private function handler_disposeGraphics(param1:Event) : void
      {
         dispose();
      }
   }
}

import game.battle.view.hero.AnimationIdent;

class ScheduledAnimationIdent
{
    
   
   public var ident:AnimationIdent;
   
   public var animationClipName:String;
   
   function ScheduledAnimationIdent()
   {
      super();
   }
}
