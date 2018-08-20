package game.view.popup.ny.giftinfo
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class NYGiftWithSkinInfoPopupClip extends PopupClipBase
   {
       
      
      public var tf_skin_title:ClipLabel;
      
      public var tf_skin_desc:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var list_container:ClipLayout;
      
      public var skin_:Vector.<NYGiftSkinItemRenderer>;
      
      public function NYGiftWithSkinInfoPopupClip()
      {
         tf_skin_title = new ClipLabel();
         tf_skin_desc = new ClipLabel();
         tf_desc = new ClipLabel();
         list_container = ClipLayout.horizontalCentered(0);
         skin_ = new Vector.<NYGiftSkinItemRenderer>();
         super();
      }
   }
}
