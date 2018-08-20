package game.mechanics.titan_arena.popup.halloffame
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArenaHallOfFamePopupClip extends PopupClipBase
   {
       
      
      public var btn_cups:ClipButtonLabeled;
      
      public var btn_rules:ClipButtonLabeled;
      
      public var tf_loading:ClipLabel;
      
      public var arrow_left:ClipButton;
      
      public var arrow_right:ClipButton;
      
      public var top_list_container:ClipLayout;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function TitanArenaHallOfFamePopupClip()
      {
         btn_cups = new ClipButtonLabeled();
         btn_rules = new ClipButtonLabeled();
         tf_loading = new ClipLabel();
         arrow_left = new ClipButton();
         arrow_right = new ClipButton();
         top_list_container = ClipLayout.vertical(0);
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
