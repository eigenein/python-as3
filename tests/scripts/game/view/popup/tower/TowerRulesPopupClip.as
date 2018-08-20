package game.view.popup.tower
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.arena.rules.ArenaRulesContentClip;
   
   public class TowerRulesPopupClip extends PopupClipBase
   {
       
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var scroll_content:ArenaRulesContentClip;
      
      public function TowerRulesPopupClip()
      {
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         scroll_content = new ArenaRulesContentClip();
         super();
      }
   }
}
