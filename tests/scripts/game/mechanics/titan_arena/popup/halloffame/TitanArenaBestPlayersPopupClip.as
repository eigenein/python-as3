package game.mechanics.titan_arena.popup.halloffame
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArenaBestPlayersPopupClip extends PopupClipBase
   {
       
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function TitanArenaBestPlayersPopupClip()
      {
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
