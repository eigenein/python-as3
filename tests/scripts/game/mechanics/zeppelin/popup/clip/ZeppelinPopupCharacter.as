package game.mechanics.zeppelin.popup.clip
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class ZeppelinPopupCharacter extends GuiClipNestedContainer
   {
       
      
      private var interval:uint;
      
      public var anim:Vector.<GuiAnimation>;
      
      public function ZeppelinPopupCharacter()
      {
         anim = new Vector.<GuiAnimation>();
         super();
      }
      
      public function dispose() : void
      {
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         playIdle();
         interval = setInterval(playRandomAnimation,5000);
      }
      
      public function playRandomAnimation() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = anim.length;
         var _loc2_:int = 1 + Math.round(Math.random() * (_loc1_ - 2));
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_loc3_ != _loc2_)
            {
               anim[_loc3_].stop();
               anim[_loc3_].graphics.visible = false;
               anim[_loc3_].signal_completed.remove(handler_randomAnimComplete);
            }
            else
            {
               anim[_loc3_].playOnce();
               anim[_loc3_].signal_completed.add(handler_randomAnimComplete);
               anim[_loc3_].graphics.visible = true;
            }
            _loc3_++;
         }
      }
      
      public function playIdle() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = anim.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ > 0)
            {
               anim[_loc2_].stop();
               anim[_loc2_].graphics.visible = false;
            }
            else
            {
               anim[_loc2_].gotoAndPlay(1);
               anim[_loc2_].graphics.visible = true;
            }
            _loc2_++;
         }
      }
      
      private function handler_randomAnimComplete() : void
      {
         playIdle();
      }
   }
}
