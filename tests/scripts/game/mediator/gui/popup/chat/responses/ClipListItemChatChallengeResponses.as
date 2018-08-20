package game.mediator.gui.popup.chat.responses
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.command.timer.GameTimer;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.UserInfo;
   import game.model.user.chat.ChatLogMessage;
   import game.util.DateFormatter;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClipListItemChatChallengeResponses extends ClipListItem
   {
       
      
      private var context:ChatChallengeResponsesPopupMediator;
      
      private var data:ChatLogMessage;
      
      public const portrait:PlayerPortraitClip = new PlayerPortraitClip();
      
      public const tf_nickname:ClipLabel = new ClipLabel();
      
      public const tf_date:ClipLabel = new ClipLabel();
      
      public const tf_victory:ClipLabel = new ClipLabel();
      
      public const tf_defeat:ClipLabel = new ClipLabel();
      
      public var button_chat:ClipButton;
      
      public var button_info:ClipButtonLabeled;
      
      public var button_camera:ClipButton;
      
      public var buttons_layout:ClipLayout;
      
      public function ClipListItemChatChallengeResponses(param1:ChatChallengeResponsesPopupMediator)
      {
         button_chat = new ClipButton();
         button_info = new ClipButtonLabeled();
         button_camera = new ClipButton();
         buttons_layout = ClipLayout.horizontalMiddleCentered(5,button_chat,button_info,button_camera);
         this.context = param1;
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(this.data)
         {
            this.data.replayData.battleResult.unsubscribe(handler_battleResult);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_info.label = "i";
         tf_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
         tf_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         button_chat.signal_click.add(handler_chat);
         button_info.signal_click.add(handler_info);
         button_camera.signal_click.add(handler_camera);
         TooltipHelper.addTooltip(button_chat.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_REPLAY_TOOL_TIP")));
         TooltipHelper.addTooltip(button_info.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_INFO_TOOL_TIP")));
         TooltipHelper.addTooltip(button_camera.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_CAMERA_TOOL_TIP")));
      }
      
      override public function setData(param1:*) : void
      {
         if(this.data)
         {
            this.data.replayData.battleResult.unsubscribe(handler_battleResult);
         }
         data = param1 as ChatLogMessage;
         if(!data)
         {
            return;
         }
         data.replayData.battleResult.onValue(handler_battleResult);
         portrait.setData(data.initiator);
         tf_date.text = getTimeString(data);
         tf_nickname.text = getNickname(data.initiator);
      }
      
      private function getNickname(param1:UserInfo) : String
      {
         if(param1)
         {
            return param1.nickname;
         }
         return Translate.translate("UI_COMMON_USR_NO_NAME");
      }
      
      private function getTimeString(param1:ChatLogMessage) : String
      {
         var _loc3_:Date = new Date(param1.ctime * 1000);
         var _loc2_:Date = new Date(GameTimer.instance.currentServerTime * 1000);
         if(_loc3_.date == _loc2_.date)
         {
            return DateFormatter.dateToHHMM(_loc3_);
         }
         return DateFormatter.dateToDDMMYYYY(_loc3_);
      }
      
      private function handler_battleResult(param1:int) : void
      {
         tf_victory.graphics.visible = param1 == 1;
         tf_defeat.graphics.visible = param1 == 2;
      }
      
      private function handler_camera() : void
      {
         context.action_replay(data);
      }
      
      private function handler_chat() : void
      {
         context.action_sendReplay(data);
      }
      
      private function handler_info() : void
      {
         context.action_showInfo(data);
      }
   }
}
