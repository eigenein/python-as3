package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class DungeonSaveLeverOverlayButton extends GuiClipNestedContainer
   {
       
      
      public var tf_to_battle:ClipLabel;
      
      public var bg:ClipSprite;
      
      public function DungeonSaveLeverOverlayButton()
      {
         tf_to_battle = new ClipLabel();
         bg = new ClipSprite();
         super();
      }
   }
}
