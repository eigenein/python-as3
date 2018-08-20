package game.view.popup.titanarena
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArenaRulesPopupClip extends PopupClipBase
   {
       
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var layout_tabs:ClipLayout;
      
      public function TitanArenaRulesPopupClip()
      {
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
   }
}
