package game.mechanics.dungeon.mediator
{
   import battle.data.HeroState;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.dungeon.model.PlayerDungeonBattleEnemy;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.team.StateBasedTeamGatherPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.team.TowerTeamGatherPopup;
   
   public class DungeonTitanTeamGatherPopupMediator extends StateBasedTeamGatherPopupMediator
   {
       
      
      private var _enemy:PlayerDungeonBattleEnemy;
      
      public function DungeonTitanTeamGatherPopupMediator(param1:Player, param2:PlayerDungeonBattleEnemy)
      {
         _enemy = param2;
         super(param1,MechanicStorage.CLAN_DUNGEON);
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
      }
      
      override public function get text_dialogCaption() : String
      {
         if(_enemy.floorType.isTitanBattle)
         {
            return Translate.translate("UI_TOWER_TEAM_GATHER_TITLE_TITAN_" + _enemy.attackerType.ident.toUpperCase());
         }
         return Translate.translate("UI_TOWER_TEAM_GATHER_TITLE");
      }
      
      public function get enemyIndex() : int
      {
         return _enemy.index;
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return _enemy.heroes;
      }
      
      override public function get enemyTeamPower() : int
      {
         return _enemy.power;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerTeamGatherPopup(this);
         return _popup;
      }
      
      override public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            player.heroes.teamData.saveTeamByDungeonElement(descriptionList,_enemy.attackerType);
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
            Stash.click("go",_popup.stashParams);
         }
      }
      
      override protected function getDefaultTeam() : Vector.<UnitDescription>
      {
         return player.heroes.teamData.getByDungeonElement(_enemy.attackerType);
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc2_:* = undefined;
         _loc2_ = undefined;
         var _loc3_:* = null;
         _loc3_ = null;
         if(_enemy.floorType.isTitanBattle)
         {
            _loc2_ = player.dungeon.createTitanList(this,_enemy,player);
            _loc2_.sort(_sortVoVect);
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc1_ in _loc2_)
            {
               _loc3_ = isHeroUnavailable(_loc1_);
               if(_loc3_)
               {
                  _loc1_.setUnavailable(_loc3_);
               }
            }
         }
         else
         {
            _loc2_ = player.dungeon.createHeroList(this,player);
            _loc2_.sort(_sortVoVect);
            var _loc7_:int = 0;
            var _loc6_:* = _loc2_;
            for each(_loc1_ in _loc2_)
            {
               _loc3_ = isHeroUnavailable(_loc1_);
               if(_loc3_)
               {
                  _loc1_.setUnavailable(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      override protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         var _loc4_:HeroState = player.dungeon.teamState_titans.getHeroState(param1.id);
         if(_loc4_ && _loc4_.isDead)
         {
            return false;
         }
         return true;
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
