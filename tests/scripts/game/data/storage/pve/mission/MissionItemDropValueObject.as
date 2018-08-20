package game.data.storage.pve.mission
{
   import game.data.storage.DataStorage;
   import game.data.storage.world.WorldMapDescription;
   
   public class MissionItemDropValueObject
   {
       
      
      private var _world:WorldMapDescription;
      
      private var _enabled:Boolean;
      
      private var _mission:MissionDescription;
      
      public function MissionItemDropValueObject(param1:MissionDescription, param2:Boolean)
      {
         super();
         this._enabled = param2;
         this._mission = param1;
         this._world = DataStorage.world.getById(_mission.world) as WorldMapDescription;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get mission() : MissionDescription
      {
         return _mission;
      }
      
      public function get name() : String
      {
         return _mission.name;
      }
      
      public function get worldName() : String
      {
         return _world.nameShort;
      }
      
      public function get teamLevel() : int
      {
         return _world.teamLevel;
      }
   }
}
