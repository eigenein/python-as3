package game.mediator.gui.worldmap
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.mission.MissionEnterPopupMediator;
   import game.model.user.Player;
   import game.model.user.mission.PlayerMissionEntry;
   import game.stat.Stash;
   import game.view.gui.worldmap.WorldMapView;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class WorldMapViewMediator extends PopupMediator
   {
       
      
      private var _worldMap:WorldMapListValueObject;
      
      private var _signal_worldSelect:Signal;
      
      private var _currentMission:MissionDescription;
      
      private var _listCollection:ListCollection;
      
      public function WorldMapViewMediator(param1:Player, param2:WorldMapViewMediatorInitParams = null)
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         _signal_worldSelect = new Signal(WorldMapListValueObject);
         super(param1);
         param1.missions.signal_newMissionEntry.add(handler_newMissionEntry);
         param1.missions.signal_missionProgress.add(handler_missionProgress);
         if(!param2)
         {
            param2 = WorldMapViewMediatorInitParams.createDefault(param1);
         }
         if(param2.mission)
         {
            _currentMission = param2.mission;
         }
         else
         {
            _currentMission = param1.missions.getNextPlayableMission();
         }
         _listCollection = new ListCollection();
         var _loc4_:Vector.<WorldMapDescription> = DataStorage.world.getList();
         var _loc3_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = new WorldMapListValueObject(_loc4_[_loc5_],this,param1);
            _listCollection.addItem(_loc6_);
            _loc5_++;
         }
         setWorld(param2.world);
         param1.billingData.bundleData.signal_update.add(handler_bundleUpdate);
      }
      
      override public function close() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         player.billingData.bundleData.signal_update.remove(handler_bundleUpdate);
         player.missions.signal_missionProgress.remove(handler_missionProgress);
         player.missions.signal_newMissionEntry.remove(handler_newMissionEntry);
         var _loc1_:int = _listCollection.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _listCollection.getItemAt(_loc2_) as WorldMapListValueObject;
            _loc3_.dispose();
            _loc2_++;
         }
         super.close();
      }
      
      public function get worldMap() : WorldMapListValueObject
      {
         return _worldMap;
      }
      
      public function get signal_worldSelect() : Signal
      {
         return _signal_worldSelect;
      }
      
      public function get title() : String
      {
         return _worldMap.desc.nameFull;
      }
      
      public function get currentMission() : MissionDescription
      {
         return _currentMission;
      }
      
      public function get listCollection() : ListCollection
      {
         return _listCollection;
      }
      
      public function get nextWorld() : WorldMapDescription
      {
         var _loc1_:int = _worldMap.desc.id + 1;
         var _loc2_:WorldMapDescription = DataStorage.world.getById(_loc1_) as WorldMapDescription;
         return _loc2_;
      }
      
      public function get prevWorld() : WorldMapDescription
      {
         var _loc1_:int = _worldMap.desc.id - 1;
         var _loc2_:WorldMapDescription = DataStorage.world.getById(_loc1_) as WorldMapDescription;
         return _loc2_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new WorldMapView(this);
         return _popup;
      }
      
      public function action_selectMission(param1:WorldMapViewMissionValueObject) : void
      {
         var _loc4_:* = null;
         var _loc2_:WorldMapDescription = DataStorage.world.getById(param1.mission.world) as WorldMapDescription;
         if(player.levelData.level.level < _loc2_.teamLevel)
         {
            PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",_loc2_.teamLevel));
            return;
         }
         if(player.billingData.bundleData.activeBundle && player.billingData.bundleData.activeBundle.desc.requirement_missionId)
         {
            _loc4_ = player.billingData.bundleData.activeBundle.desc;
            if(param1.mission.id == _loc4_.requirement_missionId)
            {
               Game.instance.navigator.navigateToBundle(_popup.stashParams);
               return;
            }
         }
         var _loc3_:MissionEnterPopupMediator = new MissionEnterPopupMediator(player,param1.mission);
         _loc3_.open(Stash.click("mission_enter",_popup.stashParams));
         _loc3_.signal_startMission.addOnce(handler_startMission);
      }
      
      public function action_navigateForward() : void
      {
         setWorld(nextWorld);
      }
      
      public function action_navigateBack() : void
      {
         setWorld(prevWorld);
      }
      
      public function getMapIndex(param1:WorldMapDescription) : int
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = _listCollection.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _listCollection.getItemAt(_loc3_) as WorldMapListValueObject;
            if(_loc4_.desc == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function setWorld(param1:WorldMapDescription) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1)
         {
            _loc2_ = getMapIndex(param1);
            if(_loc2_ == -1)
            {
               _loc3_ = new WorldMapListValueObject(param1,this,player);
               _listCollection_insertMap(_loc3_);
            }
            else
            {
               _loc3_ = _listCollection.getItemAt(_loc2_) as WorldMapListValueObject;
            }
            _worldMap = _loc3_;
            _signal_worldSelect.dispatch(_loc3_);
         }
      }
      
      private function _listCollection_insertMap(param1:WorldMapListValueObject) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = 0;
         var _loc3_:int = _listCollection.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _listCollection.getItemAt(_loc5_) as WorldMapListValueObject;
            if(_loc2_.desc.id <= param1.desc.id)
            {
               _loc4_ = _loc5_;
               _loc5_++;
               continue;
            }
            break;
         }
         _listCollection.addItemAt(param1,_loc4_);
      }
      
      private function handler_newMissionEntry(param1:PlayerMissionEntry) : void
      {
         var _loc2_:WorldMapDescription = DataStorage.world.getById(param1.desc.world) as WorldMapDescription;
         var _loc3_:WorldMapListValueObject = _listCollection.getItemAt(getMapIndex(_loc2_)) as WorldMapListValueObject;
         if(_loc3_)
         {
            _loc3_.internal_handleNewPlayerMission(param1);
         }
      }
      
      private function handler_missionProgress(param1:PlayerMissionEntry) : void
      {
         var _loc3_:WorldMapDescription = DataStorage.world.getById(param1.desc.world) as WorldMapDescription;
         var _loc4_:WorldMapListValueObject = _listCollection.getItemAt(getMapIndex(_loc3_)) as WorldMapListValueObject;
         var _loc6_:MissionDescription = player.missions.getNextPlayableMission();
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:WorldMapDescription = DataStorage.world.getById(_loc6_.world) as WorldMapDescription;
         var _loc5_:WorldMapListValueObject = _listCollection.getItemAt(getMapIndex(_loc7_)) as WorldMapListValueObject;
         var _loc2_:Vector.<MissionDescription> = player.missions.getNextPlayableParallelMissions();
         _loc5_.internal_parallel_unlockAvailability(_loc2_);
         if(_loc6_ != _currentMission)
         {
            _currentMission = _loc6_;
            if(_loc5_)
            {
               _loc5_.internal_updateCurrentMission(_loc6_);
            }
            if(_loc5_ != _loc4_)
            {
               _loc4_.internal_updateCurrentMission(_loc6_);
               setWorld(_loc7_);
            }
         }
      }
      
      private function handler_startMission() : void
      {
         close();
      }
      
      private function handler_bundleUpdate(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _listCollection.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _listCollection.getItemAt(_loc4_) as WorldMapListValueObject;
            _loc2_.updateMissionListBundles();
            _loc4_++;
         }
      }
   }
}
