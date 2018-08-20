package game.mediator.gui.worldmap
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.mission.PlayerMissionEntry;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class WorldMapViewMissionValueObject
   {
       
      
      private var _signal_progressUpdate:Signal;
      
      private var _signal_updateIfCurrent:Signal;
      
      private var _mission:MissionDescription;
      
      private var _bundle:PlayerBillingBundleEntry;
      
      private var _playerEntry:PlayerMissionEntry;
      
      private var _available:Boolean;
      
      private var _completed:Boolean;
      
      private var _heroIcon:Texture;
      
      private var _heroIconBg:Texture;
      
      private var _stars:int;
      
      private var _isCurrent:Boolean;
      
      public function WorldMapViewMissionValueObject(param1:MissionDescription, param2:PlayerMissionEntry, param3:Boolean)
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _signal_progressUpdate = new Signal(WorldMapViewMissionValueObject);
         _signal_updateIfCurrent = new Signal(WorldMapViewMissionValueObject);
         super();
         this._mission = param1;
         setPlayerEntry(param2,param3);
         if(param1.isHeroic)
         {
            _loc4_ = param1.consolidatedDrop.outputDisplay;
            _loc5_ = _loc4_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_loc4_[_loc6_].item is UnitDescription && _loc4_[_loc6_] is InventoryFragmentItem)
               {
                  _heroIcon = AssetStorage.inventory.getUnitSquareTexture(_loc4_[_loc6_].item as UnitDescription);
                  _heroIconBg = HeroColor.defaultBackgroundAsset;
               }
               _loc6_++;
            }
         }
      }
      
      public function dispose() : void
      {
         if(this._playerEntry)
         {
            this._playerEntry.signal_updateProgress.remove(handler_playerEntryProgress);
         }
         if(!_bundle)
         {
         }
      }
      
      public function get signal_progressUpdate() : Signal
      {
         return _signal_progressUpdate;
      }
      
      public function get signal_updateIfCurrent() : Signal
      {
         return _signal_updateIfCurrent;
      }
      
      public function get mission() : MissionDescription
      {
         return _mission;
      }
      
      public function get bundle() : PlayerBillingBundleEntry
      {
         return _bundle;
      }
      
      public function set bundle(param1:PlayerBillingBundleEntry) : void
      {
         _bundle = param1;
         _signal_progressUpdate.dispatch(this);
      }
      
      public function get isMajor() : Boolean
      {
         return _mission.isHeroic;
      }
      
      public function get id() : String
      {
         return _mission.world + "." + _mission.id;
      }
      
      public function get playerEntry() : PlayerMissionEntry
      {
         return _playerEntry;
      }
      
      public function get name() : String
      {
         return _mission.name;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function get heroIcon() : Texture
      {
         return _heroIcon;
      }
      
      public function get heroIconBg() : Texture
      {
         return _heroIconBg;
      }
      
      public function get marker_name() : String
      {
         return _mission.mapGuiMarker;
      }
      
      public function get stars() : int
      {
         return _stars;
      }
      
      public function get sortValue() : int
      {
         return mission.world * 1000 + mission.index;
      }
      
      public function get isCurrent() : Boolean
      {
         return _isCurrent;
      }
      
      public function set isCurrent(param1:Boolean) : void
      {
         if(_isCurrent != param1)
         {
            _isCurrent = param1;
         }
         _signal_updateIfCurrent.dispatch(this);
      }
      
      function internal_addNewPlayerEntry(param1:PlayerMissionEntry, param2:Boolean) : void
      {
         setPlayerEntry(param1,param2);
         _signal_progressUpdate.dispatch(this);
      }
      
      function internal_updatePlayerProgress(param1:PlayerMissionEntry) : void
      {
         setPlayerEntry(param1,available);
         _signal_progressUpdate.dispatch(this);
      }
      
      function internal_setIsNewCurrent() : void
      {
         setPlayerEntry(_playerEntry,true);
         _isCurrent = true;
         _signal_progressUpdate.dispatch(this);
      }
      
      function internal_parallel_unlock() : void
      {
         setPlayerEntry(_playerEntry,true);
         _signal_progressUpdate.dispatch(this);
      }
      
      private function setPlayerEntry(param1:PlayerMissionEntry, param2:Boolean) : void
      {
         this._available = param2;
         if(this._playerEntry)
         {
            this._playerEntry.signal_updateProgress.remove(handler_playerEntryProgress);
         }
         this._playerEntry = param1;
         if(_playerEntry)
         {
            _playerEntry.signal_updateProgress.add(handler_playerEntryProgress);
         }
         _completed = param1 && param1.stars > 0;
         _stars = !!param1?param1.stars:0;
      }
      
      private function handler_playerEntryProgress(param1:PlayerMissionEntry) : void
      {
         internal_updatePlayerProgress(param1);
      }
   }
}
