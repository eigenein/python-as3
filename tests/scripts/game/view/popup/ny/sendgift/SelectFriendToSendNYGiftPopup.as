package game.view.popup.ny.sendgift
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.friends.SearchableFriendListPopup;
   import starling.events.Event;
   
   public class SelectFriendToSendNYGiftPopup extends SearchableFriendListPopup
   {
       
      
      private var __mediator:SelectFriendToSendNYGiftPopupMediator;
      
      private var tabButtons:Dictionary;
      
      private var toggle:ToggleGroup;
      
      public function SelectFriendToSendNYGiftPopup(param1:SelectFriendToSendNYGiftPopupMediator)
      {
         super(param1);
         this.__mediator = param1;
         __mediator.signal_tabChange.add(handler_tabChange);
         __mediator.signal_giftAmountChange.add(handler_presentAmountChange);
         __mediator.signal_receiverChange.add(handler_receiverChange);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         __mediator.signal_tabChange.remove(handler_tabChange);
         __mediator.signal_giftAmountChange.remove(handler_presentAmountChange);
         __mediator.signal_receiverChange.remove(handler_receiverChange);
      }
      
      private function get __clip() : SelectFriendToSendNYGiftPopupClip
      {
         return clip as SelectFriendToSendNYGiftPopupClip;
      }
      
      override public function get listItemRendererType() : Class
      {
         return SelectFriendToSendNYGiftItemRenderer;
      }
      
      override public function get searchInputDefaultText() : String
      {
         return Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_SEARCH_BY_NAME_OR_ID");
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         super.initialize();
         __clip.btn_send.label = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_SEND");
         __clip.btn_send.signal_click.add(__mediator.action_sendGift);
         __clip.btn_minus.signal_click.add(__mediator.decrementPresentAmount);
         __clip.btn_plus.signal_click.add(__mediator.incrementPresentAmount);
         __clip.tf_header.text = Translate.translateArgs("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_CAPTION",__mediator.giftTitle);
         __clip.tf_search.text = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_SEARCH");
         __clip.tf_price.text = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_PRICE");
         __clip.tf_reward.text = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_REWARD");
         __clip.tf_receiver.text = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_RECEIVER_NOT_FOUND");
         __clip.tf_warning.text = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_TF_WARNING");
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         var _loc1_:int = __mediator.tabs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
            _loc3_.NewIcon_inst0.graphics.visible = false;
            _loc3_.label = Translate.translate("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_" + __mediator.tabs[_loc2_].toUpperCase());
            toggle.addItem(_loc3_);
            __clip.layout_tabs.addChild(_loc3_.graphics);
            tabButtons[__mediator.tabs[_loc2_]] = _loc3_;
            _loc2_++;
         }
         toggle.selectedIndex = __mediator.selectedTabIndex;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         updateContent();
         updateSendButtonState();
         updateTabs();
         handler_presentAmountChange();
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.ny_gifts.create(SelectFriendToSendNYGiftPopupClip,"dialog_select_friend_to_send_gift");
      }
      
      override protected function onListSelectionChange(param1:Event) : void
      {
         super.onListSelectionChange(param1);
         if(param1.target is List)
         {
            __mediator.selectedFriend = (param1.target as List).selectedItem as FriendDataProvider;
         }
      }
      
      override protected function updateListData(param1:Boolean) : void
      {
         list.dataProvider = __mediator.friendList;
         __clip.tf_empty.visible = __mediator.friendList.length == 0;
         if(__mediator.friendList.length == 0)
         {
            if(param1)
            {
               __clip.tf_empty.text = Translate.translate("UI_DIALOG_REFERRER_SEARCH_EMPTY");
            }
            else
            {
               __clip.tf_empty.text = Translate.translateArgs("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_LIST_EMPTY",__mediator.playerServerId);
            }
         }
      }
      
      private function updateSendButtonState() : void
      {
         __clip.tf_warning.graphics.visible = __mediator.selectedSelf;
         __clip.warning_bg.graphics.visible = __mediator.selectedSelf;
         if(__mediator.selectedSelf)
         {
            __clip.btn_send.graphics.x = 473;
         }
         else
         {
            __clip.btn_send.graphics.x = 253;
         }
         __clip.btn_send.graphics.visible = __mediator.selectedFriend;
         __clip.tf_receiver.visible = !__clip.btn_send.graphics.visible;
      }
      
      private function updateContent() : void
      {
      }
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = tabButtons;
         for(var _loc1_ in tabButtons)
         {
            (tabButtons[_loc1_] as PopupSideTab).NewIcon_inst0.graphics.visible = __mediator.getTabVisibleByID(_loc1_);
         }
      }
      
      private function handler_tabSelected() : void
      {
         __clip.tf_name_input.text = "";
         __mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function handler_tabChange() : void
      {
         updateContent();
      }
      
      private function handler_presentAmountChange() : void
      {
         __clip.tf_amount.text = Translate.translateArgs("UI_DIALOG_SELECT_FRIEND_TO_SEND_GIFT_AMOUNT",__mediator.giftAmount);
         __clip.price.data = __mediator.presentPrice;
         __clip.reward1.data = __mediator.dailyHeroReward;
         __clip.reward2.data = __mediator.eventHeroReward;
         __clip.layout_price.readjustLayout();
      }
      
      private function handler_receiverChange() : void
      {
         updateSendButtonState();
      }
   }
}
