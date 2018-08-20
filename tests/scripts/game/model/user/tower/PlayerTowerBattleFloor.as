package game.model.user.tower
{
   import flash.utils.Dictionary;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.data.storage.tower.TowerFloorDescription;
   import game.data.storage.tower.TowerFloorType;
   
   public class PlayerTowerBattleFloor extends PlayerTowerFloor
   {
      
      private static const STATE_SELECT_ENEMY:int = 0;
      
      private static const STATE_BATTLE:int = 1;
      
      private static const STATE_COMPLETE:int = 2;
       
      
      private var potencialEnemies:Dictionary;
      
      private var currentDefenders;
      
      private var selectedDifficulty:TowerBattleDifficulty;
      
      private var state:int;
      
      public function PlayerTowerBattleFloor()
      {
         potencialEnemies = new Dictionary();
         super();
      }
      
      override public function get canProceed() : Boolean
      {
         return state == 2;
      }
      
      override public function get canInteract() : Boolean
      {
         return state != 2;
      }
      
      override public function get type() : TowerFloorType
      {
         return TowerFloorType.BATTLE;
      }
      
      public function get difficultySelected() : Boolean
      {
         return state > 0;
      }
      
      public function get canFight() : Boolean
      {
         return state == 1;
      }
      
      public function get completed() : Boolean
      {
         return state == 2;
      }
      
      public function get normalEnemy() : PlayerTowerBattleEnemy
      {
         return potencialEnemies[TowerBattleDifficulty.NORMAL];
      }
      
      public function get hardEnemy() : PlayerTowerBattleEnemy
      {
         return potencialEnemies[TowerBattleDifficulty.HARD];
      }
      
      public function get difficulty() : TowerBattleDifficulty
      {
         return selectedDifficulty;
      }
      
      override public function parseRawData(param1:*) : void
      {
         updateState(param1);
         if(param1.userData)
         {
            parseEnemy(param1,TowerBattleDifficulty.NORMAL);
            parseEnemy(param1,TowerBattleDifficulty.HARD);
         }
      }
      
      public function updateState(param1:*) : void
      {
         PlayerTowerData.__print("battleStateUpdate");
         currentDefenders = param1.defenders;
         if(param1.difficulty)
         {
            selectedDifficulty = TowerBattleDifficulty.fromInt(param1.difficulty);
         }
         else
         {
            selectedDifficulty = null;
         }
         state = param1.state;
      }
      
      override public function updateDescription(param1:TowerFloorDescription) : void
      {
         this.desc = param1;
      }
      
      public function chooseDifficulty(param1:TowerBattleDifficulty) : void
      {
         if(!param1)
         {
            return;
         }
         selectedDifficulty = param1;
         state = 1;
      }
      
      public function setCompleted() : void
      {
         state = 2;
         signal_updateCanProceed.dispatch();
      }
      
      private function parseEnemy(param1:*, param2:TowerBattleDifficulty) : PlayerTowerBattleEnemy
      {
         var _loc3_:* = undefined;
         var _loc4_:* = param1.userData[param2.value];
         if(param1.users)
         {
            _loc3_ = param1.users[_loc4_.userId];
         }
         var _loc5_:int = desc.pointReward;
         var _loc6_:PlayerTowerBattleEnemy = new PlayerTowerBattleEnemy(_loc3_,_loc4_,param2,_loc5_);
         potencialEnemies[param2] = _loc6_;
         return _loc6_;
      }
   }
}
