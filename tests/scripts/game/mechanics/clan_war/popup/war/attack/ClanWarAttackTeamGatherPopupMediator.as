package game.mechanics.clan_war.popup.war.attack
{
   import avmplus.getQualifiedClassName;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.SingleTeamGatherWithEnemyPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   
   public class ClanWarAttackTeamGatherPopupMediator extends SingleTeamGatherWithEnemyPopupMediator
   {
       
      
      private var _slot:ClanWarSlotValueObject;
      
      public function ClanWarAttackTeamGatherPopupMediator(param1:Player, param2:ClanWarSlotValueObject)
      {
         this._slot = param2;
         super(param1,MechanicStorage.CLAN_PVP);
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
      }
      
      public function get slot() : ClanWarSlotValueObject
      {
         return _slot;
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return _slot.team;
      }
      
      override public function get enemyTeamPower() : int
      {
         return _slot.teamPower;
      }
      
      override public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            player.heroes.teamData.saveClanWarsTeam(descriptionList,false,!slot.isHeroSlot);
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
            Stash.click("go",_popup.stashParams);
         }
      }
      
      override protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         if(slot.isHeroSlot && player.heroes.getById(param1.id) || !slot.isHeroSlot && player.titans.getById(param1.id))
         {
            return true;
         }
         trace(getQualifiedClassName(this),"У player нет в наличии героя с id " + param1.id + " но он выбран в качестве текущего члена команды " + activity.teamType);
         return false;
      }
      
      override protected function getDefaultTeam() : Vector.<UnitDescription>
      {
         return player.heroes.teamData.getClanWarTeam(false,!slot.isHeroSlot);
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         _loc6_ = null;
         var _loc3_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         if(slot.isHeroSlot)
         {
            _loc1_ = player.heroes.getList();
            _loc2_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new TeamGatherPopupHeroValueObject(this,UnitUtils.createEntryValueObject(_loc1_[_loc5_]));
               _loc3_.push(_loc6_);
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = player.titans.getList();
            _loc2_ = _loc4_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new TeamGatherPopupHeroValueObject(this,UnitUtils.createEntryValueObject(_loc4_[_loc5_]));
               _loc3_.push(_loc6_);
               _loc5_++;
            }
         }
         _loc3_.sort(_sortVoVect);
         return _loc3_;
      }
      
      private function handler_clanUpdate() : void
      {
         if(player.clan.clan == null)
         {
            close();
         }
      }
   }
}
