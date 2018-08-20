package game.view.popup.ny.gifts
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYGiftsPopupClip extends PopupClipBase
   {
       
      
      public var tabs_list_container:ClipLayout;
      
      public var content_container:GuiClipLayoutContainer;
      
      public function NYGiftsPopupClip()
      {
         tabs_list_container = ClipLayout.horizontalCentered(0);
         content_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
