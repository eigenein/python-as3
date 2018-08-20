package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.command.timer.GameTimer;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.GameModel;
   import game.model.user.UserInfo;
   import game.model.user.chat.ChatLogMessage;
   import game.model.user.chat.ChatMessageChallengeData;
   import game.util.DateFormatter;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class ChatListItemRendererChallengeClip extends GuiClipNestedContainer
   {
       
      
      private var data:ChatMessageChallengeData;
      
      public const btn_option:ClipButton = new ClipButton();
      
      public const tf_label:ClipLabel = new ClipLabel();
      
      public const button_responses:ChatChallengeResponsesUnderlinedButton = new ChatChallengeResponsesUnderlinedButton();
      
      public function ChatListItemRendererChallengeClip()
      {
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(button_responses.graphics);
         if(data != null)
         {
            unsubscribeData(data);
         }
      }
      
      public function setChallengeData(param1:ChatMessageChallengeData) : void
      {
         if(this.data != param1)
         {
            if(this.data)
            {
               unsubscribeData(this.data);
            }
            this.data = param1;
            if(param1)
            {
               setupData(param1);
            }
         }
      }
      
      protected function unsubscribeData(param1:ChatMessageChallengeData) : void
      {
         this.data.responses.removeEventListener("change",handler_listChanged);
      }
      
      protected function setupData(param1:ChatMessageChallengeData) : void
      {
         if(param1.isTitanBattle)
         {
            tf_label.text = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_TEXT_TITAN");
         }
         else
         {
            tf_label.text = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_TEXT");
         }
         param1.responses.addEventListener("change",handler_listChanged);
         handler_listChanged(null);
      }
      
      private function handler_listChanged(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = false;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc2_:int = this.data.responses.length;
         if(_loc2_ > 0)
         {
            button_responses.graphics.visible = true;
            button_responses.label = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_RESPONSES") + " (" + _loc2_ + ")";
         }
         else
         {
            button_responses.graphics.visible = false;
         }
         TooltipHelper.removeTooltip(button_responses.graphics);
         if(_loc2_ > 0)
         {
            _loc4_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc8_ = this.data.responses.getItemAt(_loc5_) as ChatLogMessage;
               _loc9_ = _loc8_.replayData.enemyID == GameModel.instance.player.id;
               _loc3_ = !!_loc9_?8841550:15919178;
               _loc7_ = ColorUtils.hexToRGBFormat(_loc3_) + getTimeString(_loc8_);
               _loc7_ = _loc7_ + ("   " + ColorUtils.hexToRGBFormat(15919178) + nicknameWithCrown(_loc8_.initiator));
               _loc4_ = _loc4_ + ((_loc5_ > 0?"\n":"") + _loc7_);
               _loc5_++;
            }
            _loc6_ = new TooltipVO(TooltipTextView,_loc4_);
            TooltipHelper.addTooltip(button_responses.graphics,_loc6_);
         }
      }
      
      private function nicknameWithCrown(param1:UserInfo) : String
      {
         var _loc2_:* = null;
         if(param1)
         {
            if(param1.frameId > 0)
            {
               _loc2_ = " ^{sprite:icon_crown_" + param1.frameId + "}^";
            }
            else
            {
               _loc2_ = "";
            }
            return param1.nickname + _loc2_;
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
   }
}
