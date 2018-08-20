package game.mechanics.titan_arena.popup.halloffame
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaHallOfFameTournamentRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_text:ClipLabel;
      
      public function TitanArenaHallOfFameTournamentRendererClip()
      {
         tf_text = new ClipLabel();
         super();
      }
   }
}
