package game.mechanics.dungeon.model.state
{
   import flash.utils.Dictionary;
   
   public class DungeonFloorBattleState
   {
      
      private static var states:Dictionary;
      
      public static const BATTLE_CAN_START:DungeonFloorBattleState = new DungeonFloorBattleState(1);
      
      public static const BATTLE_FINISHED:DungeonFloorBattleState = new DungeonFloorBattleState(2);
      
      public static const BATTLE_CAN_NOT_START_YET:DungeonFloorBattleState = new DungeonFloorBattleState(-1);
       
      
      private var _state:int;
      
      public function DungeonFloorBattleState(param1:int)
      {
         super();
         _state = param1;
         if(!states)
         {
            states = new Dictionary();
         }
         states[_state] = this;
      }
      
      public static function getState(param1:int) : DungeonFloorBattleState
      {
         return states[param1];
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}
