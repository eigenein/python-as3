package game.view.popup.player
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   
   public class LevelUpPopupMechanicsGroupClip extends GuiClipNestedContainer
   {
       
      
      public var layout_group:ClipLayout;
      
      public function LevelUpPopupMechanicsGroupClip()
      {
         layout_group = ClipLayout.horizontalMiddleCentered(10);
         super();
      }
   }
}
