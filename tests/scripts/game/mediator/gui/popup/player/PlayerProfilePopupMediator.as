package game.mediator.gui.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.player.CommandPlayerSetTimeZone;
   import game.command.rpc.player.server.CommandServerGetAll;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.player.server.ServerSelectPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   import game.view.popup.player.PlayerProfilePopup;
   import idv.cjcat.signals.Signal;
   
   public class PlayerProfilePopupMediator extends PopupMediator
   {
       
      
      private var _signal_updateAvatar:Signal;
      
      private var _signal_updateNickname:Signal;
      
      private var _serverName:String;
      
      public function PlayerProfilePopupMediator(param1:Player)
      {
         super(param1);
         _signal_updateAvatar = param1.avatarData.signal_updateAvatar;
         _signal_updateNickname = param1.signal_update.nickname;
         _serverName = param1.serverId + " " + Translate.translate("LIB_SERVER_NAME_" + param1.serverId);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _signal_updateAvatar = null;
         _signal_updateNickname = null;
      }
      
      public function get signal_updateAvatar() : Signal
      {
         return _signal_updateAvatar;
      }
      
      public function get signal_updateNickname() : Signal
      {
         return _signal_updateNickname;
      }
      
      public function get id() : String
      {
         return player.id;
      }
      
      public function get userInfo() : UserInfo
      {
         return player.getUserInfo();
      }
      
      public function get nickname() : String
      {
         return player.nickname;
      }
      
      public function get teamLevel() : int
      {
         return player.levelData.level.level;
      }
      
      public function get teamExp() : int
      {
         return player.levelData.experience;
      }
      
      public function get teamExpNext() : int
      {
         return player.levelData.nextLeveLExpirience;
      }
      
      public function get maxTeamLevel() : Boolean
      {
         return teamLevel >= DataStorage.level.getMaxTeamLevel();
      }
      
      public function get maxHeroLevel() : int
      {
         return player.levelData.level.maxHeroLevel;
      }
      
      public function get maxStamina() : int
      {
         return player.levelData.level.maxStamina;
      }
      
      public function get vipLevelLabel() : String
      {
         return "VIP " + player.vipLevel.level;
      }
      
      public function get timeZone() : int
      {
         return player.timeZone;
      }
      
      public function get timeZoneString() : String
      {
         return timeZone > 0?"GMT +" + timeZone:"GMT " + timeZone;
      }
      
      public function get localTimeZoneOffset() : int
      {
         return new Date().getTimezoneOffset();
      }
      
      public function get localTimeZone() : int
      {
         return Math.round(-localTimeZoneOffset / 60);
      }
      
      public function get localTimeZoneString() : String
      {
         return localTimeZone > 0?"GMT +" + localTimeZone:"GMT " + localTimeZone;
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new PlayerProfilePopup(this);
         return _popup;
      }
      
      public function action_changeAvatar() : void
      {
         var _loc1_:PopupStashEventParams = Stash.click("avatar_change",_popup.stashParams);
         var _loc2_:AvatarSelectPopupMediator = new AvatarSelectPopupMediator(GameModel.instance.player);
         _loc2_.open(_loc1_);
      }
      
      public function action_changeNickname() : void
      {
         var _loc1_:PlayerNicknameChangePopupMediator = new PlayerNicknameChangePopupMediator(GameModel.instance.player);
         var _loc2_:PopupStashEventParams = Stash.click("name_change",_popup.stashParams);
         _loc1_.open(_loc2_);
      }
      
      public function action_changeServer() : void
      {
         close();
         var _loc1_:CommandServerGetAll = GameModel.instance.actionManager.playerCommands.serverGetAll();
         _loc1_.onClientExecute(handler_onServerList);
      }
      
      public function handler_editTimeZone() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(8);
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.value > 0)
         {
            _loc2_ = Translate.translateArgs("UI_DIALOG_PLAYER_PROFILE_CHANGE_TIME_ZONE_TEXT",localTimeZoneString,timeZoneString,localTimeZoneString) + "\n" + Translate.translateArgs("UI_DIALOG_PLAYER_PROFILE_CHANGE_TIME_ZONE_REFILLABLE_TEXT",TimeFormatter.toDH(_loc1_.desc.refillSeconds,"{d}"," ",true));
            _loc4_ = PopupList.instance.prompt(_loc2_,null,Translate.translate("UI_COMMON_OK"),Translate.translate("UI_COMMON_CANCEL"));
            _loc4_.signal_confirm.addOnce(handler_timeZoneChangeConfirmed);
         }
         else
         {
            _loc3_ = PopupList.instance.prompt(Translate.translateArgs("UI_DIALOG_PLAYER_PROFILE_CHANGE_TIME_ZONE_REFILLABLE_TEXT",TimeFormatter.toDH(_loc1_.refillTimeLeft,"{d} {h} {m}"," ",true)),null,Translate.translate("UI_COMMON_OK"),Translate.translate("UI_COMMON_CANCEL"));
         }
      }
      
      private function handler_timeZoneChangeConfirmed(param1:PromptPopup) : void
      {
         GameModel.instance.actionManager.executeRPCCommand(new CommandPlayerSetTimeZone(localTimeZone));
         close();
      }
      
      private function handler_onServerList(param1:CommandServerGetAll) : void
      {
         var _loc2_:ServerSelectPopupMediator = new ServerSelectPopupMediator(GameModel.instance.player,param1);
         var _loc3_:PopupStashEventParams = Stash.click("server_change",_popup.stashParams);
         _loc2_.open(_loc3_);
      }
   }
}
