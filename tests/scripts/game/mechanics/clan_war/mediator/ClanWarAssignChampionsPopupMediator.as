package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarMemberFullInfoValueObject;
   import game.mechanics.clan_war.popup.members.ClanWarAssignChampionsPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClanWarAssignChampionsPopupMediator extends ClanPopupMediatorBase
   {
       
      
      public const members:ListCollection = new ListCollection();
      
      public const signal_countWarriorsChanged:Signal = new Signal();
      
      public function ClanWarAssignChampionsPopupMediator(param1:Player)
      {
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         super(param1);
         if(param1.clan.clan)
         {
            _loc3_ = new Vector.<ClanWarMemberFullInfoValueObject>();
            _loc2_ = param1.clan.clan.members;
            _loc6_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_.push(createMember(_loc2_[_loc5_]));
               _loc5_++;
            }
            _loc3_.sort(clanWarMembersSort);
            param1.clan.clan.signal_newMember.add(handler_newClanMember);
            param1.clan.clan.signal_dismissedMember.add(handler_dismissedClanMember);
            members.data = _loc3_;
         }
         param1.clan.clanWarData.signal_warriorsUpdate.add(handler_warriorsUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.clanWarData.signal_warriorsUpdate.remove(handler_warriorsUpdate);
         if(player.clan.clan)
         {
            player.clan.clan.signal_newMember.remove(handler_newClanMember);
            player.clan.clan.signal_dismissedMember.remove(handler_dismissedClanMember);
         }
         super.dispose();
      }
      
      public function get title_master() : String
      {
         return "^{252 252 249}^" + player.clan.clan.roleNames.displayedTitle_leader + "^{252 229 183}^";
      }
      
      public function get title_warlord() : String
      {
         return "^{252 252 249}^" + player.clan.clan.roleNames.displayedTitle_warlord + "^{252 229 183}^";
      }
      
      public function get maxWarriorCount() : int
      {
         return DataStorage.clanWar.getLeagueById(player.clan.clan.clanWarLeagueId).maxChampions;
      }
      
      public function get countWarriors() : int
      {
         return player.clan.clanWarData.warriorsCount;
      }
      
      public function get playerClan() : ClanPrivateInfoValueObject
      {
         return player.clan.clan;
      }
      
      public function get property_playerPermission_defenseManagement() : BooleanProperty
      {
         return player.clan.clanWarData.property_playerPermission_defenseManagement;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarAssignChampionsPopup(this);
         return _popup;
      }
      
      public function action_clanWarEnableWarrior(param1:ClanWarMemberFullInfoValueObject, param2:Boolean) : void
      {
         var _loc6_:* = null;
         var _loc4_:Boolean = false;
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(param2 && countWarriors >= maxWarriorCount)
         {
            param1.warrior = !param2;
            PopupList.instance.message(Translate.translateArgs("UI_CLAN_WAR_CHAMPIONS_LIMIT",maxWarriorCount));
         }
         else if(param2)
         {
            param1.warrior = param2;
            executeCommandClanWarEnableWarrior(param1);
         }
         else
         {
            _loc6_ = "";
            _loc4_ = false;
            if(param1.defenderHeroes && param1.defenderHeroes.currentSlotDesc)
            {
               _loc6_ = _loc6_ + (Translate.translateArgs("UI_CLAN_WAR_MEMBERS_POSITION",param1.defenderHeroes.currentSlotDesc.fortificationDesc.name,param1.defenderHeroes.currentSlotDesc.index + 1) + " (" + Translate.translate("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDERS_HEROES").toLowerCase() + ")");
               _loc4_ = true;
            }
            if(param1.defenderTitans && param1.defenderTitans.currentSlotDesc)
            {
               if(_loc6_.length)
               {
                  _loc6_ = _loc6_ + "\n";
               }
               _loc6_ = _loc6_ + (Translate.translateArgs("UI_CLAN_WAR_MEMBERS_POSITION",param1.defenderTitans.currentSlotDesc.fortificationDesc.name,param1.defenderTitans.currentSlotDesc.index + 1) + " (" + Translate.translate("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDERS_TITANS").toLowerCase() + ")");
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _loc3_ = Translate.translateArgs("UI_CLAN_WAR_MEMBERS_UNSET_CHAMPION_STATUS",ColorUtils.hexToRGBFormat(16645626) + _loc6_ + ColorUtils.hexToRGBFormat(16568453));
               _loc5_ = PopupList.instance.prompt(_loc3_,null,Translate.translate("UI_COMMON_OK"),Translate.translate("UI_COMMON_CANCEL"));
               _loc5_.data = param1;
               _loc5_.signal_confirm.add(handler_clanWarEnableWarriorConfirm);
               _loc5_.signal_cancel.add(handler_clanWarEnableWarriorCancel);
            }
            else
            {
               param1.warrior = param2;
               executeCommandClanWarEnableWarrior(param1);
            }
         }
      }
      
      public function executeCommandClanWarEnableWarrior(param1:ClanWarMemberFullInfoValueObject) : void
      {
         if(param1.warrior)
         {
            player.clan.clanWarData.action_clanWarEnableWarrior([param1.user.id],[]);
         }
         else
         {
            player.clan.clanWarData.action_clanWarEnableWarrior([],[param1.user.id]);
         }
      }
      
      protected function createMember(param1:ClanMemberValueObject) : ClanWarMemberFullInfoValueObject
      {
         var _loc2_:* = null;
         _loc2_ = new ClanWarMemberFullInfoValueObject(param1,player.clan.clanWarData.getDefenderByUid(param1.id,true),player.clan.clanWarData.getDefenderByUid(param1.id,false));
         updateMember(_loc2_);
         return _loc2_;
      }
      
      protected function updateMember(param1:ClanWarMemberFullInfoValueObject) : void
      {
         if(!param1)
         {
            return;
         }
         param1.warrior = player.clan.clanWarData.getUserIsWarrior(param1.user);
      }
      
      private function clanWarMembersSort(param1:ClanWarMemberFullInfoValueObject, param2:ClanWarMemberFullInfoValueObject) : int
      {
         return param2.getHeroesAndTitansPower() - param1.getHeroesAndTitansPower();
      }
      
      private function handler_warriorsUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = members.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            updateMember(members.getItemAt(_loc1_) as ClanWarMemberFullInfoValueObject);
            _loc1_++;
         }
         signal_countWarriorsChanged.dispatch();
      }
      
      private function handler_newClanMember(param1:ClanMemberValueObject) : void
      {
         members.addItem(createMember(param1));
         signal_countWarriorsChanged.dispatch();
      }
      
      private function handler_dismissedClanMember(param1:ClanMemberValueObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = members.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = members.getItemAt(_loc3_) as ClanWarMemberFullInfoValueObject;
            if(_loc2_.user.id == param1.id)
            {
               members.removeItemAt(_loc3_);
               break;
            }
            _loc3_++;
         }
         signal_countWarriorsChanged.dispatch();
      }
      
      private function handler_clanWarEnableWarriorConfirm(param1:PromptPopup) : void
      {
         var _loc2_:ClanWarMemberFullInfoValueObject = param1.data as ClanWarMemberFullInfoValueObject;
         if(_loc2_)
         {
            _loc2_.warrior = !_loc2_.warrior;
            executeCommandClanWarEnableWarrior(_loc2_);
         }
         param1.signal_confirm.remove(handler_clanWarEnableWarriorConfirm);
      }
      
      private function handler_clanWarEnableWarriorCancel(param1:PromptPopup) : void
      {
         var _loc2_:ClanWarMemberFullInfoValueObject = param1.data as ClanWarMemberFullInfoValueObject;
         if(_loc2_)
         {
            _loc2_.warrior = _loc2_.warrior;
         }
         param1.signal_confirm.remove(handler_clanWarEnableWarriorCancel);
      }
   }
}
