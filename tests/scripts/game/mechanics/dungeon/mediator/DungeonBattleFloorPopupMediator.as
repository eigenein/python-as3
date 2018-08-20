package game.mechanics.dungeon.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.mechanics.dungeon.model.PlayerDungeonBattleEnemy;
   import game.mechanics.dungeon.model.PlayerDungeonBattleFloor;
   import game.mechanics.dungeon.popup.battle.DungeonBattleFloorPopup;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.mediator.gui.popup.team.TeamGatherByActivityPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class DungeonBattleFloorPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var battleFloor:PlayerDungeonBattleFloor;
      
      private var teamGatherPopup:TeamGatherByActivityPopupMediator;
      
      public const difficultyUpdated:Signal = new Signal();
      
      public function DungeonBattleFloorPopupMediator(param1:Player, param2:PlayerDungeonBattleFloor)
      {
         super(param1);
         this.battleFloor = param2;
      }
      
      public function get enemy_1() : PlayerDungeonBattleEnemy
      {
         return battleFloor.enemy_1;
      }
      
      public function get enemy_2() : PlayerDungeonBattleEnemy
      {
         return battleFloor.enemy_2;
      }
      
      public function get floor() : int
      {
         return player.dungeon.floor.value;
      }
      
      public function get canSkip() : Boolean
      {
         return player.dungeon.currentFloor_canSkip;
      }
      
      public function get maySkipUpToFloor() : int
      {
         return player.tower.maySkipUpToFloor.value;
      }
      
      public function get isTitanFloor() : Boolean
      {
         return battleFloor.enemy_1.defenderType != null;
      }
      
      public function get floorLabel() : String
      {
         var _loc1_:String = Translate.translateArgs("UI_DUNGEON_FLOOR",floor);
         _loc1_ = _loc1_.replace("{color}","");
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonBattleFloorPopup(this);
         return new DungeonBattleFloorPopup(this);
      }
      
      public function action_chooseDifficulty(param1:int) : void
      {
         action_gatherTeam(param1);
      }
      
      public function action_gatherTeam(param1:int) : void
      {
         var _loc2_:PlayerDungeonBattleEnemy = param1 == 1?battleFloor.enemy_1:battleFloor.enemy_2;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.floorType.isTitanBattle)
         {
            teamGatherPopup = new DungeonTitanTeamGatherPopupMediator(player,_loc2_);
         }
         else
         {
            teamGatherPopup = new DungeonTeamGatherPopupMediator(player,_loc2_);
         }
         teamGatherPopup.signal_teamGatherComplete.add(handler_teamGathered);
         teamGatherPopup.open();
      }
      
      private function handler_teamGathered(param1:TeamGatherPopupMediator) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TeamGatherByActivityPopupMediator = param1 as TeamGatherByActivityPopupMediator;
         if(_loc4_ is DungeonTeamGatherPopupMediator)
         {
            _loc3_ = (_loc4_ as DungeonTeamGatherPopupMediator).enemyIndex;
         }
         else if(_loc4_ is DungeonTitanTeamGatherPopupMediator)
         {
            _loc3_ = (_loc4_ as DungeonTitanTeamGatherPopupMediator).enemyIndex;
         }
         var _loc2_:DungeonStartBattleRoutine = new DungeonStartBattleRoutine(player,_loc4_.playerUnitEntryTeamList,_loc3_,popup.stashParams);
         _loc2_.signal_battleIsInProgress.add(handler_battleIsInProgress);
         _loc2_.start();
      }
      
      private function handler_battleIsInProgress() : void
      {
         close();
         if(teamGatherPopup)
         {
            teamGatherPopup.close();
            teamGatherPopup = null;
         }
      }
   }
}
