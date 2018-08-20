package game.view.popup.ny.notenoughcoin
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.ny.treeupgrade.NYFireworksRendederClip;
   import game.view.popup.ny.treeupgrade.NYTreeDecorateRendederClip;
   
   public class NotEnoughNYGiftCoinPopupClip extends PopupClipBase
   {
       
      
      public var tf_title:ClipLabel;
      
      public var decorate_renderer_1:NYTreeDecorateRendederClip;
      
      public var decorate_renderer_2:NYTreeDecorateRendederClip;
      
      public var decorate_renderer_3:NYFireworksRendederClip;
      
      public function NotEnoughNYGiftCoinPopupClip()
      {
         decorate_renderer_1 = new NYTreeDecorateRendederClip();
         decorate_renderer_2 = new NYTreeDecorateRendederClip();
         decorate_renderer_3 = new NYFireworksRendederClip();
         super();
      }
   }
}
