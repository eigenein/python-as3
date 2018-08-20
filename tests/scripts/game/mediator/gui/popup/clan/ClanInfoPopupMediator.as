package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.data.ListCollection;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.level.ClanLevel;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.info.ClanMemberListValueObject;
   import game.mediator.gui.popup.clan.log.ClanLogPopUpMediator;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   import game.view.popup.clan.ClanInfoPopup;
   import game.view.popup.clan.KickClanMemberPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanInfoPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _clan:ClanPrivateInfoValueObject;
      
      private var _playerRank:ClanRole;
      
      private var _useSumForSorting:BooleanPropertyWriteable;
      
      private var _useDungeonActivityForSorting:BooleanPropertyWriteable;
      
      private var _signal_titleUpdated:Signal;
      
      private var _signal_roleUpdated:Signal;
      
      private var _signal_memberCountUpdate:Signal;
      
      private var _roster:ListCollection;
      
      public function ClanInfoPopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         _useSumForSorting = new BooleanPropertyWriteable(false);
         _useDungeonActivityForSorting = new BooleanPropertyWriteable(false);
         _signal_roleUpdated = new Signal();
         _signal_memberCountUpdate = new Signal();
         super(param1);
         _clan = param1.clan.clan;
         _playerRank = param1.clan.playerRole;
         var _loc3_:Vector.<ClanMemberListPrivateValueObject> = new Vector.<ClanMemberListPrivateValueObject>();
         var _loc2_:int = _clan.members.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = createMember(_clan.members[_loc4_]);
            _loc4_++;
         }
         sortRoster(_loc3_);
         _roster = new ListCollection(_loc3_);
         _signal_titleUpdated = _clan.signal_titleUpdated;
         _clan.signal_newMember.add(handler_newClanMember);
         _clan.signal_dismissedMember.add(handler_dismissedClanMember);
         param1.clan.action_updateServerData();
         param1.clan.signal_roleUpdate.add(handler_roleUpdate);
      }
      
      override protected function dispose() : void
      {
         var _loc2_:int = 0;
         player.clan.signal_roleUpdate.remove(handler_roleUpdate);
         _clan.signal_newMember.remove(handler_newClanMember);
         _clan.signal_dismissedMember.remove(handler_dismissedClanMember);
         super.dispose();
         _signal_titleUpdated = null;
         var _loc1_:int = _roster.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            (_roster.getItemAt(_loc2_) as ClanMemberListPrivateValueObject).dispose();
            _loc2_++;
         }
      }
      
      public function get useSumForSorting() : BooleanProperty
      {
         return _useSumForSorting;
      }
      
      public function get useDungeonActivityForSorting() : BooleanProperty
      {
         return _useDungeonActivityForSorting;
      }
      
      public function get signal_iconUpdated() : Signal
      {
         return _clan.signal_iconUpdated;
      }
      
      public function get signal_titleUpdated() : Signal
      {
         return _signal_titleUpdated;
      }
      
      public function get signal_roleUpdated() : Signal
      {
         return _signal_roleUpdated;
      }
      
      public function get signal_memberCountUpdate() : Signal
      {
         return _signal_memberCountUpdate;
      }
      
      public function get title() : String
      {
         return _clan.title;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return _clan.icon;
      }
      
      public function get hasPermission_edit_admin_rank() : Boolean
      {
         return _playerRank.permission_edit_admin_rank;
      }
      
      public function get hasPermission_disband() : Boolean
      {
         return _playerRank.permission_disband;
      }
      
      public function get hasPermission_dismiss_member() : Boolean
      {
         return _playerRank.permission_dismiss_member;
      }
      
      public function get memberCount() : int
      {
         return _roster.length;
      }
      
      public function get memberCountMax() : int
      {
         var _loc1_:ClanLevel = DataStorage.level.getClanLevel(1);
         return _loc1_.maxPlayersCount;
      }
      
      public function get roster() : ListCollection
      {
         return _roster;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanInfoPopup(this);
         return _popup;
      }
      
      public function action_editMember(param1:ClanMemberListPrivateValueObject) : void
      {
         var _loc2_:ClanEditRolePopupMediator = new ClanEditRolePopupMediator(player,param1);
         _loc2_.open(Stash.click("clan_member_edit",_popup.stashParams));
      }
      
      public function action_dismissMember(param1:ClanMemberListPrivateValueObject) : void
      {
         var _loc2_:KickClanMemberPopup = new KickClanMemberPopup(param1,player.clan.clan);
         _loc2_.signal_confirm.addOnce(handler_memberDismissConfirmed);
         _loc2_.open();
      }
      
      public function action_memberProfile(param1:ClanMemberListPrivateValueObject) : void
      {
         if(param1.showProfile && GameContext.instance.platformFacade.canNavigateToSocialProfile)
         {
            GameContext.instance.platformFacade.getSocialProfileUrl(param1.userInfo.accountId).then(handler_socialProfileUrl);
         }
      }
      
      public function action_clanForge() : void
      {
         var _loc1_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(player);
         _loc1_.open(Stash.click("clan_forge",_popup.stashParams));
      }
      
      public function action_leave() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(hasPermission_disband)
         {
            if(memberCount > 1)
            {
               PopupList.instance.message(Translate.translate("UI_DIALOG_CLAN_INFO_DISBAND_MSG"));
               return;
            }
            _loc2_ = PopupList.instance.prompt(Translate.translate("UI_POPUP_CLAN_DISBAND_MSG"),Translate.translate("UI_POPUP_CLAN_DISBAND_TITLE"),Translate.translate("UI_POPUP_CLAN_DISBAND_YES"),Translate.translate("UI_POPUP_CLAN_DISBAND_NO"));
            _loc2_.signal_confirm.addOnce(handler_disbandConfirmed);
         }
         else
         {
            _loc1_ = new ClanLeaveConfirmationPopup(player.clan.clan);
            _loc1_.signal_confirm.addOnce(handler_leaveConfirmed);
            _loc1_.open();
         }
      }
      
      public function action_settings() : void
      {
         var _loc1_:ClanEditSettingsPopupMediator = new ClanEditSettingsPopupMediator(player);
         _loc1_.open(Stash.click("edit_clan_settings",_popup.stashParams));
      }
      
      public function action_addedToStage() : void
      {
         player.clan.clan.activityUpdateManager.requestUpdate();
      }
      
      public function action_switchActivityPeriod() : void
      {
         _useSumForSorting.toggle();
         updateRosterSorting();
      }
      
      public function action_switchActivityType() : void
      {
         _useDungeonActivityForSorting.toggle();
         updateRosterSorting();
      }
      
      public function get activityPeriodString() : String
      {
         _useDungeonActivityForSorting;
         return !!_useSumForSorting.value?Translate.translateArgs("UI_DIALOG_CLAN_DAYS",DataStorage.rule.clanRule.topPeriod):Translate.translate("UI_DIALOG_CLAN_INFO_TODAY");
      }
      
      public function get activityTypeString() : String
      {
         return !!_useDungeonActivityForSorting.value?Translate.translate("LIB_PSEUDO_DUNGEON_ACTIVITY"):Translate.translate("UI_DIALOG_CLAN_ACTIVITY_TAB_CLAN_POINTS");
      }
      
      public function action_showLog() : void
      {
         var _loc1_:ClanLogPopUpMediator = new ClanLogPopUpMediator(player);
         _loc1_.open(_popup.stashParams);
      }
      
      protected function updateRosterSorting() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function createMember(param1:ClanMemberValueObject) : ClanMemberListPrivateValueObject
      {
         var _loc2_:ClanMemberListPrivateValueObject = new ClanMemberListPrivateValueObject(param1,_playerRank,player);
         _loc2_.toggleActivityToShow(_useSumForSorting.value);
         return _loc2_;
      }
      
      private function sortRoster(param1:Vector.<ClanMemberListPrivateValueObject>) : void
      {
         if(_useDungeonActivityForSorting.value)
         {
            if(_useSumForSorting.value)
            {
               param1.sort(ClanMemberListValueObject.sort_byDungeonActivity);
            }
            else
            {
               param1.sort(ClanMemberListValueObject.sort_byTodayDungeonActivity);
            }
         }
         else if(_useSumForSorting.value)
         {
            param1.sort(ClanMemberListValueObject.sort_byActivity);
         }
         else
         {
            param1.sort(ClanMemberListValueObject.sort_byTodayActivity);
         }
      }
      
      private function handler_leaveConfirmed(param1:PromptPopup) : void
      {
         close();
         GameModel.instance.actionManager.clan.clanDismissMember();
      }
      
      private function handler_disbandConfirmed(param1:PromptPopup) : void
      {
         close();
         GameModel.instance.actionManager.clan.clanDisband();
      }
      
      private function handler_memberDismissConfirmed(param1:KickClanMemberPopup) : void
      {
         var _loc2_:ClanMemberListPrivateValueObject = param1.data as ClanMemberListPrivateValueObject;
         GameModel.instance.actionManager.clan.clanDismissMember(_loc2_.id);
         if(param1.doAddToBlackList)
         {
            GameModel.instance.actionManager.clan.clanAddToBlackList([_loc2_.id]);
         }
      }
      
      private function handler_newClanMember(param1:ClanMemberValueObject) : void
      {
         _roster.addItem(createMember(param1));
         _signal_memberCountUpdate.dispatch();
      }
      
      private function handler_dismissedClanMember(param1:ClanMemberValueObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = _roster.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _roster.getItemAt(_loc4_) as ClanMemberListPrivateValueObject;
            if(_loc3_.id == param1.id)
            {
               _roster.removeItemAt(_loc4_);
               break;
            }
            _loc4_++;
         }
         _signal_memberCountUpdate.dispatch();
      }
      
      private function handler_roleUpdate() : void
      {
         var _loc3_:int = 0;
         _playerRank = player.clan.playerRole;
         var _loc2_:Vector.<ClanMemberListPrivateValueObject> = new Vector.<ClanMemberListPrivateValueObject>();
         var _loc1_:int = _clan.members.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_[_loc3_] = createMember(_clan.members[_loc3_]);
            _loc3_++;
         }
         sortRoster(_loc2_);
         _roster = new ListCollection(_loc2_);
         _signal_roleUpdated.dispatch();
      }
      
      private function handler_socialProfileUrl(param1:String) : void
      {
      }
   }
}
