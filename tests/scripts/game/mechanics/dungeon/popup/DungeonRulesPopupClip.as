package game.mechanics.dungeon.popup
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class DungeonRulesPopupClip extends PopupClipBase
   {
       
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var scroll_content:DungeonRulesContentClip;
      
      public function DungeonRulesPopupClip()
      {
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = ClipLayout.vertical(4);
         scroll_slider_container = new GuiClipLayoutContainer();
         scroll_content = new DungeonRulesContentClip();
         super();
      }
   }
}
