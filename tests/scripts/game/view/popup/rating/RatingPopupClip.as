package game.view.popup.rating
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class RatingPopupClip extends PopupClipBase
   {
       
      
      public var delta:RatingPopupPlayerDeltaClip;
      
      public var item_self:RatingPopupListItemRendererPlayerClip;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var layout_tabs:ClipLayout;
      
      public function RatingPopupClip()
      {
         delta = new RatingPopupPlayerDeltaClip();
         item_self = new RatingPopupListItemRendererPlayerClip();
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
   }
}
