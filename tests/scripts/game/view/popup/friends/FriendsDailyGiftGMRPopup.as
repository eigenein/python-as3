package game.view.popup.friends
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.FriendsDailyGiftGMRPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class FriendsDailyGiftGMRPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:FriendsDailyGiftGMRPopupMediator;
      
      private var clip:FriendsDailyGiftGMRPopupClip;
      
      public function FriendsDailyGiftGMRPopup(param1:FriendsDailyGiftGMRPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "friends";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_friend_gifts_gmr();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_FRIENDS_GIFT_GMR_TITLE");
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_GMR_DESC");
         clip.button_shop.label = Translate.translate("UI_DIALOG_FRIEND_GIFTS_SHOP");
         clip.button_shop.signal_click.add(handler_shop);
         clip.tf_task_complete.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_GMR_TASK_COMPLETE");
         clip.button_send_gifts.label = Translate.translate("UI_DIALOG_FRIEND_GIFTS_GMR_RECEIVE_COINS");
         clip.button_send_gifts.signal_click.add(handler_send);
         updateState(mediator.taskComplete);
      }
      
      private function updateState(param1:Boolean = false) : void
      {
         clip.layout_task_complete.visible = param1;
         clip.button_send_gifts.graphics.visible = !clip.layout_task_complete.visible;
      }
      
      private function handler_send() : void
      {
         mediator.action_sendGifts_requestsFirst();
         updateState(true);
      }
      
      private function handler_shop() : void
      {
         mediator.action_openShop();
      }
   }
}
