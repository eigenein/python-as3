package game.mechanics.dungeon.model
{
   import game.mechanics.dungeon.storage.DungeonFloorDescription;
   import game.mechanics.dungeon.storage.DungeonFloorType;
   
   public class PlayerDungeonFloor
   {
       
      
      private var _desc:DungeonFloorDescription;
      
      public function PlayerDungeonFloor()
      {
         super();
      }
      
      public function get desc() : DungeonFloorDescription
      {
         return _desc;
      }
      
      public function get type() : DungeonFloorType
      {
         return _desc.type;
      }
      
      public function parseRawData(param1:*) : void
      {
         updateState(param1);
      }
      
      public function updateState(param1:*) : void
      {
      }
      
      public function updateDescription(param1:DungeonFloorDescription) : void
      {
         this._desc = param1;
      }
   }
}
