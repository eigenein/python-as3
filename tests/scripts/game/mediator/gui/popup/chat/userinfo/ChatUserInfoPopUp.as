package game.mediator.gui.popup.chat.userinfo
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.util.TimeFormatter;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.ClipBasedPopup;
   
   public class ChatUserInfoPopUp extends ClipBasedPopup
   {
      
      public static const INVALIDATION_FLAG_CLAN_INFO:String = "clan_info";
       
      
      private var clip:ChatUserInfoPopUpClip;
      
      private var clanFlag:ChatUserClanIconClip;
      
      private var mediator:ChatUserInfoPopUpMediator;
      
      public function ChatUserInfoPopUp(param1:ChatUserInfoPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_updateClanInfo.add(onUpdateClanInfo);
         stashParams.windowName = "chatUserInfo";
      }
      
      override public function dispose() : void
      {
         if(clanFlag)
         {
            TooltipHelper.removeTooltip(clanFlag.graphics);
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_chat_user_info();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title_tf.text = mediator.userNickname;
         clip.id_tf.text = "ID: " + mediator.userID;
         clip.portrait.setData(mediator.userInfo);
         clip.ban_tf.text = Translate.translate("UI_COMMON_BAN_ACTION");
         clip.blackListActionButton.label = !!mediator.inBlackList?Translate.translate("UI_COMMON_BLACK_LIST_REMOVE"):Translate.translate("UI_COMMON_BLACK_LIST_ADD");
         clip.blackListActionButton.signal_click.add(mediator.blackListAction);
         clip.button_profile.graphics.visible = mediator.showProfile;
         clip.button_profile.initialize(Translate.translate("UI_POPUP_USER_INFO_PROFILE"),mediator.action_profile);
         clip.action_button1.label = TimeFormatter.toD(DataStorage.rule.chatRule.banDuration[0],"{h}","",true);
         clip.action_button2.label = TimeFormatter.toD(DataStorage.rule.chatRule.banDuration[1],"{d}","",true);
         clip.action_button3.label = TimeFormatter.toD(DataStorage.rule.chatRule.banDuration[2],"{d}","",true);
         clip.action_button1.signal_click.add(mediator.ban1);
         clip.action_button2.signal_click.add(mediator.ban2);
         clip.action_button3.signal_click.add(mediator.ban3);
         if(!mediator.blackListActionAvailable)
         {
            clip.blackListActionButton.graphics.visible = false;
            clip.bg.graphics.height = clip.bg.graphics.height - clip.blackListActionButton.graphics.height;
         }
         if(!mediator.banAvaliable)
         {
            clip.layout_ban_grouop.graphics.visible = false;
            clip.bg.graphics.height = clip.bg.graphics.height - clip.layout_ban_grouop.graphics.height;
         }
         if(mediator.userClanID)
         {
            clanFlag = new ChatUserClanIconClip();
            clanFlag.setupEmpty();
            clip.layout_content.addChildAt(clanFlag.graphics,0);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("clan_info"))
         {
            if(mediator.userClanInfo)
            {
               clanFlag.setupFlag(mediator.userClanInfo.icon);
               clanFlag.signal_click.add(mediator.showClanInfo);
               TooltipHelper.addTooltip(clanFlag.graphics,new TooltipVO(TooltipTextView,mediator.userClanInfo.title));
            }
         }
         super.draw();
      }
      
      private function onUpdateClanInfo() : void
      {
         invalidate("clan_info");
      }
   }
}
