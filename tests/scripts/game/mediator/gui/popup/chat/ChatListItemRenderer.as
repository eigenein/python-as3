package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.GameModel;
   import game.model.user.chat.ChatMessageReplayData;
   import game.model.user.chat.ChatUserData;
   import game.util.FoulLanguageFilter;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.filters.ColorMatrixFilter;
   
   public class ChatListItemRenderer extends ListItemRenderer
   {
       
      
      private const paddingsTopBottom:Number = 10;
      
      private var headerLG:LayoutGroup;
      
      private var msgLG:LayoutGroup;
      
      private var headerClickController:TouchClickController;
      
      private var headerHoverController:TouchHoverContoller;
      
      private var msgClickController:TouchClickController;
      
      private var msgHoverController:TouchHoverContoller;
      
      private var replayMsgClickController:TouchClickController;
      
      private var replayMsgHoverController:TouchHoverContoller;
      
      private var bgHoverController:TouchHoverContoller;
      
      private var copyBtnHoverController:TouchHoverContoller;
      
      private var replayClickController:TouchClickController;
      
      private var replayHoverController:TouchHoverContoller;
      
      private var clip:ChatListItemRendererClip;
      
      private var hoverFilter:ColorMatrixFilter;
      
      private var tooltipVO:TooltipVO;
      
      private var _signal_select:Signal;
      
      private var _signal_challenge:Signal;
      
      private var _signal_replay:Signal;
      
      private var _signal_headerClick:Signal;
      
      private var _signal_replay_share:Signal;
      
      public function ChatListItemRenderer()
      {
         _signal_select = new Signal(ChatUserData);
         _signal_challenge = new Signal(ChatPopupLogValueObject);
         _signal_replay = new Signal(ChatPopupLogValueObject);
         _signal_headerClick = new Signal(ChatPopupLogValueObject);
         _signal_replay_share = new Signal(ChatMessageReplayData);
         super();
         hoverFilter = new ColorMatrixFilter();
         hoverFilter.adjustBrightness(-0.3);
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_challenge() : Signal
      {
         return _signal_challenge;
      }
      
      public function get signal_replay() : Signal
      {
         return _signal_replay;
      }
      
      public function get signal_headerClick() : Signal
      {
         return _signal_headerClick;
      }
      
      public function get signal_replay_share() : Signal
      {
         return _signal_replay_share;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = data as ChatPopupLogValueObject;
         if(!_loc2_)
         {
         }
      }
      
      override public function dispose() : void
      {
         if(headerClickController)
         {
            headerClickController.dispose();
         }
         if(headerHoverController)
         {
            headerHoverController.dispose();
         }
         if(msgClickController)
         {
            msgClickController.dispose();
         }
         if(msgHoverController)
         {
            msgHoverController.dispose();
         }
         if(replayMsgClickController)
         {
            replayMsgClickController.dispose();
         }
         if(replayMsgHoverController)
         {
            replayMsgHoverController.dispose();
         }
         if(replayClickController)
         {
            replayClickController.dispose();
         }
         if(replayHoverController)
         {
            replayHoverController.dispose();
         }
         if(copyBtnHoverController)
         {
            copyBtnHoverController.dispose();
         }
         if(bgHoverController)
         {
            bgHoverController.dispose();
         }
         if(tooltipVO)
         {
            TooltipHelper.removeTooltip(clip.tf_chat_message);
            tooltipVO = null;
         }
         hoverFilter.dispose();
         if(clip)
         {
            if(clip.challenge_content)
            {
               clip.challenge_content.dispose();
            }
            TooltipHelper.removeTooltip(clip.button_copy.graphics);
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Boolean = false;
         var _loc1_:Boolean = false;
         super.commitData();
         var _loc2_:Boolean = false;
         var _loc6_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc6_)
         {
            if(_loc6_.serverMessage)
            {
               clip.bg.graphics.visible = true;
               clip.bg_my.graphics.visible = false;
               clip.tf_chat_message_header.text = ColorUtils.hexToRGBFormat(11087871) + Translate.translate("UI_DIALOG_CHAT_SERVER_MESSAGE");
               clip.tf_time.text = ColorUtils.hexToRGBFormat(11087871) + _loc6_.time;
               if(_loc6_.initiator.frameId > 0)
               {
                  _loc4_ = " ^{sprite:icon_crown_" + _loc6_.initiator.frameId + "}^";
               }
               else
               {
                  _loc4_ = "";
               }
               if(_loc6_.messageType == "hero")
               {
                  clip.tf_chat_message.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_HERO_MESSAGE",ColorUtils.hexToRGBFormat(15919178) + _loc6_.initiator.nickname + _loc4_ + ColorUtils.hexToRGBFormat(16645626));
               }
               else if(_loc6_.messageType == "coinSuper")
               {
                  clip.tf_chat_message.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_COIN_SUPER_MESSAGE",ColorUtils.hexToRGBFormat(15919178) + _loc6_.initiator.nickname + _loc4_ + ColorUtils.hexToRGBFormat(16645626));
               }
               else if(_loc6_.messageType == "artifactChestLU")
               {
                  clip.tf_chat_message.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_NEW_ARTIFACT_LEVEL",ColorUtils.hexToRGBFormat(15919178) + _loc6_.initiator.nickname + _loc4_ + ColorUtils.hexToRGBFormat(16645626),_loc6_.data.level);
               }
               else if(_loc6_.messageType == "x100")
               {
                  _loc7_ = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_X100_MESSAGE",ColorUtils.hexToRGBFormat(15919178) + _loc6_.initiator.nickname + _loc4_ + ColorUtils.hexToRGBFormat(16645626));
                  if(int(_loc6_.data.gold) > 0)
                  {
                     _loc7_ = _loc7_ + (" " + ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_X100_PRIZE",_loc6_.data.gold));
                  }
                  clip.tf_chat_message.text = _loc7_;
               }
               clip.tf_chat_message_header.touchable = false;
               clip.tf_chat_message.touchable = true;
            }
            else
            {
               _loc8_ = !!_loc6_.myMessage?8841550:15919178;
               clip.bg.graphics.visible = !_loc6_.myMessage;
               clip.bg_my.graphics.visible = _loc6_.myMessage;
               if(_loc6_.userIsBanned)
               {
                  clip.tf_chat_message.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_DIALOG_CHAT_AUTHOR_BANNED");
                  clip.tf_time.text = ColorUtils.hexToRGBFormat(_loc8_) + _loc6_.time;
                  clip.tf_chat_message_header.visible = false;
                  clip.tf_chat_message.visible = true;
                  if(_loc6_.playerIsModerator)
                  {
                     _loc2_ = true;
                     _loc3_ = "ID: " + _loc6_.userId + "\n" + _loc6_.initiator.nickname + "\n" + _loc6_.text;
                     if(!tooltipVO)
                     {
                        tooltipVO = new TooltipVO(TooltipTextView,_loc3_);
                     }
                     else
                     {
                        tooltipVO.hintData = _loc3_;
                     }
                  }
                  clip.tf_chat_message.touchable = _loc2_;
                  clip.tf_chat_message_header.touchable = false;
               }
               else
               {
                  clip.tf_chat_message_header.text = ColorUtils.hexToRGBFormat(_loc8_) + _loc6_.header;
                  clip.tf_time.text = ColorUtils.hexToRGBFormat(_loc8_) + _loc6_.time;
                  clip.tf_chat_message.visible = _loc6_.text && _loc6_.text.length > 0;
                  if(GameModel.instance.player.settings.foulLanguageFilter.getValue())
                  {
                     clip.tf_chat_message.text = ProcessingURLTextMediator.prepareText(FoulLanguageFilter.checkBadWordsAndCorrect(_loc6_.text),16573879);
                  }
                  else
                  {
                     clip.tf_chat_message.text = ProcessingURLTextMediator.prepareText(_loc6_.text,16573879);
                  }
                  clip.tf_chat_message_header.touchable = true;
                  clip.tf_chat_message.touchable = ProcessingURLTextMediator.findURL(_loc6_.text);
               }
            }
            if(!_loc6_.serverMessage && _loc6_.myMessage)
            {
               clip.layout_group.x = 55;
            }
            else
            {
               clip.layout_group.x = 23;
            }
            clip.graphics.alpha = !!_loc6_.userIsBanned?0.5:1;
            _loc5_ = _loc6_.messageType == "replay" && !_loc6_.userIsBanned;
            clip.replay_content.graphics.visible = _loc5_;
            if(_loc5_)
            {
               if(_loc6_.replayData.enemy)
               {
                  if(_loc6_.replayData.enemy.frameId > 0)
                  {
                     _loc4_ = " ^{sprite:icon_crown_" + _loc6_.replayData.enemy.frameId + "}^";
                  }
                  else
                  {
                     _loc4_ = "";
                  }
                  clip.replay_content.tf_label.touchable = true;
                  clip.replay_content.tf_label.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_CHAT_REPLAY_WITH_TEXT",ColorUtils.hexToRGBFormat(15919178) + _loc6_.replayData.enemy.nickname + _loc4_);
               }
               else
               {
                  clip.replay_content.tf_label.touchable = false;
                  clip.replay_content.tf_label.text = ColorUtils.hexToRGBFormat(16645626) + Translate.translate("UI_DIALOG_CHAT_REPLAY_TEXT");
               }
            }
            _loc1_ = _loc6_.messageType == "challenge" && !_loc6_.userIsBanned;
            clip.challenge_content.graphics.visible = _loc1_;
            if(_loc1_)
            {
               clip.challenge_content.setChallengeData(_loc6_.challengeData);
            }
            else
            {
               clip.challenge_content.setChallengeData(null);
            }
            invalidate("size");
            clip.layout_group.invalidate("layout");
         }
         if(tooltipVO)
         {
            if(_loc2_)
            {
               TooltipHelper.addTooltip(clip.tf_chat_message,tooltipVO);
            }
            else
            {
               TooltipHelper.removeTooltip(clip.tf_chat_message);
            }
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = this.isInvalid("size");
         super.draw();
         if(_loc1_)
         {
            clip.tf_chat_message.validate();
            clip.tf_chat_message_header.validate();
            clip.layout_group.validate();
            clip.bg.graphics.height = clip.layout_group.height + 10;
            clip.bg_my.graphics.height = clip.layout_group.height + 10;
            clip.button_copy.graphics.x = clip.layout_group.x + clip.layout_group.width - clip.button_copy.graphics.width + 5;
            clip.button_copy.graphics.y = clip.layout_group.y + clip.layout_group.height - clip.button_copy.graphics.height + 5;
            clip.tf_time.x = clip.layout_group.x + clip.layout_group.width - clip.tf_time.width;
         }
      }
      
      override public function get height() : Number
      {
         return clip.layout_group.height + 10;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChatListItemRendererClip,"chat_list_renderer");
         TooltipHelper.addTooltip(clip.button_copy.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_CHAT_COPY_MESSAGE")));
         clip.button_copy.createNativeClickHandler().add(handler_buttonCopyClick);
         clip.challenge_content.btn_option.signal_click.add(handler_buttonChallengeClick);
         clip.challenge_content.button_responses.signal_click.add(handler_buttonChallengeResponsesClick);
         clip.replay_content.btn_option.signal_click.add(handler_buttonReplayClick);
         addChild(clip.graphics);
         clip.tf_time.alpha = 0.4;
         clip.layout_group.height = NaN;
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.paddingTop = 5;
         _loc1_.paddingBottom = 5;
         headerLG = new LayoutGroup();
         headerLG.layout = _loc1_;
         headerLG.addChild(clip.tf_chat_message_header);
         msgLG = new LayoutGroup();
         msgLG.layout = _loc1_;
         msgLG.addChild(clip.tf_chat_message);
         clip.layout_group.addChild(headerLG);
         clip.layout_group.addChild(msgLG);
         clip.layout_group.addChild(clip.replay_content.graphics);
         clip.layout_group.addChild(clip.challenge_content.graphics);
         clip.tf_chat_message_header.touchable = true;
         clip.tf_chat_message_header.useHandCursor = true;
         headerClickController = new TouchClickController(clip.tf_chat_message_header);
         headerClickController.onClick.add(handler_headerClick);
         headerHoverController = new TouchHoverContoller(clip.tf_chat_message_header);
         headerHoverController.signal_hoverChanger.add(handler_headerHover);
         clip.tf_chat_message.touchable = true;
         clip.tf_chat_message.useHandCursor = true;
         msgClickController = new TouchClickController(clip.tf_chat_message);
         msgClickController.onClick.add(handler_msgClick);
         msgHoverController = new TouchHoverContoller(clip.tf_chat_message);
         msgHoverController.signal_hoverChanger.add(handler_msgHover);
         clip.replay_content.tf_label.touchable = true;
         clip.replay_content.tf_label.useHandCursor = true;
         replayMsgClickController = new TouchClickController(clip.replay_content.tf_label);
         replayMsgClickController.onClick.add(handler_replayMsgClick);
         replayMsgHoverController = new TouchHoverContoller(clip.replay_content.tf_label);
         replayMsgHoverController.signal_hoverChanger.add(handler_replayMsgHover);
         bgHoverController = new TouchHoverContoller(clip.bg_container);
         bgHoverController.signal_hoverChanger.add(handler_bgHover);
         clip.bg_container.useHandCursor = false;
         replayClickController = new TouchClickController(clip.replay_content.button_share.container);
         replayClickController.onClick.add(handler_replayClick);
         replayHoverController = new TouchHoverContoller(clip.replay_content.button_share.container);
         replayHoverController.signal_hoverChanger.add(handler_replayHover);
         copyBtnHoverController = new TouchHoverContoller(clip.button_copy.container);
         copyBtnHoverController.signal_hoverChanger.add(handler_copyBtnHover);
      }
      
      private function handler_buttonReplayClick() : void
      {
         _signal_replay.dispatch(data as ChatPopupLogValueObject);
      }
      
      private function handler_buttonChallengeClick() : void
      {
         _signal_challenge.dispatch(data as ChatPopupLogValueObject);
      }
      
      private function handler_buttonChallengeResponsesClick() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc1_)
         {
            _loc1_.action_showResponses();
         }
      }
      
      private function handler_msgClick() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc1_ && _loc1_.userIsBanned)
         {
            _signal_headerClick.dispatch(_loc1_);
         }
         else if(_loc1_ && !ProcessingURLTextMediator.navigateToFirstURL(_loc1_.text))
         {
            _signal_select.dispatch(_loc1_.initiator);
         }
      }
      
      private function handler_replayMsgClick() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc1_)
         {
            _signal_select.dispatch(_loc1_.replayData.enemy);
         }
      }
      
      private function handler_msgHover() : void
      {
         if(msgHoverController.hover)
         {
            msgLG.filter = hoverFilter;
         }
         else
         {
            msgLG.filter = null;
         }
      }
      
      private function handler_replayMsgHover() : void
      {
         if(replayMsgHoverController.hover)
         {
            clip.replay_content.msgLG.filter = hoverFilter;
         }
         else
         {
            clip.replay_content.msgLG.filter = null;
         }
      }
      
      private function handler_headerClick() : void
      {
         _signal_headerClick.dispatch(data as ChatPopupLogValueObject);
      }
      
      private function handler_headerHover() : void
      {
         if(headerHoverController.hover)
         {
            headerLG.filter = hoverFilter;
         }
         else
         {
            headerLG.filter = null;
         }
      }
      
      private function handler_replayClick() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc1_)
         {
            _signal_replay_share.dispatch(_loc1_.replayData);
         }
      }
      
      private function handler_bgHover() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         if(_loc1_.messageType == "replay")
         {
            clip.replay_content.button_share.graphics.visible = bgHoverController.hover;
         }
         else if(_loc1_.messageType == "text")
         {
            clip.button_copy.graphics.visible = bgHoverController.hover;
         }
      }
      
      private function handler_replayHover() : void
      {
         clip.replay_content.button_share.graphics.visible = replayHoverController.hover;
      }
      
      private function handler_copyBtnHover() : void
      {
         clip.button_copy.graphics.visible = copyBtnHoverController.hover;
      }
      
      private function handler_buttonCopyClick() : void
      {
         var _loc1_:ChatPopupLogValueObject = data as ChatPopupLogValueObject;
         ChatPopupMediator.copy_text_to_clipboard(_loc1_.text);
      }
   }
}
