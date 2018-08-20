package game.battle.controller.entities
{
   import battle.objects.BattleEntity;
   import battle.proxy.IEffectProxy;
   import battle.proxy.ViewTransform;
   import battle.skills.Effect;
   import com.progrestar.framework.ares.core.Clip;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.gui.BattleHpBarClip;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.EffectAnimationSet;
   import game.battle.view.animation.IBattleFadableAnimation;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   
   public class BattleEffect implements IBattleEntityMediator, IEffectProxy, IBattleFadableAnimation, IBattleDisposable
   {
       
      
      private var graphics:BattleGraphicsMethodProvider;
      
      private var objects:BattleMediatorObjects;
      
      private var hero:BattleHero;
      
      private var effect:Effect;
      
      private var bar:BattleHpBarClip;
      
      private var transform:ViewTransform;
      
      private var customTransformProvider:Boolean = false;
      
      private var _addedOnStart:Boolean;
      
      private var mainAsset:EffectGraphicsProvider;
      
      private var onceAnimationTimeLeft:Number;
      
      protected var _view:EffectAnimationSet;
      
      protected var fadeAwaySpeed:Number = 0;
      
      public const _signal_dispose:Signal = new Signal();
      
      public function BattleEffect(param1:BattleMediatorObjects, param2:BattleGraphicsMethodProvider, param3:EffectGraphicsProvider)
      {
         _view = new EffectAnimationSet();
         super();
         this.objects = param1;
         this.graphics = param2;
         mainAsset = param3;
      }
      
      public static function hasProgressBar(param1:Effect) : Boolean
      {
         try
         {
            param1.execution.getVisibleProgress;
            if(param1.execution.getVisibleProgress)
            {
               var _loc3_:Boolean = true;
               return _loc3_;
            }
         }
         catch(e:*)
         {
         }
         return false;
      }
      
      public static function hasVisibleRepresentation(param1:Effect, param2:EffectGraphicsProvider) : Boolean
      {
         if(param2 != EffectGraphicsProvider.MISSING || hasProgressBar(param1))
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         if(bar)
         {
            hero.view.statusBar.removeBar(bar);
            bar.dispose();
            bar = null;
         }
         _signal_dispose.dispatch();
      }
      
      public function get signal_dispose() : Signal
      {
         return _signal_dispose;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(_addedOnStart)
         {
            return;
         }
         if(_view)
         {
            _view.alpha = param1;
         }
         if(bar)
         {
            bar.alpha = param1;
         }
      }
      
      public function get fxProvider() : EffectGraphicsProvider
      {
         return mainAsset;
      }
      
      public function setEntity(param1:BattleEntity) : void
      {
         this.effect = param1 as Effect;
         this.hero = objects.entities.getHero(effect.target);
         effect.viewProxy = this;
         _addedOnStart = param1.timeline.time == 0;
         if(hasProgressBar(effect))
         {
            createBar();
         }
         try
         {
            if(effect.execution.getViewTransform != null)
            {
               transform = effect.execution.getViewTransform(effect);
               customTransformProvider = true;
            }
         }
         catch(e:*)
         {
            transform = new ViewTransform();
            customTransformProvider = false;
         }
         if(fxProvider != EffectGraphicsProvider.MISSING)
         {
            if(fxProvider.front || fxProvider.back || fxProvider.container || fxProvider.displacement)
            {
               setAnimation(fxProvider);
            }
         }
         if(fxProvider.status)
         {
            hero.view.statusBar.addEffect(this);
         }
      }
      
      public function removeEntity() : void
      {
         dispose();
      }
      
      public function switchAsset(param1:String) : void
      {
         var _loc2_:* = null;
         if(_view)
         {
            _loc2_ = graphics.getFxAsset(param1,effect,mainAsset.defaultScale);
            mainAsset = _loc2_;
            setAnimation(_loc2_);
            onceAnimationTimeLeft = NaN;
         }
      }
      
      public function playOnce(param1:String) : void
      {
         var _loc2_:* = null;
         if(_view)
         {
            _loc2_ = graphics.getFxAsset(param1,effect,mainAsset.defaultScale);
            setAnimation(_loc2_);
            onceAnimationTimeLeft = _view.duration;
            _view.setTime(0);
         }
      }
      
      public function setTime(param1:Number) : void
      {
         if(_view)
         {
            _view.setTime(0);
         }
      }
      
      public function fadeAway(param1:Number = 1) : void
      {
         fadeAwaySpeed = 1 / param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(_view)
         {
            if(customTransformProvider || effect.keepHeroDirection)
            {
               _view.setTransform(getTransform());
            }
            _view.advanceTime(param1);
            onceAnimationTimeLeft = onceAnimationTimeLeft - param1;
            if(onceAnimationTimeLeft <= 0)
            {
               setAnimation(mainAsset);
               onceAnimationTimeLeft = NaN;
            }
         }
         if(bar)
         {
            bar.setValue(effect.execution.getVisibleProgress(),1);
         }
      }
      
      protected function setAnimation(param1:EffectGraphicsProvider) : void
      {
         if(param1 == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         _view.setGraphics(param1);
         if(customTransformProvider || effect.keepHeroDirection)
         {
            _view.setTransform(getTransform());
         }
         _view.targetHero = hero.view;
         if(_view.displacementAnimation)
         {
            graphics.addDisplacement(_view.displacementAnimation);
         }
      }
      
      protected function createBar() : void
      {
         bar = AssetStorage.rsx.battle_interface.create_battleBarYellow();
         bar.defineMaxValue(1);
         bar.x = -(int(bar.width * 0.5));
         hero.view.statusBar.addBar(bar);
      }
      
      protected function getTransform() : ViewTransform
      {
         if(customTransformProvider)
         {
            transform = effect.execution.getViewTransform(effect);
         }
         else if(effect.keepHeroDirection)
         {
            if(transform == null)
            {
               transform = new ViewTransform();
            }
            transform.a = hero.hero.getVisualDirection();
         }
         return transform;
      }
   }
}
