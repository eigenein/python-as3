package game.battle.view.animation
{
   import battle.proxy.ViewTransform;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.animation.DisposableAnimation;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.hero.HeroView;
   
   public class EffectAnimationSet extends DisposableAnimation
   {
      
      private static var concatTemporaryMatrix:ViewTransform = new ViewTransform();
       
      
      private var defaultTransform:Matrix;
      
      private var transform:ViewTransform;
      
      private var _targetHero:HeroView;
      
      private var back:BattleFx;
      
      private var front:BattleFx;
      
      private var displacement:BattleFx;
      
      private var container:ContainerBattleFx;
      
      public function EffectAnimationSet()
      {
         transform = new ViewTransform();
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(front)
         {
            front.dispose();
         }
         if(back)
         {
            back.dispose();
         }
         if(displacement)
         {
            displacement.dispose();
         }
         if(container)
         {
            container.dispose();
         }
      }
      
      override public function get completed() : Boolean
      {
         if(back && !back.completed)
         {
            return false;
         }
         if(front && !front.completed)
         {
            return false;
         }
         if(displacement && !displacement.completed)
         {
            return false;
         }
         if(container && !container.completed)
         {
            return false;
         }
         return true;
      }
      
      public function get frontAnimation() : BattleFx
      {
         return front;
      }
      
      public function get backAnimation() : BattleFx
      {
         return back;
      }
      
      public function get displacementAnimation() : BattleFx
      {
         return displacement;
      }
      
      public function get duration() : Number
      {
         var _loc1_:* = 0;
         if(back && back.length > _loc1_)
         {
            _loc1_ = Number(back.length);
         }
         if(front && front.length > _loc1_)
         {
            _loc1_ = Number(front.length);
         }
         if(displacement && displacement.length > _loc1_)
         {
            _loc1_ = Number(displacement.length);
         }
         if(container && container.length > _loc1_)
         {
            _loc1_ = Number(container.length);
         }
         return _loc1_ / 60;
      }
      
      public function set targetSpace(param1:ZSortedSprite) : void
      {
         if(front)
         {
            front.targetSpace = param1;
         }
         if(back)
         {
            back.targetSpace = param1;
         }
      }
      
      public function set targetHero(param1:HeroView) : void
      {
         _targetHero = param1;
         if(front)
         {
            front.targetHero = param1;
            front.selfOffsetZ = _targetHero.position.size + 1;
         }
         if(back)
         {
            back.targetHero = param1;
            back.selfOffsetZ = -_targetHero.position.size - 1;
         }
         if(displacement)
         {
            displacement.targetHero = param1;
            displacement.selfOffsetZ = -_targetHero.position.size - 1;
         }
         if(container)
         {
            container.targetHero = param1;
         }
      }
      
      public function set alpha(param1:Number) : void
      {
         if(front)
         {
            front.alpha = param1;
         }
         if(back)
         {
            back.alpha = param1;
         }
      }
      
      public function get alpha() : Number
      {
         if(front)
         {
            return front.alpha;
         }
         if(back)
         {
            return back.alpha;
         }
         return 1;
      }
      
      public function setTime(param1:Number) : void
      {
         if(back)
         {
            back.setFrame(param1 * 60);
         }
         if(front)
         {
            front.setFrame(param1 * 60);
         }
         if(displacement)
         {
            displacement.setFrame(param1 * 60);
         }
         if(container)
         {
            container.setFrame(param1 * 60);
         }
      }
      
      public function setGraphics(param1:EffectGraphicsProvider) : void
      {
         defaultTransform = param1.transform;
         transform.copyFrom(defaultTransform);
         var _loc2_:ClipAssetDataProvider = param1.clipAssetDataProvider;
         var _loc3_:Clip = param1.front;
         if(front)
         {
            front.skin = param1.createFrontSkin();
            front.assetTransform = param1.transform;
            if(param1.frontLoop)
            {
               front.loop = param1.frontLoop;
            }
         }
         else if(_loc3_)
         {
            if(_targetHero)
            {
               front = new BattleFx(false,_targetHero.position.size + 1);
            }
            else
            {
               front = new BattleFx(false,0);
            }
            front.skin = param1.createFrontSkin();
            front.assetTransform = param1.transform;
            if(param1.frontLoop)
            {
               front.loop = param1.frontLoop;
            }
         }
         _loc3_ = param1.back;
         if(back)
         {
            back.skin = param1.createBackSkin();
            back.assetTransform = param1.transform;
            if(param1.backLoop)
            {
               back.loop = param1.backLoop;
            }
         }
         else if(_loc3_)
         {
            if(_targetHero)
            {
               back = new BattleFx(false,-_targetHero.position.size - 1);
            }
            else
            {
               back = new BattleFx(false,-1);
            }
            back.skin = param1.createBackSkin();
            back.assetTransform = param1.transform;
            if(param1.backLoop)
            {
               back.loop = param1.backLoop;
            }
         }
         _loc3_ = param1.container;
         if(container)
         {
            container.clip = _loc3_;
            container.assetTransform = param1.transform;
            if(param1.containerLoop)
            {
               container.loop = param1.containerLoop;
            }
         }
         else if(_loc3_)
         {
            container = new ContainerBattleFx(false,5);
            container.clip = _loc3_;
            container.assetTransform = transform;
            if(param1.containerLoop)
            {
               container.loop = param1.containerLoop;
            }
         }
         _loc3_ = param1.displacement;
         if(displacement)
         {
            displacement.skin = new ClipSkin(_loc3_,_loc2_);
            displacement.assetTransform = param1.transform;
            if(param1.displacementLoop)
            {
               displacement.loop = param1.displacementLoop;
            }
         }
         else if(_loc3_)
         {
            if(_targetHero)
            {
               displacement = new BattleFx(false,-_targetHero.position.size - 1);
            }
            else
            {
               displacement = new BattleFx(false,-1);
            }
            displacement.skin = new ClipSkin(_loc3_,_loc2_);
            displacement.assetTransform = param1.transform;
            if(param1.displacementLoop)
            {
               displacement.loop = param1.displacementLoop;
            }
         }
      }
      
      public function setTransform(param1:ViewTransform) : void
      {
         if(front)
         {
            front.selfTransform = param1;
         }
         if(back)
         {
            back.selfTransform = param1;
         }
         if(displacement)
         {
            displacement.selfTransform = param1;
         }
         if(container)
         {
            container.selfTransform = transform;
         }
      }
      
      override public function advanceTime(param1:Number) : void
      {
         if(front)
         {
            front.advanceTime(param1);
         }
         if(back)
         {
            back.advanceTime(param1);
         }
         if(displacement)
         {
            displacement.advanceTime(param1);
         }
         if(container)
         {
            container.advanceTime(param1);
         }
      }
   }
}
