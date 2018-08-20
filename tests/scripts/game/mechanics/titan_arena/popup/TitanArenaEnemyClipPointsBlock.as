package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaEnemyClipPointsBlock extends GuiClipNestedContainer
   {
       
      
      public var tf_points:ClipLabel;
      
      public var power_plate_inst0:GuiClipScale3Image;
      
      public function TitanArenaEnemyClipPointsBlock()
      {
         tf_points = new ClipLabel(true);
         power_plate_inst0 = new GuiClipScale3Image();
         super();
      }
   }
}
