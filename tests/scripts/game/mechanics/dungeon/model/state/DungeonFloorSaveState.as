package game.mechanics.dungeon.model.state
{
   import flash.utils.Dictionary;
   
   public class DungeonFloorSaveState
   {
      
      private static var states:Dictionary;
      
      public static const ALREADY_SAVED:DungeonFloorSaveState = new DungeonFloorSaveState(1);
      
      public static const CAN_SAVE:DungeonFloorSaveState = new DungeonFloorSaveState(2);
      
      public static const NOT_SAVED_YET:DungeonFloorSaveState = new DungeonFloorSaveState(3);
       
      
      private var _state:int;
      
      public function DungeonFloorSaveState(param1:int)
      {
         super();
         _state = param1;
         if(!states)
         {
            states = new Dictionary();
         }
         states[_state] = this;
      }
      
      public static function getState(param1:int) : DungeonFloorSaveState
      {
         return states[param1];
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}
