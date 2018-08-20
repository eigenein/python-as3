package game.mechanics.dungeon.model
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import flash.utils.Dictionary;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.model.state.DungeonFloorElementalGroup;
   import game.mechanics.dungeon.model.state.DungeonFloorSaveState;
   
   public class PlayerDungeonBattleFloor extends PlayerDungeonFloor
   {
       
      
      private var enemies:Dictionary;
      
      protected var _state_battle:ObjectPropertyWriteable;
      
      private var _state_save:ObjectPropertyWriteable;
      
      private var _elements:DungeonFloorElementalGroup;
      
      public function PlayerDungeonBattleFloor()
      {
         enemies = new Dictionary();
         _state_battle = new ObjectPropertyWriteable(DungeonFloorBattleState);
         _state_save = new ObjectPropertyWriteable(DungeonFloorSaveState);
         super();
      }
      
      public function get enemy_1() : PlayerDungeonBattleEnemy
      {
         return enemies[0];
      }
      
      public function get enemy_2() : PlayerDungeonBattleEnemy
      {
         return enemies[1];
      }
      
      public function get state_battle() : ObjectProperty
      {
         return _state_battle;
      }
      
      public function get state_save() : ObjectProperty
      {
         return _state_save;
      }
      
      public function get elements() : DungeonFloorElementalGroup
      {
         return _elements;
      }
      
      public function getEnemyByIndex(param1:int) : PlayerDungeonBattleEnemy
      {
         return enemies[param1];
      }
      
      override public function updateState(param1:*) : void
      {
         PlayerDungeonData.__print("battleStateUpdate");
         _state_battle.value = DungeonFloorBattleState.getState(param1.state);
         var _loc2_:* = (_state_battle.value as DungeonFloorBattleState).state == DungeonFloorBattleState.BATTLE_FINISHED.state;
         var _loc3_:* = _state_save.value == DungeonFloorSaveState.NOT_SAVED_YET;
         if(_loc2_ && _loc3_)
         {
            _state_save.value = DungeonFloorSaveState.CAN_SAVE;
         }
      }
      
      override public function parseRawData(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.parseRawData(param1);
         if(param1.userData)
         {
            _loc2_ = param1.userData.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               parseEnemy(param1.userData[_loc3_],_loc3_);
               _loc3_++;
            }
         }
         _elements = new DungeonFloorElementalGroup(enemy_1.attackerType,!!enemy_2?enemy_2.attackerType:null);
      }
      
      public function setCompleted() : void
      {
         _state_battle.value = DungeonFloorBattleState.BATTLE_FINISHED;
      }
      
      public function setSaveState(param1:DungeonFloorSaveState) : void
      {
         _state_save.value = param1;
      }
      
      private function parseEnemy(param1:*, param2:int) : PlayerDungeonBattleEnemy
      {
         var _loc3_:PlayerDungeonBattleEnemy = new PlayerDungeonBattleEnemy(param1,this,param2);
         enemies[param2] = _loc3_;
         return _loc3_;
      }
   }
}
