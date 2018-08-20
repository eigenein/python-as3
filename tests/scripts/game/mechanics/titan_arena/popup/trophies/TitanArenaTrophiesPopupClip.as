package game.mechanics.titan_arena.popup.trophies
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArenaTrophiesPopupClip extends PopupClipBase
   {
       
      
      public var tf_empty:ClipLabel;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var tf_desc:ClipLabel;
      
      public var btn_tournament:ClipButtonLabeled;
      
      public var layout_desc:ClipLayout;
      
      public function TitanArenaTrophiesPopupClip()
      {
         tf_empty = new ClipLabel();
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         tf_desc = new ClipLabel(true);
         btn_tournament = new ClipButtonLabeled();
         layout_desc = ClipLayout.horizontalMiddleCentered(10,tf_desc,btn_tournament);
         super();
      }
   }
}
