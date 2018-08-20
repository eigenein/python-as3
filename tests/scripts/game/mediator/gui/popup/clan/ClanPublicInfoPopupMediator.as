package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.clan.CommandClanJoin;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.level.ClanLevel;
   import game.data.storage.refillable.RefillableDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.clan.info.ClanMemberListValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanPublicInfoPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanPublicInfoPopupMediator extends PopupMediator
   {
       
      
      private const _useSumActivityForSorting:Boolean = true;
      
      private var vo:ClanValueObject;
      
      private var _members:Vector.<ClanMemberListValueObject>;
      
      private var _membersListCollection:ListCollection;
      
      private var _signal_clanJoin:Signal;
      
      public function ClanPublicInfoPopupMediator(param1:ClanValueObject, param2:Player)
      {
         var _loc4_:int = 0;
         _signal_clanJoin = new Signal();
         super(param2);
         this.vo = param1;
         _members = new Vector.<ClanMemberListValueObject>();
         var _loc3_:int = param1.members.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _members.push(createMember(param1.members[_loc4_]));
            _loc4_++;
         }
         sortRoster(_members);
         _membersListCollection = new ListCollection(_members);
      }
      
      override protected function dispose() : void
      {
         _signal_clanJoin.clear();
         super.dispose();
      }
      
      public function get minTeamLevel() : int
      {
         return vo.minLevel;
      }
      
      public function get membersListCollection() : ListCollection
      {
         return _membersListCollection;
      }
      
      public function get title() : String
      {
         return vo.title;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return vo.icon;
      }
      
      public function get memberCount() : int
      {
         return vo.membersCount;
      }
      
      public function get memberCountMax() : int
      {
         var _loc1_:ClanLevel = DataStorage.level.getClanLevel(1);
         return _loc1_.maxPlayersCount;
      }
      
      public function get canJoin() : Boolean
      {
         if(player.clan.clan)
         {
            return false;
         }
         return vo.minLevel <= player.levelData.level.level && vo.membersCount < vo.maxMembersCount && playerServerId == clanServerId;
      }
      
      public function get canJoinMessage() : String
      {
         if(playerServerId == clanServerId)
         {
            if(player.clan.clan)
            {
               if(player.clan.clan.id == vo.id)
               {
                  return Translate.translate("UI_DIALOG_CLAN_INFO_PUBLIC_TF_ALREADY_MEMBER");
               }
               return Translate.translate("UI_DIALOG_CLAN_INFO_PUBLIC_TF_ALREADY_MEMBER_OF_ANOTHER");
            }
            if(vo.minLevel > player.levelData.level.level)
            {
               return Translate.translate("UI_DIALOG_CLAN_INFO_PUBLIC_TF_NOT_ENOUGH_LVL");
            }
            if(vo.membersCount >= vo.maxMembersCount)
            {
               return Translate.translate("UI_DIALOG_CLAN_INFO_PUBLIC_TF_FULL_CLAN");
            }
            return "";
         }
         return Translate.translate("UI_DIALOG_CLAN_INFO_PUBLIC_TF_ANOTHER_SERVER");
      }
      
      public function get signal_clanJoin() : Signal
      {
         return _signal_clanJoin;
      }
      
      public function get activityPeriodString() : String
      {
         return Translate.translateArgs("UI_DIALOG_CLAN_DAYS",DataStorage.rule.clanRule.topPeriod);
      }
      
      public function get clanServerId() : int
      {
         if(vo && vo.members && vo.members.length)
         {
            return vo.members[0].serverId;
         }
         return 0;
      }
      
      public function get playerServerId() : int
      {
         return player.serverId;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanPublicInfoPopup(this);
         return _popup;
      }
      
      public function action_join() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:RefillableDescription = DataStorage.refillable.getByIdent("clanReenter_cooldown");
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(_loc4_.id);
         if(_loc1_.value)
         {
            _loc3_ = GameModel.instance.actionManager.clan.clanJoin(vo.id);
            _loc3_.onClientExecute(handler_clanJoined);
         }
         else
         {
            _loc2_ = PopupList.instance.popup_clan_enter_cooldown(vo,_popup.stashParams);
            _loc2_.signal_cooldownSkipped.addOnce(handler_cooldownSkipped);
         }
      }
      
      private function createMember(param1:ClanMemberValueObject) : ClanMemberListValueObject
      {
         var _loc2_:ClanMemberListValueObject = new ClanMemberListValueObject(param1);
         _loc2_.toggleActivityToShow(true);
         return _loc2_;
      }
      
      private function sortRoster(param1:Vector.<ClanMemberListValueObject>) : void
      {
         param1.sort(ClanMemberListValueObject.sort_byActivity);
      }
      
      private function handler_clanJoined(param1:CommandClanJoin) : void
      {
         var _loc2_:* = null;
         if(param1.isSucceeded)
         {
            _loc2_ = new ClanInfoPopupMediator(player);
            _loc2_.open(Stash.click("clan_info",_popup.stashParams));
            _signal_clanJoin.dispatch();
            close();
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_CLAN_JOIN_MESSAGE_FULL"));
         }
      }
      
      private function handler_cooldownSkipped(param1:ClanEnterCooldownPopupMediator) : void
      {
         action_join();
      }
   }
}
