package game.mechanics.clan_war.mediator
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarMemberFullInfoValueObject;
   import game.mechanics.clan_war.model.PlayerClanWarCurrentInfo;
   import game.mechanics.clan_war.popup.members.ActiveClanWarMembersPopup;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.model.user.clan.ClanBasicInfoValueObject;
   import game.model.user.clan.ClanMemberValueObject;
   import game.view.popup.PopupBase;
   
   public class ActiveClanWarMembersPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var ourClan:Boolean;
      
      private var _triesLeftTotal:IntPropertyWriteable;
      
      public function ActiveClanWarMembersPopupMediator(param1:Player, param2:Boolean = true)
      {
         _triesLeftTotal = new IntPropertyWriteable();
         super(param1);
         this.ourClan = param2;
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
         return DataStorage.rule.clanWarRule.maxWarriors;
      }
      
      public function get clan() : ClanBasicInfoValueObject
      {
         if(ourClan)
         {
            return player.clan.clanWarData.currentWar.participant_us.info;
         }
         return player.clan.clanWarData.currentWar.participant_them.info;
      }
      
      public function get pointsEarned() : int
      {
         if(ourClan)
         {
            return player.clan.clanWarData.currentWar.participant_us.pointsEarned;
         }
         return player.clan.clanWarData.currentWar.participant_them.pointsEarned;
      }
      
      public function get triesLeftTotal() : IntProperty
      {
         var _loc1_:PlayerClanWarCurrentInfo = player.clan.clanWarData.currentWar;
         if(!_loc1_)
         {
            return new IntProperty();
         }
         if(ourClan)
         {
            return _loc1_.ourClanTries.displayValue_triesLeft;
         }
         return _loc1_.enemyClanTries.displayValue_triesLeft;
      }
      
      public function get triesMax() : int
      {
         var _loc1_:PlayerClanWarCurrentInfo = player.clan.clanWarData.currentWar;
         if(!_loc1_)
         {
            return 0;
         }
         if(ourClan)
         {
            return _loc1_.ourClanTries.displayValue_maxTries.value;
         }
         return _loc1_.enemyClanTries.displayValue_maxTries.value;
      }
      
      public function get members() : Vector.<ClanWarMemberFullInfoValueObject>
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:Vector.<ClanWarMemberFullInfoValueObject> = new Vector.<ClanWarMemberFullInfoValueObject>();
         var _loc3_:PlayerClanWarCurrentInfo = player.clan.clanWarData.currentWar;
         if(ourClan)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.participant_us.info.members.length)
            {
               _loc2_ = _loc3_.participant_us.info.members[_loc5_];
               if(_loc3_.ourClanTries.getUserIsParticipant(_loc2_.id))
               {
                  _loc4_ = new ClanWarMemberFullInfoValueObject(_loc2_,_loc3_.getOurUserTeam(_loc2_.id,true),_loc3_.getOurUserTeam(_loc2_.id,false));
                  _loc4_.warrior = true;
                  _loc4_.setTries(_loc3_.ourClanTries.getUserTries(_loc2_.id));
                  _loc4_.triesMax = _loc3_.ourClanTries.userTriesMax;
                  _loc1_.push(_loc4_);
               }
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.participant_them.info.members.length)
            {
               _loc2_ = _loc3_.participant_them.info.members[_loc5_];
               if(_loc3_.enemyClanTries.getUserIsParticipant(_loc2_.id))
               {
                  _loc4_ = new ClanWarMemberFullInfoValueObject(_loc2_,_loc3_.getEnemyUserTeam(_loc2_.id,true),_loc3_.getEnemyUserTeam(_loc2_.id,false));
                  _loc4_.warrior = true;
                  _loc4_.setTries(_loc3_.enemyClanTries.getUserTries(_loc2_.id));
                  _loc4_.triesMax = _loc3_.enemyClanTries.userTriesMax;
                  _loc1_.push(_loc4_);
               }
               _loc5_++;
            }
         }
         _loc1_.sort(clanWarMembersSort);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ActiveClanWarMembersPopup(this);
         return _popup;
      }
      
      private function clanWarMembersSort(param1:ClanWarMemberFullInfoValueObject, param2:ClanWarMemberFullInfoValueObject) : int
      {
         return param2.getHeroesAndTitansPower() - param1.getHeroesAndTitansPower();
      }
   }
}
