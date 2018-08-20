package game.view.popup.clan.activitystats
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipAnimatedContainer;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.activitystats.ClanActivityStatsPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ClanActivityStatsSendGiftsContentClip extends ClipAnimatedContainer
   {
       
      
      private var list:GameScrolledList;
      
      private var mediator:ClanActivityStatsPopupMediator;
      
      public var tf_label_desc:SpecialClipLabel;
      
      public var tf_content:ClipLabel;
      
      public var tf_player:ClipLabel;
      
      public var tf_likes:ClipLabel;
      
      public var tf_received_gifts:ClipLabel;
      
      public var tf_send_gifts:ClipLabel;
      
      public var layout_group:ClipLayout;
      
      public var button_send:ClipButtonLabeled;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ClanActivityStatsSendGiftsContentClip()
      {
         tf_label_desc = new SpecialClipLabel();
         tf_content = new ClipLabel();
         tf_player = new ClipLabel();
         tf_likes = new ClipLabel();
         tf_received_gifts = new ClipLabel();
         tf_send_gifts = new ClipLabel();
         layout_group = ClipLayout.horizontalMiddleCentered(2);
         button_send = new ClipButtonLabeled();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mediator)
         {
            mediator.property_freeGiftAmount.unsubscribe(handler_updateFreeGiftsAmount);
            mediator.property_freeGiftSelectedPeopleAmount.unsubscribe(handler_updateFreeGiftSelectedAmount);
         }
      }
      
      public function initialize(param1:ClanActivityStatsPopupMediator) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         this.mediator = param1;
         if(!param1.playerPermission_canSendGifts.value)
         {
            tf_send_gifts.graphics.visible = false;
            button_send.graphics.visible = false;
            playback.gotoAndStop(1);
         }
         else
         {
            playback.gotoAndStop(0);
         }
         tf_content.text = Translate.translate("UI_DIALOG_SEND_GIFT_CONTENT");
         button_send.label = Translate.translate("UI_DIALOG_SEND_GIFT_SEND");
         button_send.signal_click.add(param1.action_sendGifts);
         tf_player.text = Translate.translate("DEFAULT_NICKNAME");
         tf_likes.text = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_LIKES");
         tf_received_gifts.text = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_GIFTS_RECEIVED");
         var _loc2_:Vector.<InventoryItem> = param1.giftContents;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_item_small");
            _loc3_.setData(_loc2_[_loc5_]);
            layout_group.addChild(_loc3_.graphics);
            _loc5_++;
         }
         var _loc4_:GameScrollBar = new GameScrollBar();
         _loc4_.height = scroll_slider_container.container.height;
         scroll_slider_container.container.addChild(_loc4_);
         list = new GameScrolledList(_loc4_,null,null);
         list.layout = new VerticalLayout();
         (list.layout as VerticalLayout).paddingTop = 2;
         (list.layout as VerticalLayout).paddingBottom = 2;
         (list.layout as VerticalLayout).gap = 5;
         list.width = list_container.container.width;
         list.height = list_container.container.height;
         list.itemRendererType = ClanReceiverGiftRenderer;
         list_container.container.addChild(list);
         list.dataProvider = new ListCollection(param1.listData_gifts);
         param1.property_freeGiftAmount.onValue(handler_updateFreeGiftsAmount);
         param1.property_freeGiftSelectedPeopleAmount.onValue(handler_updateFreeGiftSelectedAmount);
      }
      
      private function handler_updateFreeGiftsAmount(param1:int) : void
      {
         tf_label_desc.text = mediator.descSendGiftsText;
         handler_updateFreeGiftSelectedAmount(mediator.property_freeGiftSelectedPeopleAmount.value);
      }
      
      private function handler_updateFreeGiftSelectedAmount(param1:int) : void
      {
         tf_send_gifts.text = Translate.translateArgs("UI_DIALOG_CLAN_ACTIVITY_SEND_GIFT",param1 + "/" + mediator.property_freeGiftAmount.value);
      }
   }
}
