package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import starling.core.Starling;
   
   public class BossChestPanelOpenedClip extends GuiClipNestedContainer
   {
       
      
      public var chest_start:GuiAnimation;
      
      public var chest_finish:GuiAnimation;
      
      public var current:Vector.<GuiAnimation>;
      
      public var opened:Vector.<GuiAnimation>;
      
      public function BossChestPanelOpenedClip()
      {
         super();
      }
      
      public function get animationAlpha() : Number
      {
         var _loc3_:int = 0;
         var _loc2_:* = current;
         for each(var _loc1_ in current)
         {
            return _loc1_.graphics.alpha;
         }
         return 0;
      }
      
      public function set animationAlpha(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = current;
         for each(var _loc2_ in current)
         {
            _loc2_.graphics.alpha = param1;
         }
      }
      
      public function setOpened() : void
      {
         var _loc1_:* = null;
         chest_start.graphics.visible = false;
         chest_finish.currentFrame = chest_finish.lastFrame;
         chest_finish.stop();
         var _loc3_:int = 0;
         var _loc2_:* = current;
         for each(_loc1_ in current)
         {
            _loc1_.graphics.visible = false;
         }
         var _loc5_:int = 0;
         var _loc4_:* = opened;
         for each(_loc1_ in opened)
         {
            _loc1_.graphics.visible = true;
         }
      }
      
      public function startOpenAnimation(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            chest_start.gotoAndPlay(35);
            chest_start.isLooping = false;
            chest_start.hideWhenCompleted = true;
         }
         else
         {
            chest_start.playOnceAndHide();
         }
         chest_start.signal_completed.addOnce(handler_chestStartCompleted);
         chest_finish.graphics.visible = false;
         var _loc4_:int = 0;
         var _loc3_:* = current;
         for each(_loc2_ in current)
         {
            _loc2_.graphics.visible = false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = opened;
         for each(_loc2_ in opened)
         {
            _loc2_.graphics.visible = false;
         }
      }
      
      private function handler_chestStartCompleted() : void
      {
         var _loc2_:* = null;
         chest_finish.graphics.visible = true;
         chest_finish.playOnce();
         var _loc4_:int = 0;
         var _loc3_:* = current;
         for each(_loc2_ in current)
         {
            _loc2_.graphics.visible = true;
         }
         var _loc6_:int = 0;
         var _loc5_:* = opened;
         for each(_loc2_ in opened)
         {
            _loc2_.graphics.visible = true;
         }
         var _loc1_:Number = chest_finish.lastFrame / 60 * chest_finish.playbackSpeed;
         animationAlpha = 1;
         Starling.juggler.tween(this,1.5,{
            "animationAlpha":0,
            "delay":_loc1_ + 1
         });
      }
   }
}
