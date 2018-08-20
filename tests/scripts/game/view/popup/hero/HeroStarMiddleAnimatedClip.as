package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import starling.events.Event;
   
   public class HeroStarMiddleAnimatedClip extends GuiClipNestedContainer
   {
       
      
      private var timeoutId:uint;
      
      public var animation:GuiAnimation;
      
      private var _animationInterval:int = 6000;
      
      public function HeroStarMiddleAnimatedClip()
      {
         animation = new GuiAnimation();
         super();
      }
      
      public function dispose() : void
      {
         if(container)
         {
            container.removeEventListener("addedToStage",onAddedToStage);
            container.removeEventListener("removedFromStage",onRemoveFromStage);
            animation.dispose();
         }
      }
      
      public function get animationInterval() : int
      {
         return _animationInterval;
      }
      
      public function set animationInterval(param1:int) : void
      {
         if(param1 > 0)
         {
            _animationInterval = param1;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation.stop();
         var _loc2_:* = 0.3;
         _animationInterval = _animationInterval * _loc2_ + Math.random() * _animationInterval * (1 - _loc2_);
         _playOnce();
         container.addEventListener("addedToStage",onAddedToStage);
         container.addEventListener("removedFromStage",onRemoveFromStage);
      }
      
      private function _playOnce() : void
      {
         if(animation && animation.graphics)
         {
            if(!animation.isPlaying)
            {
               animation.playOnce();
            }
            clearTimeout(timeoutId);
            timeoutId = setTimeout(_playOnce,_animationInterval);
         }
      }
      
      private function onRemoveFromStage(param1:Event) : void
      {
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         _playOnce();
      }
   }
}
