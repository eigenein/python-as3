package game.view.popup.friends
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.FriendsDailyGiftPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import starling.events.Event;
   
   public class FriendsDailyGiftPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:FriendsDailyGiftPopupMediator;
      
      private var clip:FriendsDailyGiftPopupClip;
      
      public function FriendsDailyGiftPopup(param1:FriendsDailyGiftPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "friends";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_friend_gifts();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_FRIENDS_GIFT_TITLE");
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_caption.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_CAPTION");
         clip.tf_caption_2.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_CAPTION_2");
         clip.button_invite.label = Translate.translate("UI_DIALOG_FRIEND_GIFTS_INVITE");
         clip.button_invite_alt.label = Translate.translate("UI_DIALOG_FRIEND_GIFTS_INVITE");
         clip.button_shop.label = Translate.translate("UI_DIALOG_FRIEND_GIFTS_SHOP");
         clip.button_invite_alt.signal_click.add(handler_invite);
         clip.button_invite.signal_click.add(handler_invite);
         clip.button_shop.signal_click.add(handler_shop);
         clip.button_send_gifts.signal_click.add(handler_send);
         updateFriendList();
      }
      
      private function updateFriendList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         clip.tf_no_friends.visible = false;
         var _loc4_:Vector.<FriendDataProvider> = null;
         if(mediator.appFriendList.length)
         {
            clip.button_invite_alt.graphics.visible = false;
            var _loc5_:Boolean = true;
            clip.button_invite.graphics.visible = _loc5_;
            clip.button_send_gifts.graphics.visible = _loc5_;
            clip.tf_caption.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_CAPTION");
            _loc4_ = mediator.appFriendList;
         }
         else if(mediator.notAppFriendList.length)
         {
            clip.button_invite_alt.graphics.visible = true;
            _loc5_ = false;
            clip.button_invite.graphics.visible = _loc5_;
            clip.button_send_gifts.graphics.visible = _loc5_;
            clip.tf_caption.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_NO_FRIENDS");
            _loc4_ = mediator.notAppFriendList;
         }
         else
         {
            clip.button_invite_alt.graphics.visible = true;
            _loc5_ = false;
            clip.button_invite.graphics.visible = _loc5_;
            clip.button_send_gifts.graphics.visible = _loc5_;
            clip.tf_no_friends.text = Translate.translate("UI_DIALOG_FRIEND_GIFTS_NO_FRIENDS_AT_ALL");
            clip.tf_no_friends.visible = true;
         }
         var _loc2_:int = clip.panels.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = clip.panels[_loc3_];
            if(_loc4_ && _loc4_.length > _loc3_)
            {
               _loc1_.friendDataProvider = _loc4_[_loc3_];
            }
            else
            {
               _loc1_.friendDataProvider = null;
            }
            _loc3_++;
         }
      }
      
      private function handler_send() : void
      {
         mediator.action_sendGifts_requestsFirst();
      }
      
      private function handler_shop() : void
      {
         mediator.action_openShop();
      }
      
      private function handler_invite() : void
      {
         mediator.action_inviteFriends();
      }
      
      private function onListRendererAdded(param1:Event, param2:FriendListItemRenderer) : void
      {
         param2.signal_select.add(onSelectSignal);
      }
      
      private function onListRendererRemoved(param1:Event, param2:FriendListItemRenderer) : void
      {
         param2.signal_select.remove(onSelectSignal);
      }
      
      private function onSelectSignal(param1:FriendDataProvider) : void
      {
      }
   }
}
