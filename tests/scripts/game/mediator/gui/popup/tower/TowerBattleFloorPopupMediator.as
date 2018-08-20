package game.mediator.gui.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.command.tower.CommandTowerNextFloor;
   import game.command.tower.CommandTowerSkipFloor;
   import game.command.tower.CommandTowerStartBattle;
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.tower.PlayerTowerBattleEnemy;
   import game.model.user.tower.PlayerTowerBattleFloor;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerBattleFloorPopup;
   import idv.cjcat.signals.Signal;
   
   public class TowerBattleFloorPopupMediator extends PopupMediator
   {
       
      
      private var battleFloor:PlayerTowerBattleFloor;
      
      private var teamGatherPopup:TowerTeamGatherPopupMediator;
      
      public const difficultyUpdated:Signal = new Signal();
      
      public function TowerBattleFloorPopupMediator(param1:Player, param2:PlayerTowerBattleFloor)
      {
         super(param1);
         this.battleFloor = param2;
      }
      
      public function get enemyNormal() : PlayerTowerBattleEnemy
      {
         return battleFloor.normalEnemy;
      }
      
      public function get enemyHard() : PlayerTowerBattleEnemy
      {
         return battleFloor.hardEnemy;
      }
      
      public function get floorLabel() : String
      {
         var _loc1_:String = Translate.translateArgs("UI_TOWER_FLOOR",floor);
         _loc1_ = _loc1_.replace("{color}","");
         return _loc1_;
      }
      
      public function get floor() : int
      {
         return player.tower.floor.value;
      }
      
      public function get canSkip() : Boolean
      {
         return player.tower.canSkipCurrentFloor && !battleFloor.completed;
      }
      
      public function get completed() : Boolean
      {
         return battleFloor.completed;
      }
      
      public function get difficulty() : TowerBattleDifficulty
      {
         return battleFloor.difficulty;
      }
      
      public function get difficultySelected() : Boolean
      {
         return battleFloor.difficultySelected;
      }
      
      public function get maySkipUpToFloor() : int
      {
         return player.tower.maySkipUpToFloor.value;
      }
      
      public function get mayBuySkip() : Boolean
      {
         return player.tower.mayBuySkip && floor <= DataStorage.rule.towerRule.maxSkipFloor;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerBattleFloorPopup(this);
         return new TowerBattleFloorPopup(this);
      }
      
      public function action_chooseDifficulty(param1:TowerBattleDifficulty) : void
      {
         if(difficultySelected)
         {
            if(this.difficulty == param1)
            {
               action_gatherTeam(param1);
            }
            else
            {
               return;
            }
         }
         else
         {
            action_gatherTeam(param1);
         }
      }
      
      public function action_gatherTeam(param1:TowerBattleDifficulty) : void
      {
         var _loc2_:PlayerTowerBattleEnemy = param1 == TowerBattleDifficulty.NORMAL?battleFloor.normalEnemy:battleFloor.hardEnemy;
         teamGatherPopup = new TowerTeamGatherPopupMediator(player,_loc2_);
         teamGatherPopup.signal_teamGatherComplete.add(handler_teamGathered);
         teamGatherPopup.open();
      }
      
      public function action_skip() : void
      {
         var _loc1_:CommandTowerSkipFloor = GameModel.instance.actionManager.tower.towerSkipFloor();
         _loc1_.onClientExecute(handler_skip);
      }
      
      public function action_nextFloor() : void
      {
         var _loc1_:CommandTowerNextFloor = GameModel.instance.actionManager.tower.towerNextFloor();
         _loc1_.onClientExecute(handler_nextFloor);
      }
      
      public function action_buySkip() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(canSkip)
         {
            _loc1_ = GameModel.instance.actionManager.tower.towerSkipFloor();
            close();
         }
         else
         {
            _loc2_ = new TowerBuySkipFloorPopupMediator(player);
            _loc2_.open(popup.stashParams);
            close();
         }
      }
      
      private function startBattle(param1:TowerTeamGatherPopupMediator) : void
      {
         var _loc2_:CommandTowerStartBattle = GameModel.instance.actionManager.tower.towerStartBattle(param1.playerEntryTeamList);
         _loc2_.onClientExecute(handler_startBattle);
      }
      
      private function handler_teamGathered(param1:TowerTeamGatherPopupMediator) : void
      {
         var _loc2_:* = null;
         if(!difficultySelected)
         {
            _loc2_ = GameModel.instance.actionManager.tower.towerStartBattleWithDifficulty(param1.playerEntryTeamList,param1.enemyDifficulty);
         }
         else
         {
            _loc2_ = GameModel.instance.actionManager.tower.towerStartBattle(param1.playerEntryTeamList);
         }
         _loc2_.onClientExecute(handler_startBattle);
      }
      
      private function handler_skip(param1:CommandTowerSkipFloor) : void
      {
         close();
      }
      
      private function handler_nextFloor(param1:CommandTowerNextFloor) : void
      {
         close();
      }
      
      private function handler_startBattle(param1:CommandTowerStartBattle) : void
      {
         close();
         if(teamGatherPopup)
         {
            teamGatherPopup.close();
         }
      }
   }
}
