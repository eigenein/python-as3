package game.battle.view.hero
{
   import engine.core.animation.DisposableAnimation;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.view.BattleScene;
   import game.battle.view.EffectGraphicsProvider;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class HeroView extends DisposableAnimation implements IAnimatable
   {
      
      private static var _point:Point = new Point();
      
      private static const _point0:Point = new Point();
       
      
      public const position:HeroViewPositionValue = new HeroViewPositionValue();
      
      public const transform:HeroViewTransformManager = new HeroViewTransformManager();
      
      public const statusBar:HeroStatusOverlay = new HeroStatusOverlay();
      
      protected var animation:HeroAnimationRsx;
      
      protected var animationController:HeroAnimationController;
      
      protected var _initialBounds:Rectangle;
      
      protected var _anchors:GameHeroViewAnchors;
      
      protected var particleEmitter:BattleAnimationParticleEmitter;
      
      protected var permanentFx:BattleHeroPermanentFx;
      
      public function HeroView()
      {
         _anchors = new GameHeroViewAnchors();
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(animationController)
         {
            animationController.dispose();
         }
         if(animation)
         {
            animation.dispose();
         }
         if(permanentFx)
         {
            permanentFx.dispose();
         }
         if(particleEmitter)
         {
            particleEmitter.dispose();
         }
         transform.removeFromParent();
      }
      
      private function disposeAnimation() : void
      {
         animationController.dispose();
         animation.dispose();
      }
      
      public function get initialBounds() : Rectangle
      {
         return _initialBounds;
      }
      
      public function get anchors() : GameHeroViewAnchors
      {
         _anchors.update(this);
         return _anchors;
      }
      
      public function get onDeath() : Signal
      {
         return animationController.onDeath;
      }
      
      public function get hpTextSpawnPosition() : Point
      {
         _point.x = 0;
         _point.y = -160;
         return _point;
      }
      
      public function get isAttacking() : Boolean
      {
         return animationController.attacking;
      }
      
      public function get canStrafe() : Boolean
      {
         return animationController.idlingOrMoving;
      }
      
      public function get isDying() : Boolean
      {
         return animationController.isDisabled;
      }
      
      public function set isMoving(param1:int) : void
      {
         if(animationController.moving != param1)
         {
            animationController.moving = param1;
         }
      }
      
      public function get direction() : int
      {
         return !!animation?animation.direction:1;
      }
      
      public function get signal_deathAnimationCompleted() : Signal
      {
         return animationController.onDeath;
      }
      
      public function set idlePlaybackSpeed(param1:Number) : void
      {
         if(animation)
         {
            animation.idlePlaybackSpeed = param1;
         }
      }
      
      public function set globalPlaybackSpeed(param1:Number) : void
      {
         if(animation)
         {
            animation.globalPlaybackSpeed = param1;
         }
      }
      
      public function get currentWeaponTransform() : Matrix
      {
         if(animation)
         {
            return animation.rootNode.weaponTransform.transform;
         }
         return null;
      }
      
      public function get viewTransform() : Matrix
      {
         return animation.transformationMatrix;
      }
      
      public function get assetIsMirrored() : Boolean
      {
         return animation.assetIsMirrored;
      }
      
      public function get assetPrefix() : String
      {
         return animation.assetPrefix;
      }
      
      public function addToParent(param1:DisplayObjectContainer, param2:HeroViewContainer = null) : void
      {
         transform.setParent(param1);
         if(particleEmitter && param2 is BattleScene)
         {
            particleEmitter.setScene(param2 as BattleScene);
         }
      }
      
      override public function advanceTime(param1:Number) : void
      {
         if(transform.parent)
         {
            animation.advanceTime(param1);
            if(permanentFx)
            {
               permanentFx.advanceTime(param1);
            }
            if(particleEmitter)
            {
               particleEmitter.doEmmit = position.visible;
               particleEmitter.advanceTime(param1);
            }
         }
         statusBar.advanceTime(param1);
      }
      
      public function updatePosition(param1:Point = null) : void
      {
         var _loc2_:Vector.<ZSortedSprite> = animation.rootNode.layerContainers;
         var _loc3_:int = _loc2_.length;
         if(param1 == null)
         {
            param1 = _point0;
         }
         statusBar.graphics.x = int(position.x + param1.x);
         statusBar.graphics.y = int(position.y + param1.y);
         transform.setPosition(position,param1);
         if(animationController)
         {
            if(animationController.moving != position.movement)
            {
               animationController.moving = position.movement;
            }
         }
      }
      
      public function setHp(param1:Number, param2:Number) : void
      {
         statusBar.setHpValue(param1,param2);
      }
      
      public function applyAsset(param1:HeroClipAssetDataProvider, param2:Boolean = false) : void
      {
         if(animation)
         {
            disposeAnimation();
         }
         animation = new HeroAnimationRsx(param1,param2);
         animation.runPlaybackSpeed = 1 / position.scale;
         transform.setAnimation(animation);
         animationController = new HeroAnimationController(animation);
         if(particleEmitter)
         {
            particleEmitter.dispose();
            particleEmitter = null;
         }
         if(BattleAnimationParticleEmitter.assetHasFx(param1))
         {
            particleEmitter = new BattleAnimationParticleEmitter(this,param1);
         }
         if(permanentFx)
         {
            permanentFx.dispose();
            permanentFx = null;
         }
         if(BattleHeroPermanentFx.assetHasFx(param1))
         {
            permanentFx = new BattleHeroPermanentFx(this,param1);
         }
         stay();
         updatePosition();
         animation.advanceTime(0);
         _initialBounds = animation.getStateBounds(AnimationIdent.IDLE).clone();
         _initialBounds.x = _initialBounds.x * param1.defaultScale;
         _initialBounds.y = _initialBounds.y * param1.defaultScale;
         _initialBounds.width = _initialBounds.width * param1.defaultScale;
         _initialBounds.height = _initialBounds.height * param1.defaultScale;
      }
      
      public function tweenEffectsAlpha(param1:Number) : void
      {
         transform.effectsAlpha = param1;
      }
      
      public function tweenShadowAlpha(param1:Number) : void
      {
         transform.shadowAlpha = param1;
      }
      
      public function say(param1:String) : void
      {
         statusBar.addSpeechText(param1);
      }
      
      public function setEffectsText(param1:String) : void
      {
         statusBar.setText(param1);
      }
      
      public function getMarkerPosition(param1:String, param2:Boolean = false) : Matrix
      {
         if(animation == null)
         {
            return null;
         }
         return animation.getMarkerPosition(transform.parent,param1,param2);
      }
      
      public function setMarker(param1:String, param2:DisplayObject) : void
      {
         return animation.setMarkerContent(param1,param2);
      }
      
      public function getAnimationDuration(param1:AnimationIdent) : Number
      {
         if(animation)
         {
            return animation.getAnimationDuration(param1);
         }
         return NaN;
      }
      
      public function stopOnFirstFrame(param1:AnimationIdent) : void
      {
         animation.setCurrentAnimation(param1,false);
         animation.advanceTime(0);
         animation.stop();
      }
      
      public function stopLoop() : void
      {
         animationController.stopActiveAnimationLoop();
      }
      
      public function stopAny() : void
      {
         animationController.stopAny();
      }
      
      public function createEffectGraphicsProvider(param1:String) : EffectGraphicsProvider
      {
         return animation.createEffectGraphicsProvider(param1);
      }
      
      public function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         animation.setWeaponRotation(param1,param2,param3,param4);
      }
      
      public function setAnimation(param1:AnimationIdent, param2:String = null) : void
      {
         if(param2 == null)
         {
            if(param1 == AnimationIdent.NONE || param1 == AnimationIdent.IDLE)
            {
               animationController.stopAny();
            }
            else
            {
               animationController.setActiveAnimation(param1);
            }
         }
         else
         {
            animationController.setCustomAnimation(param1,param2);
         }
      }
      
      public function stopAnimation(param1:AnimationIdent, param2:Boolean) : void
      {
         animationController.stopAnimation(param1,param2);
      }
      
      public function attack(param1:int) : void
      {
         animationController.setAttackAnimation(param1);
      }
      
      public function pose() : void
      {
         animationController.setActiveAnimation(AnimationIdent.POSE,true);
      }
      
      public function stay() : void
      {
         animationController.moving = 0;
      }
      
      public function win() : void
      {
         animationController.setActiveAnimation(AnimationIdent.WIN);
      }
      
      public function die() : void
      {
         animationController.setActiveAnimation(AnimationIdent.DIE);
      }
      
      public function disableAndStopWhenCompleted() : void
      {
         if(permanentFx)
         {
            permanentFx.dispose();
            permanentFx = null;
         }
         if(particleEmitter)
         {
            particleEmitter.dispose();
            particleEmitter = null;
         }
         statusBar.hide();
         animationController.disableAndStopWhenCompleted();
      }
   }
}
