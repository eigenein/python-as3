package game.view.popup.ny.sendgift
{
   import game.assets.storage.AssetStorage;
   import game.view.popup.friends.referrer.ReferrerPopupListItemRenderer;
   import game.view.popup.friends.referrer.ReferrerPopupListItemRendererClip;
   
   public class SelectFriendToSendNYGiftItemRenderer extends ReferrerPopupListItemRenderer
   {
       
      
      public function SelectFriendToSendNYGiftItemRenderer()
      {
         super();
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         .super.isSelected = param1;
         (clip as SelectFriendToSendNYGiftItemRendererClip).bg_selected.graphics.visible = param1;
         (clip as SelectFriendToSendNYGiftItemRendererClip).icon_check.graphics.visible = param1;
      }
      
      override protected function createClip() : ReferrerPopupListItemRendererClip
      {
         return AssetStorage.rsx.ny_gifts.create(SelectFriendToSendNYGiftItemRendererClip,"select_friend_to_send_gift_item_renderer");
      }
      
      override protected function handler_click() : void
      {
         super.handler_click();
         isSelected = true;
      }
   }
}
