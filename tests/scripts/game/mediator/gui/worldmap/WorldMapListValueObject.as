package game.mediator.gui.worldmap
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.data.storage.DataStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.model.user.Player;
   import game.model.user.easteregg.PlayerEasterEggData;
   import game.model.user.mission.PlayerMissionEntry;
   
   public class WorldMapListValueObject
   {
       
      
      private var player:Player;
      
      private var mediator:WorldMapViewMediator;
      
      private var _listMajor:Vector.<WorldMapViewMissionValueObject>;
      
      private var _listMinor:Vector.<WorldMapViewMissionValueObject>;
      
      private var _listParallel:Vector.<WorldMapViewMissionValueObject>;
      
      private var _easterEggData:PlayerEasterEggData;
      
      private var _desc:WorldMapDescription;
      
      public function WorldMapListValueObject(param1:WorldMapDescription, param2:WorldMapViewMediator, param3:Player)
      {
         super();
         this.player = param3;
         this._desc = param1;
         this.mediator = param2;
         _easterEggData = param3.easterEggs;
         updateMissionList(param3);
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = _listMajor.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _listMajor[_loc3_];
            _loc2_.dispose();
            _loc3_++;
         }
         _loc1_ = _listMinor.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _listMinor[_loc3_];
            _loc2_.dispose();
            _loc3_++;
         }
         _loc1_ = _listParallel.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _listParallel[_loc3_];
            _loc2_.dispose();
            _loc3_++;
         }
      }
      
      public function get easterEggData() : PlayerEasterEggData
      {
         return _easterEggData;
      }
      
      public function get desc() : WorldMapDescription
      {
         return _desc;
      }
      
      public function get asset() : RsxGameAsset
      {
         return AssetStorage.rsx.getByName(_desc.assetFile);
      }
      
      public function getValueObject(param1:int, param2:Boolean, param3:Boolean = false) : WorldMapViewMissionValueObject
      {
         param1--;
         if(param3)
         {
            if(_listParallel.length > param1)
            {
               return _listParallel[param1];
            }
         }
         else if(param2)
         {
            if(_listMajor.length > param1)
            {
               return _listMajor[param1];
            }
         }
         else if(_listMinor.length > param1)
         {
            return _listMinor[param1];
         }
         return null;
      }
      
      public function updateMissionList(param1:Player) : void
      {
         var _loc4_:* = undefined;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _listMajor = new Vector.<WorldMapViewMissionValueObject>();
         _listMinor = new Vector.<WorldMapViewMissionValueObject>();
         _listParallel = new Vector.<WorldMapViewMissionValueObject>();
         _loc4_ = DataStorage.mission.getByWorld(_desc.id);
         var _loc7_:MissionDescription = mediator.currentMission;
         var _loc3_:int = _loc4_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc2_ = _loc4_[_loc8_];
            _loc5_ = param1.missions.getByDesc(_loc2_);
            _loc6_ = new WorldMapViewMissionValueObject(_loc2_,_loc5_,param1.missions.isMissionAvailable(_loc2_));
            if(param1.billingData.bundleData.activeBundle && param1.billingData.bundleData.activeBundle.desc.requirement_missionId == _loc2_.id)
            {
               _loc6_.bundle = param1.billingData.bundleData.activeBundle;
            }
            if(_loc2_ == _loc7_)
            {
               _loc6_.isCurrent = true;
            }
            if(_loc2_.isParallel)
            {
               _listParallel.push(_loc6_);
            }
            else if(_loc2_.isHeroic)
            {
               _listMajor.push(_loc6_);
            }
            else
            {
               _listMinor.push(_loc6_);
            }
            _loc8_++;
         }
      }
      
      public function updateMissionListBundles() : void
      {
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         _loc4_ = 0;
         _loc3_ = null;
         _loc2_ = DataStorage.mission.getByWorld(_desc.id);
         _loc1_ = _listMajor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = _listMajor[_loc4_];
            if(player.billingData.bundleData.activeBundle && player.billingData.bundleData.activeBundle.desc.requirement_missionId == _loc3_.mission.id)
            {
               _loc3_.bundle = player.billingData.bundleData.activeBundle;
            }
            else if(_loc3_.bundle)
            {
               _loc3_.bundle = null;
            }
            _loc4_++;
         }
         _loc1_ = _listMinor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = _listMinor[_loc4_];
            if(player.billingData.bundleData.activeBundle && player.billingData.bundleData.activeBundle.desc.requirement_missionId == _loc3_.mission.id)
            {
               _loc3_.bundle = player.billingData.bundleData.activeBundle;
            }
            else if(_loc3_.bundle)
            {
               _loc3_.bundle = null;
            }
            _loc4_++;
         }
      }
      
      public function action_selectMission(param1:WorldMapViewMissionValueObject) : void
      {
         mediator.action_selectMission(param1);
      }
      
      function internal_updateCurrentMission(param1:MissionDescription) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         _loc3_ = null;
         var _loc2_:int = _listMajor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listMajor[_loc4_];
            if(_loc3_.mission == param1)
            {
               _loc3_.internal_setIsNewCurrent();
            }
            else
            {
               _loc3_.isCurrent = false;
            }
            _loc4_++;
         }
         _loc2_ = _listMinor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listMinor[_loc4_];
            if(_loc3_.mission == param1)
            {
               _loc3_.internal_setIsNewCurrent();
            }
            else
            {
               _loc3_.isCurrent = false;
            }
            _loc4_++;
         }
      }
      
      function internal_parallel_unlockAvailability(param1:Vector.<MissionDescription>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = _listParallel.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listMinor[_loc4_];
            if(param1.indexOf(_loc3_.mission) != -1)
            {
               _loc3_.internal_parallel_unlock();
            }
            _loc4_++;
         }
      }
      
      function internal_updatePlayerProgress() : void
      {
      }
      
      function internal_handleNewPlayerMission(param1:PlayerMissionEntry) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc4_ = 0;
         _loc3_ = null;
         _loc2_ = _listMajor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listMajor[_loc4_];
            if(_loc3_.mission == param1.desc)
            {
               _loc3_.internal_addNewPlayerEntry(param1,player.missions.isMissionAvailable(param1.desc));
               return;
            }
            _loc4_++;
         }
         _loc2_ = _listMinor.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listMinor[_loc4_];
            if(_loc3_.mission == param1.desc)
            {
               _loc3_.internal_addNewPlayerEntry(param1,player.missions.isMissionAvailable(param1.desc));
               return;
            }
            _loc4_++;
         }
         _loc2_ = _listParallel.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listParallel[_loc4_];
            _loc4_++;
         }
      }
   }
}
