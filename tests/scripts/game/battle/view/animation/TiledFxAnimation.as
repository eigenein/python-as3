package game.battle.view.animation
{
   import battle.proxy.ViewTransform;
   import battle.proxy.ViewTransformProvider;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import engine.core.animation.ZSortedSprite;
   import feathers.display.TiledImage;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.systems.IBattleDisposable;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class TiledFxAnimation implements IBattleFadableAnimation, IBattleDisposable
   {
       
      
      private var zContainer:ZSortedSprite;
      
      private var image:TiledImage;
      
      private var transformProvider:ViewTransformProvider;
      
      private var playingOnce:Boolean;
      
      private const _signal_dispose:Signal = new Signal();
      
      public function TiledFxAnimation(param1:EffectGraphicsProvider, param2:ViewTransformProvider, param3:BattleMediatorObjects, param4:BattleGraphicsMethodProvider)
      {
         super();
         this.transformProvider = param2;
         var _loc5_:ViewTransform = param2.getTransform();
         var _loc6_:Texture = ClipImageCache.getClipTexture(param1.front);
         var _loc7_:* = 1;
         zContainer = new ZSortedSprite();
         image = new TiledImage(_loc6_,_loc7_);
         image.transformationMatrix = _loc5_;
         playingOnce = param2.hasDefinedDuration();
         zContainer.addChild(image);
         param4.container.addChild(zContainer);
      }
      
      public function dispose() : void
      {
         if(!transformProvider)
         {
            return;
         }
         zContainer.removeFromParent(true);
         image.dispose();
         transformProvider = null;
         _signal_dispose.dispatch();
      }
      
      public function get signal_dispose() : Signal
      {
         return _signal_dispose;
      }
      
      public function set alpha(param1:Number) : void
      {
         image.alpha = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:ViewTransform = transformProvider.getTransform();
         if(!_loc2_)
         {
            dispose();
            return;
         }
         zContainer.z = _loc2_.tz;
         image.transformationMatrix = _loc2_;
      }
   }
}
