package game.mechanics.expedition.popup
{
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   
   public class ExpeditionBriefingPopupClip extends PopupClipBase
   {
       
      
      public var item:ExpeditionBriefingPanelClip;
      
      public var hero_position_after:GuiClipContainer;
      
      public var skin_bg:GuiClipContainer;
      
      public function ExpeditionBriefingPopupClip()
      {
         item = new ExpeditionBriefingPanelClip();
         hero_position_after = new GuiClipContainer();
         skin_bg = new GuiClipContainer();
         super();
      }
   }
}
