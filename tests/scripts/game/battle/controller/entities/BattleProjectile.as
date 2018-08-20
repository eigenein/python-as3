package game.battle.controller.entities
{
   import battle.data.BattleHeroDescription;
   import battle.objects.BattleEntity;
   import battle.objects.ProjectileEntity;
   import battle.proxy.IProjectileProxy;
   import battle.proxy.ViewPosition;
   import battle.proxy.ViewTransform;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.animation.ZSortedSprite;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.position.BattleProjectilePosition;
   import game.battle.controller.position.BattleStraightProjectilePosition;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.BattleFx;
   import game.battle.view.animation.EffectAnimationSet;
   import game.battle.view.animation.IBattleFadableAnimation;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   
   public class BattleProjectile implements IBattleEntityMediator, IProjectileProxy, IBattleFadableAnimation, IBattleDisposable
   {
      
      private static var transform:ViewTransform = new ViewTransform();
       
      
      public const graphics:ZSortedSprite = new ZSortedSprite();
      
      private const animation:EffectAnimationSet = new EffectAnimationSet();
      
      protected var visualPosition:BattleStraightProjectilePosition;
      
      private var projectile:ProjectileEntity;
      
      private var movement:ProjectileMovementIdent;
      
      private var graphicsMethodProvider:BattleGraphicsMethodProvider;
      
      private var fxProvider:EffectGraphicsProvider;
      
      private const _signal_dispose:Signal = new Signal();
      
      public function BattleProjectile(param1:BattleGraphicsMethodProvider, param2:BattleMediatorObjects, param3:ProjectileMovementIdent)
      {
         super();
         this.movement = param3;
         this.graphicsMethodProvider = param1;
         visualPosition = param3 == ProjectileMovementIdent.DEFAULT?new BattleProjectilePosition(param2):new BattleStraightProjectilePosition(param2);
      }
      
      public function dispose() : void
      {
         animation.dispose();
         _signal_dispose.dispatch();
      }
      
      public function get signal_dispose() : Signal
      {
         return _signal_dispose;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(animation)
         {
            animation.alpha = param1;
         }
      }
      
      public function get currentTransform() : ViewTransform
      {
         actualizeTransform();
         return transform.cloneViewTransform();
      }
      
      public function get z() : Number
      {
         return graphics.z;
      }
      
      public function setEntity(param1:BattleEntity) : void
      {
         subscribe(param1 as ProjectileEntity);
      }
      
      public function removeEntity() : void
      {
         dispose();
      }
      
      public function init(param1:EffectGraphicsProvider) : void
      {
         animation.setGraphics(param1);
         animation.targetSpace = graphics;
         this.fxProvider = param1;
         projectile.viewProxy = this;
      }
      
      public function projectileHit() : void
      {
         var _loc1_:* = null;
         if(fxProvider.hit)
         {
            actualizeTransform();
            _loc1_ = new BattleFx(true,transform.tz);
            _loc1_.skin = new ClipSkin(fxProvider.hit,fxProvider.clipAssetDataProvider);
            _loc1_.assetTransform = fxProvider.transform;
            _loc1_.selfTransform = transform;
            graphicsMethodProvider.addFx(_loc1_,projectile.skillCast.skill);
            _loc1_.targetSpace = graphics;
            graphics.z = graphics.z + 30;
         }
         visualPosition.dropTarget();
      }
      
      public function switchAsset(param1:EffectAnimationIdent) : void
      {
         var _loc3_:BattleHeroDescription = projectile.skillCast.skill.hero;
         var _loc4_:int = projectile.skillCast.skill.tier;
         var _loc2_:EffectGraphicsProvider = graphicsMethodProvider.getHeroEffect(_loc4_,param1.name,_loc3_);
         animation.setGraphics(_loc2_);
      }
      
      public function getViewPosition() : ViewPosition
      {
         return visualPosition;
      }
      
      public function advanceTime(param1:Number) : void
      {
         visualPosition.advanceTime(param1);
         actualizeTransform();
         animation.setTransform(transform);
         animation.advanceTime(param1);
      }
      
      protected function onMovementChangedListener() : void
      {
      }
      
      protected function actualizeTransform() : void
      {
         transform.identity();
         if(movement == ProjectileMovementIdent.NO_ROTATION)
         {
            transform.a = projectile.body.vx > 0?1:-1;
            transform.b = 0;
            transform.c = 0;
            transform.d = 1;
         }
         else if(movement != ProjectileMovementIdent.NO_TRANSFORM)
         {
            if(projectile.body.vx > 0)
            {
               transform.rotate(visualPosition.angle);
            }
            else
            {
               transform.rotate(3.14159265358979 - visualPosition.angle);
               transform.a = -transform.a;
               transform.c = -transform.c;
            }
         }
         transform.tx = visualPosition.x;
         transform.ty = visualPosition.y;
         if(visualPosition.z != visualPosition.z)
         {
            graphics.z = 0;
         }
         else
         {
            graphics.z = visualPosition.z;
         }
      }
      
      private function subscribe(param1:ProjectileEntity) : void
      {
         this.projectile = param1;
         visualPosition.init(param1);
      }
   }
}
