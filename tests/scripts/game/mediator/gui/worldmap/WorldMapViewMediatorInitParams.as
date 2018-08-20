package game.mediator.gui.worldmap
{
   import game.data.storage.DataStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.model.user.Player;
   
   public class WorldMapViewMediatorInitParams
   {
      
      private static var _defaultConfig:WorldMapViewMediatorInitParams;
       
      
      private var _world:WorldMapDescription;
      
      private var _mission:MissionDescription;
      
      public function WorldMapViewMediatorInitParams()
      {
         super();
      }
      
      public static function createWithMission(param1:MissionDescription, param2:Boolean = false) : WorldMapViewMediatorInitParams
      {
         var _loc3_:WorldMapViewMediatorInitParams = new WorldMapViewMediatorInitParams();
         _loc3_.mission = param1;
         _loc3_._world = DataStorage.world.getById(param1.world) as WorldMapDescription;
         return _loc3_;
      }
      
      public static function createWithWorld(param1:WorldMapDescription) : WorldMapViewMediatorInitParams
      {
         var _loc2_:WorldMapViewMediatorInitParams = new WorldMapViewMediatorInitParams();
         _loc2_.world = param1;
         return _loc2_;
      }
      
      public static function createDefault(param1:Player) : WorldMapViewMediatorInitParams
      {
         var _loc2_:WorldMapViewMediatorInitParams = new WorldMapViewMediatorInitParams();
         var _loc3_:WorldMapDescription = param1.missions.getCurrentWorldMap();
         if(!_loc3_)
         {
            _loc3_ = DataStorage.world.getById(1) as WorldMapDescription;
         }
         _loc2_.world = _loc3_;
         return _loc2_;
      }
      
      public function get world() : WorldMapDescription
      {
         return _world;
      }
      
      public function set world(param1:WorldMapDescription) : void
      {
         _world = param1;
         _mission = null;
      }
      
      public function get mission() : MissionDescription
      {
         return _mission;
      }
      
      public function set mission(param1:MissionDescription) : void
      {
         _mission = param1;
      }
   }
}
