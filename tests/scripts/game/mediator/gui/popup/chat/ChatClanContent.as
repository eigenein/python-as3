package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.data.storage.DataStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.events.Event;
   import starling.filters.ColorMatrixFilter;
   
   public class ChatClanContent extends GuiClipNestedContainer
   {
       
      
      private var clanNewsClickController:TouchClickController;
      
      private var clanNewsHoverController:TouchHoverContoller;
      
      private var hoverFilter:ColorMatrixFilter;
      
      private var _mediator:ChatPopupMediator;
      
      public var button_send:ClipButtonLabeled;
      
      public var tf_message_input:ClipInput;
      
      public var chat_list_message:ChatListClip;
      
      public var input_bg:GuiClipScale9Image;
      
      public var clan_news:ChatClanNewsClip;
      
      public var btn_challenge:ClipButton;
      
      private var tooltipVO:TooltipVO;
      
      private var _chatType:String = "clan";
      
      public function ChatClanContent()
      {
         button_send = new ClipButtonLabeled();
         tf_message_input = new ClipInput();
         chat_list_message = new ChatListClip();
         input_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         clan_news = new ChatClanNewsClip();
         btn_challenge = new ClipButton();
         super();
         hoverFilter = new ColorMatrixFilter();
         hoverFilter.adjustBrightness(-0.3);
         tooltipVO = new TooltipVO(TooltipTextView,null);
         tooltipVO.hintData = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_TEXT");
      }
      
      public function dispose() : void
      {
         graphics.dispose();
         removeListeners();
         clanNewsClickController.dispose();
         clanNewsHoverController.dispose();
         hoverFilter.dispose();
      }
      
      public function set mediator(param1:ChatPopupMediator) : void
      {
         if(_mediator == param1)
         {
            return;
         }
         _mediator = param1;
         if(_mediator)
         {
            _mediator.updateChatClan();
         }
      }
      
      public function get mediator() : ChatPopupMediator
      {
         return _mediator;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_message_input.promptShowDelay = 0.3;
         tf_message_input.maxChars = DataStorage.rule.chatRule.maxMessageLength;
         clanNewsClickController = new TouchClickController(clan_news.newsLG);
         clanNewsClickController.onClick.add(handler_clanNewsClick);
         clanNewsHoverController = new TouchHoverContoller(clan_news.newsLG);
         clanNewsHoverController.signal_hoverChanger.add(handler_clanNewsHover);
         TooltipHelper.addTooltip(btn_challenge.graphics,tooltipVO);
      }
      
      public function update() : void
      {
         mediator.writeInChatLog("clan");
         removeListeners();
         addListeners();
         tf_message_input.prompt = Translate.translate("UI_DIALOG_CHAT_INPUT_MESSAGE_PROMPT");
         chat_list_message.list.dataProvider = mediator.chatLog;
         if(mediator.chatLog.length > 0)
         {
            chat_list_message.list.scrollToDisplayIndex(mediator.chatLog.length - 1);
         }
         button_send.label = Translate.translate("UI_POPUP_CHAT_SEND");
         clan_news.tf_clan_news_header.text = Translate.translate("UI_POPUP_CHAT_CLAN_NEWS_TITLE");
         var _loc1_:String = !!mediator.clan_model.news?mediator.clan_model.news:Translate.translate("UI_POPUP_CHAT_CLAN_NEWS_DEFAULT");
         clan_news.input_text_clip.button_save.label = Translate.translate("UI_POPUP_CHAT_CLAN_NEWS_SAVE");
         clan_news.input_text_clip.tf_input.text = _loc1_.substr(0,Math.min(_loc1_.length,DataStorage.rule.clanRule.maxDescriptionLength));
         setNewsText(_loc1_);
         clan_news.input_text_clip.graphics.visible = false;
         clan_news.tf_clan_news.graphics.visible = true;
         setEditNewsButtonVisuble(mediator.canEditClanNews());
         mediator.clan_model.saveLastReadClanNewsHash();
      }
      
      public function remove() : void
      {
         removeListeners();
         chat_list_message.list.scrollToPosition(0,0);
         chat_list_message.list.dataProvider = null;
      }
      
      private function setNewsText(param1:String) : void
      {
         clan_news.tf_clan_news.text = ProcessingURLTextMediator.prepareText(param1,6984428);
         clan_news.newsLG.touchable = ProcessingURLTextMediator.findURL(param1);
      }
      
      private function addListeners() : void
      {
         if(mediator.clan_model)
         {
            mediator.clan_model.signal_newsUpdated.add(onNewsUpdate);
         }
         chat_list_message.signal_select.add(onMessageSelect);
         chat_list_message.signal_challenge.add(onMessageChallege);
         chat_list_message.signal_replay.add(onMessageReplay);
         chat_list_message.signal_headerClick.add(onShowUserInfo);
         chat_list_message.signal_replay_share.add(onReplay);
         button_send.signal_click.add(handler_sendClick);
         btn_challenge.signal_click.add(mediator.showChallengePopUp);
         if(mediator.canEditClanNews)
         {
            clan_news.input_text_clip.tf_input.addEventListener("enter",handlerEvent_onSaveNewsBtnClick);
            clan_news.button_edit_news.signal_click.add(onEditNewsBtnClick);
            clan_news.input_text_clip.button_save.signal_click.add(onSaveNewsBtnClick);
         }
         tf_message_input.addEventListener("enter",handlerEvent_sendClick);
         mediator.chatLog.addEventListener("addItem",scrollToMaxPosition);
         mediator.chatLog.addEventListener("change",scrollToMaxPosition);
      }
      
      private function removeListeners() : void
      {
         if(mediator.clan_model)
         {
            mediator.clan_model.signal_newsUpdated.remove(onNewsUpdate);
         }
         chat_list_message.signal_select.remove(onMessageSelect);
         chat_list_message.signal_challenge.remove(onMessageChallege);
         chat_list_message.signal_replay.remove(onMessageReplay);
         chat_list_message.signal_headerClick.remove(onShowUserInfo);
         chat_list_message.signal_replay_share.remove(onReplay);
         button_send.signal_click.remove(handler_sendClick);
         btn_challenge.signal_click.remove(mediator.showChallengePopUp);
         if(mediator.canEditClanNews)
         {
            clan_news.input_text_clip.tf_input.removeEventListener("enter",handlerEvent_onSaveNewsBtnClick);
            clan_news.button_edit_news.signal_click.remove(onEditNewsBtnClick);
            clan_news.input_text_clip.button_save.signal_click.remove(onSaveNewsBtnClick);
         }
         tf_message_input.removeEventListener("enter",handlerEvent_sendClick);
         mediator.chatLog.removeEventListener("addItem",scrollToMaxPosition);
         mediator.chatLog.removeEventListener("change",scrollToMaxPosition);
      }
      
      private function onMessageSelect(param1:ChatUserData) : void
      {
         mediator.showUserInfo(param1);
      }
      
      private function onMessageChallege(param1:ChatPopupLogValueObject) : void
      {
         mediator.showChallengeInfo(param1);
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
      
      private function setEditNewsButtonVisuble(param1:Boolean) : void
      {
         clan_news.button_edit_news.graphics.visible = param1;
         (clan_news.layout_header.layout as HorizontalLayout).paddingLeft = !!param1?clan_news.button_edit_news.graphics.width:0;
      }
      
      private function handlerEvent_onSaveNewsBtnClick(param1:Event) : void
      {
         onSaveNewsBtnClick();
      }
      
      private function onSaveNewsBtnClick() : void
      {
         var _loc1_:String = clan_news.input_text_clip.tf_input.text;
         if(_loc1_ == "")
         {
            _loc1_ = Translate.translate("UI_POPUP_CHAT_CLAN_NEWS_DEFAULT");
         }
         clan_news.input_text_clip.graphics.visible = false;
         clan_news.input_text_clip.tf_input.container.visible = false;
         clan_news.tf_clan_news.graphics.visible = true;
         setEditNewsButtonVisuble(true);
         if(_loc1_ != mediator.clan_model.news)
         {
            mediator.save_clan_news(_loc1_);
         }
      }
      
      private function onEditNewsBtnClick() : void
      {
         setEditNewsButtonVisuble(false);
         clan_news.tf_clan_news.container.visible = false;
         clan_news.input_text_clip.graphics.visible = true;
         clan_news.input_text_clip.tf_input.container.visible = true;
         clan_news.input_text_clip.tf_input.setFocus();
         clan_news.input_text_clip.tf_input.selectRange(0,0);
      }
      
      private function onNewsUpdate() : void
      {
         var _loc1_:String = !!mediator.clan_model.news?mediator.clan_model.news:Translate.translate("UI_POPUP_CHAT_CLAN_NEWS_DEFAULT");
         clan_news.input_text_clip.tf_input.text = _loc1_;
         setNewsText(_loc1_);
         mediator.clan_model.saveLastReadClanNewsHash();
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
      
      private function handler_clanNewsClick() : void
      {
         ProcessingURLTextMediator.navigateToFirstURL(mediator.clan_model.news);
      }
      
      private function handler_clanNewsHover() : void
      {
         if(clanNewsHoverController.hover)
         {
            clan_news.newsLG.filter = hoverFilter;
         }
         else
         {
            clan_news.newsLG.filter = null;
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
