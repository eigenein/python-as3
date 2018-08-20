package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionFactory;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionMediator;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.util.DateFormatter;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.socialgrouppromotion.SocialGroupPromotionClipListItem;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class ChatServerContent extends GuiClipNestedContainer
   {
       
      
      private var _mediator:ChatPopupMediator;
      
      public var title_tf:SpecialClipLabel;
      
      public var button_send:ClipButtonLabeled;
      
      public var tf_message_input:ClipInput;
      
      public var chat_list_message:ChatListClip;
      
      public var input_bg:GuiClipScale9Image;
      
      public var list_social_group_promotion_buttons:ClipList;
      
      public var item_social_group_promotion_button:ClipDataProvider;
      
      public var layout_title:ClipLayout;
      
      private var _chatType:String = "server";
      
      public function ChatServerContent()
      {
         title_tf = new SpecialClipLabel();
         button_send = new ClipButtonLabeled();
         tf_message_input = new ClipInput();
         chat_list_message = new ChatListClip();
         input_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         list_social_group_promotion_buttons = new ClipList(SocialGroupPromotionClipListItem);
         item_social_group_promotion_button = list_social_group_promotion_buttons.itemClipProvider;
         layout_title = ClipLayout.verticalMiddleCenter(8,title_tf,list_social_group_promotion_buttons);
         super();
      }
      
      public function dispose() : void
      {
         graphics.dispose();
         removeListeners();
         if(mediator)
         {
            mediator.chatServerUnSubscribe();
            mediator.signal_banUntilChange.remove(onBanUntilChange);
         }
      }
      
      public function set mediator(param1:ChatPopupMediator) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(_mediator == param1)
         {
            return;
         }
         _mediator = param1;
         if(_mediator)
         {
            _mediator.chatServerSubscribe();
            _mediator.updateChatServer();
            if(_mediator.popup)
            {
               _loc2_ = _mediator.popup.stashParams;
            }
         }
         var _loc3_:Vector.<SocialGroupPromotionMediator> = SocialGroupPromotionFactory.serverChatButtonsMediators(_loc2_);
         if(_loc3_)
         {
            _loc4_ = new HorizontalLayout();
            _loc4_.gap = 5;
            _loc4_.useVirtualLayout = false;
            _loc4_.horizontalAlign = "center";
            list_social_group_promotion_buttons.list.layout = _loc4_;
            list_social_group_promotion_buttons.list.dataProvider = new ListCollection(_loc3_);
            list_social_group_promotion_buttons.graphics.visible = true;
            list_social_group_promotion_buttons.list.includeInLayout = true;
         }
         else
         {
            list_social_group_promotion_buttons.graphics.visible = false;
            list_social_group_promotion_buttons.list.includeInLayout = false;
         }
      }
      
      public function get mediator() : ChatPopupMediator
      {
         return _mediator;
      }
      
      private function addListeners() : void
      {
         mediator.signal_banUntilChange.add(onBanUntilChange);
         chat_list_message.signal_select.add(onMessageSelect);
         chat_list_message.signal_replay.add(onMessageReplay);
         chat_list_message.signal_headerClick.add(onShowUserInfo);
         chat_list_message.signal_replay_share.add(onReplay);
         if(!mediator.banned)
         {
            button_send.signal_click.add(handler_sendClick);
         }
         tf_message_input.addEventListener("enter",handlerEvent_sendClick);
         mediator.chatLog.addEventListener("addItem",scrollToMaxPosition);
         mediator.chatLog.addEventListener("change",scrollToMaxPosition);
      }
      
      private function removeListeners() : void
      {
         mediator.signal_banUntilChange.remove(onBanUntilChange);
         chat_list_message.signal_select.remove(onMessageSelect);
         chat_list_message.signal_replay.remove(onMessageReplay);
         chat_list_message.signal_headerClick.remove(onShowUserInfo);
         chat_list_message.signal_replay_share.remove(onReplay);
         if(!mediator.banned)
         {
            button_send.signal_click.remove(handler_sendClick);
         }
         tf_message_input.removeEventListener("enter",handlerEvent_sendClick);
         mediator.chatLog.removeEventListener("addItem",scrollToMaxPosition);
         mediator.chatLog.removeEventListener("change",scrollToMaxPosition);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_message_input.promptShowDelay = 0.3;
         tf_message_input.maxChars = DataStorage.rule.chatRule.maxMessageLength;
      }
      
      public function update() : void
      {
         mediator.writeInChatLog("server");
         removeListeners();
         addListeners();
         title_tf.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_POPUP_CHAT_SERVER_WELCOME",ColorUtils.hexToRGBFormat(16573879) + mediator.serverName);
         onBanUntilChange(mediator.banUntil);
         chat_list_message.list.dataProvider = mediator.chatLog;
         if(mediator.chatLog.length > 0)
         {
            chat_list_message.list.scrollToDisplayIndex(mediator.chatLog.length - 1);
         }
         button_send.label = Translate.translate("UI_POPUP_CHAT_SEND");
      }
      
      public function remove() : void
      {
         removeListeners();
         chat_list_message.list.scrollToPosition(0,0);
         chat_list_message.list.dataProvider = null;
      }
      
      private function onMessageSelect(param1:ChatUserData) : void
      {
         mediator.showUserInfo(param1);
      }
      
      private function onMessageReplay(param1:ChatPopupLogValueObject) : void
      {
         mediator.replay(param1);
      }
      
      private function onShowUserInfo(param1:ChatPopupLogValueObject) : void
      {
         mediator.showUserInfo(param1.initiator);
      }
      
      private function onReplay(param1:ChatMessageReplayData) : void
      {
         mediator.action_copyReplay(param1);
      }
      
      private function scrollToMaxPosition(param1:Event) : void
      {
         if(chat_list_message.list.dataProvider.length)
         {
            if(Math.round(chat_list_message.list.verticalScrollPosition) == Math.round(chat_list_message.list.maxVerticalScrollPosition))
            {
               chat_list_message.list.scrollToDisplayIndex(chat_list_message.list.dataProvider.length - 1);
            }
         }
      }
      
      private function onBanUntilChange(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(mediator.banned)
         {
            _loc2_ = new Date();
            _loc3_ = new Date(_loc2_.getTime() + mediator.banTime * 1000);
            tf_message_input.prompt = Translate.translateArgs("UI_DIALOG_CHAT_INPUT_MESSAGE_PROMPT_BANNED",DateFormatter.dateToDDMMYYYY_HHMMSS(_loc3_));
            tf_message_input.isEnabled = false;
            button_send.isEnabled = false;
            button_send.graphics.alpha = 0.5;
         }
         else if(mediator.teamLevel >= MechanicStorage.CHAT.teamLevel)
         {
            tf_message_input.prompt = Translate.translate("UI_DIALOG_CHAT_INPUT_MESSAGE_PROMPT");
         }
         else
         {
            tf_message_input.prompt = Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",MechanicStorage.CHAT.teamLevel);
            tf_message_input.isEnabled = false;
            button_send.isEnabled = false;
            button_send.graphics.alpha = 0.5;
         }
      }
      
      private function handlerEvent_sendClick(param1:Event) : void
      {
         handler_sendClick();
      }
      
      private function handler_sendClick() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:String = tf_message_input.text;
         if(_loc3_ != "")
         {
            _loc1_ = / /g;
            _loc2_ = _loc3_.match(_loc1_);
            if(_loc2_ == null || _loc2_.length < _loc3_.length)
            {
               if(mediator.action_send(_loc3_,_chatType))
               {
                  tf_message_input.text = "";
               }
            }
            else
            {
               tf_message_input.text = "";
            }
         }
      }
   }
}
