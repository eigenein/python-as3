package game.view.popup.tower.screen
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class TowerScreenFloorClip extends GuiClipNestedContainer
   {
       
      
      public var tf_floor:SpecialClipLabel;
      
      public function TowerScreenFloorClip()
      {
         tf_floor = new SpecialClipLabel();
         super();
      }
   }
}
