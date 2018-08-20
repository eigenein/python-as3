package game.mediator.gui.popup.chat.userinfo
{
   import engine.context.GameContext;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.command.rpc.clan.CommandClanGetInfo;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.clan.ClanPublicInfoPopupMediator;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.chat.ChatUserData;
   import game.model.user.clan.ClanMemberValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class ChatUserInfoPopUpMediator extends PopupMediator
   {
       
      
      private var userData:ChatUserData;
      
      private var _banAvaliable:Boolean;
      
      private var _signal_updateClanInfo:Signal;
      
      private var _userClanInfo:ClanValueObject;
      
      public function ChatUserInfoPopUpMediator(param1:Player, param2:ChatUserData)
      {
         var _loc3_:* = null;
         _signal_updateClanInfo = new Signal();
         super(param1);
         this.userData = param2;
         if(userData.clanInfo)
         {
            _loc3_ = GameModel.instance.actionManager.clan.clanGetInfo(userData.clanInfo.id);
            _loc3_.onClientExecute(handler_clanProfileResult);
         }
      }
      
      public function get banAvaliable() : Boolean
      {
         return player.isChatModerator && userData.id != player.id && !userData.isBot && _banAvaliable;
      }
      
      public function set banAvaliable(param1:Boolean) : void
      {
         _banAvaliable = param1;
      }
      
      public function get signal_updateClanInfo() : Signal
      {
         return _signal_updateClanInfo;
      }
      
      public function get userNickname() : String
      {
         return userData.nickname;
      }
      
      public function get userID() : String
      {
         return userData.id;
      }
      
      public function get userClanID() : int
      {
         return !!userData.clanInfo?userData.clanInfo.id:0;
      }
      
      public function get userInfo() : UserInfo
      {
         return userData;
      }
      
      public function get userClanInfo() : ClanValueObject
      {
         return _userClanInfo;
      }
      
      public function get inBlackList() : Boolean
      {
         return player.chat.blackList[userID];
      }
      
      public function get blackListActionAvailable() : Boolean
      {
         return userData != null && userData.id != player.id && !userData.isBot;
      }
      
      public function get showProfile() : Boolean
      {
         if(!player.clan.clan)
         {
            return false;
         }
         var _loc1_:ClanMemberValueObject = player.clan.clan.getMemberById(userData.id);
         if(!_loc1_)
         {
            return false;
         }
         return _loc1_.showProfile;
      }
      
      public function blackListAction() : void
      {
         if(inBlackList)
         {
            GameModel.instance.actionManager.chat.chatBlackListRemove(player,userID);
         }
         else
         {
            GameModel.instance.actionManager.chat.chatBlackListAdd(player,userID);
         }
         close();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ChatUserInfoPopUp(this);
         return _popup;
      }
      
      public function showClanInfo() : void
      {
         var _loc1_:ClanPublicInfoPopupMediator = new ClanPublicInfoPopupMediator(userClanInfo,player);
         _loc1_.open(Stash.click("chat_user_info",_popup.stashParams));
      }
      
      public function ban1() : void
      {
         GameModel.instance.actionManager.chat.chatBan(userData.id,0);
         close();
      }
      
      public function ban2() : void
      {
         GameModel.instance.actionManager.chat.chatBan(userData.id,1);
         close();
      }
      
      public function ban3() : void
      {
         GameModel.instance.actionManager.chat.chatBan(userData.id,2);
         close();
      }
      
      public function action_profile() : void
      {
         if(showProfile && GameContext.instance.platformFacade.canNavigateToSocialProfile)
         {
            GameContext.instance.platformFacade.getSocialProfileUrl(userData.accountId).then(handler_socialProfileUrl);
         }
      }
      
      private function handler_socialProfileUrl(param1:String) : void
      {
      }
      
      private function handler_clanProfileResult(param1:CommandClanGetInfo) : void
      {
         _userClanInfo = param1.clanValueObject;
         _signal_updateClanInfo.dispatch();
      }
   }
}
