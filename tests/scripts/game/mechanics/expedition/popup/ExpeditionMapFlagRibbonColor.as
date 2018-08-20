package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class ExpeditionMapFlagRibbonColor extends GuiClipNestedContainer
   {
       
      
      public var chest:GuiAnimation;
      
      public var inProgress:GuiAnimation;
      
      public var idle:GuiAnimation;
      
      public var frame:GuiClipScale3Image;
      
      public function ExpeditionMapFlagRibbonColor()
      {
         chest = new GuiAnimation();
         inProgress = new GuiAnimation();
         idle = new GuiAnimation();
         frame = new GuiClipScale3Image();
         super();
      }
      
      public function setStatus(param1:int) : void
      {
         playClip(chest,param1 == 1);
         playClip(inProgress,param1 == 2);
         playClip(idle,param1 == 3);
      }
      
      private function playClip(param1:GuiAnimation, param2:Boolean) : void
      {
         if(param2)
         {
            param1.graphics.visible = true;
            param1.play();
         }
         else
         {
            param1.graphics.visible = false;
            param1.stop();
         }
      }
   }
}
