package game.view.popup.arena.rules
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ArenaRulesPlaceClip extends GuiClipNestedContainer
   {
       
      
      public var tf_place:ClipLabel;
      
      public function ArenaRulesPlaceClip()
      {
         tf_place = new ClipLabel();
         super();
      }
   }
}
