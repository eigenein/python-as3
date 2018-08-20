package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Matrix;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import game.assets.storage.AssetStorage;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class HeroElementPopupCircleClip extends GuiClipNestedContainer
   {
       
      
      private var disposed:Boolean = false;
      
      private var interval:int;
      
      private var currentLevel:int;
      
      private var spinController:HeroElementPopupCircleSpinController;
      
      private var circleContainerX0:Number = NaN;
      
      private var circleContainerY0:Number = NaN;
      
      public var t:Vector.<ClipSprite>;
      
      public var fx:Vector.<GuiAnimation>;
      
      public var circleMc:HeroElementPopupCircleAnimationClip;
      
      public function HeroElementPopupCircleClip()
      {
         t = new Vector.<ClipSprite>();
         fx = new Vector.<GuiAnimation>();
         circleMc = new HeroElementPopupCircleAnimationClip();
         super();
      }
      
      public function dispose() : void
      {
         disposed = true;
         Starling.juggler.removeTweens(circleTweenableDisplayObject);
         clearInterval(interval);
         if(spinController)
         {
            spinController.dispose();
         }
      }
      
      protected function get circleTweenableDisplayObject() : DisplayObject
      {
         return graphics.parent;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         clearInterval(interval);
         interval = setInterval(playFxAnimation,int(2000 + Math.random() * 3000));
         _loc2_ = 0;
         while(_loc2_ < t.length)
         {
            fx[_loc2_].stop();
            _loc2_++;
         }
         spinController = new HeroElementPopupCircleSpinController();
         spinController.start(circleMc);
      }
      
      public function setLevel(param1:int) : void
      {
         var _loc2_:int = 0;
         currentLevel = param1;
         _loc2_ = 0;
         while(_loc2_ < t.length)
         {
            t[_loc2_].graphics.visible = _loc2_ < param1;
            fx[_loc2_].graphics.visible = _loc2_ < param1;
            _loc2_++;
         }
      }
      
      public function showInsertAnimation() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(disposed)
         {
            return;
         }
         if(currentLevel > 0 && currentLevel <= t.length)
         {
            _loc1_ = t[currentLevel - 1];
            if(_loc1_)
            {
               _loc3_ = AssetStorage.rsx.asset_clan_circle.create(GuiAnimation,"animation_insert");
               _loc3_.playOnceAndHide();
               container.parent.parent.addChild(_loc3_.container);
               _loc2_ = _loc1_.container.transformationMatrix.clone();
               _loc2_.concat(container.parent.transformationMatrix);
               _loc3_.container.transformationMatrix = _loc2_;
            }
            Starling.juggler.delayCall(showInsertCompleteAnimation,2.25,currentLevel);
            Starling.juggler.delayCall(pushTheCircle,0.933333333333333);
            spinController.addSpin();
         }
      }
      
      public function pushTheCircle() : void
      {
         if(disposed)
         {
            return;
         }
         var _loc1_:DisplayObject = circleTweenableDisplayObject;
         var _loc3_:Number = _loc1_.scaleX - 0.01;
         if(circleContainerX0 !== circleContainerX0)
         {
            circleContainerX0 = _loc1_.x;
            circleContainerY0 = _loc1_.y;
         }
         var _loc2_:Number = circleContainerX0 + _loc1_.width * (1 - _loc3_) * 0.5;
         var _loc4_:Number = circleContainerY0 + _loc1_.height * (1 - _loc3_) * 0.5;
         _loc1_.scaleX = _loc3_;
         _loc1_.scaleY = _loc3_;
         _loc1_.x = _loc2_;
         _loc1_.y = _loc4_;
         Starling.juggler.tween(_loc1_,1.1,{
            "x":circleContainerX0,
            "y":circleContainerY0,
            "scaleX":1,
            "scaleY":1,
            "transition":"easeInOutBack"
         });
      }
      
      public function showInsertCompleteAnimation(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(disposed)
         {
            return;
         }
         if(param1 > 0 && param1 <= t.length)
         {
            _loc2_ = t[param1 - 1];
            if(_loc2_)
            {
               _loc4_ = AssetStorage.rsx.asset_clan_circle.create(GuiAnimation,"animation_after_insert");
               _loc4_.playOnceAndHide();
               container.parent.parent.addChild(_loc4_.container);
               _loc3_ = _loc2_.graphics.transformationMatrix.clone();
               if(param1 % 2 == 0)
               {
                  _loc3_.a = _loc3_.a * -1;
                  _loc3_.b = _loc3_.b * -1;
                  _loc3_.c = _loc3_.c * -1;
                  _loc3_.d = _loc3_.d * -1;
               }
               _loc3_.tx = 194;
               _loc3_.ty = 194;
               _loc3_.concat(container.parent.transformationMatrix);
               _loc4_.graphics.transformationMatrix = _loc3_;
            }
         }
      }
      
      public function playFxAnimation() : void
      {
         var _loc1_:int = 0;
         clearInterval(interval);
         interval = setInterval(playFxAnimation,int(2000 + Math.random() * 3000));
         if(currentLevel > 0)
         {
            _loc1_ = Math.round(Math.random() * (currentLevel - 1));
            if(fx[_loc1_])
            {
               fx[_loc1_].playOnce();
            }
         }
      }
   }
}
