package game.model.user.mission
{
   import feathers.core.PopUpManager;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.thread.MissionBattleThread;
   import game.battle.controller.thread.TutorialMissionBattleThread;
   import game.command.rpc.mission.CommandMissionEnd;
   import game.command.rpc.mission.MissionBattleResultValueObject;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.mission.MissionRewardPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.refillable.PlayerRefillableVIPSource;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMissionData
   {
       
      
      private const dictNormal:Dictionary = new Dictionary();
      
      private var normalModeListCache:Vector.<MissionDescription>;
      
      private var vip:PlayerRefillableVIPSource;
      
      private var player:Player;
      
      private var _signal_newMissionEntry:Signal;
      
      private var _signal_missionProgress:Signal;
      
      private var _currentMission:PlayerMissionBattle;
      
      public function PlayerMissionData()
      {
         _signal_newMissionEntry = new Signal(PlayerMissionEntry);
         _signal_missionProgress = new Signal(PlayerMissionEntry);
         super();
      }
      
      public function get signal_newMissionEntry() : Signal
      {
         return _signal_newMissionEntry;
      }
      
      public function get signal_missionProgress() : Signal
      {
         return _signal_missionProgress;
      }
      
      public function get currentMission() : PlayerMissionBattle
      {
         return _currentMission;
      }
      
      public function missionStart(param1:MissionDescription, param2:Vector.<PlayerHeroEntry>, param3:Object) : void
      {
         var _loc4_:* = null;
         _currentMission = new PlayerMissionBattle(param1,param2,param3);
         if(Tutorial.flags.tutorialMission)
         {
            _loc4_ = new TutorialMissionBattleThread(param3,param1);
         }
         else
         {
            _loc4_ = new MissionBattleThread(param3,param1);
         }
         _loc4_.onComplete.addOnce(onMissionCompleteListener);
         _loc4_.onRetreat.addOnce(onMissionRetreatListener);
         _loc4_.run();
      }
      
      public function init(param1:Object, param2:Player) : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc7_:* = null;
         this.player = param2;
         this.normalModeListCache = DataStorage.mission.getNormalModeList();
         vip = new PlayerRefillableVIPSource(param2);
         var _loc3_:Array = param1 as Array;
         var _loc5_:int = _loc3_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = _loc3_[_loc8_];
            _loc4_ = DataStorage.mission.getMissionById(_loc6_.id);
            if(_loc4_.isHeroic)
            {
               _loc9_ = new PlayerEliteMissionEntry(_loc4_,_loc6_,vip);
               dictNormal[_loc9_.id] = _loc9_;
            }
            else
            {
               _loc7_ = new PlayerMissionEntry(_loc4_,_loc6_);
               dictNormal[_loc7_.id] = _loc7_;
            }
            _loc8_++;
         }
      }
      
      public function reset() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = dictNormal;
         for each(var _loc1_ in dictNormal)
         {
            _loc2_ = _loc1_ as PlayerEliteMissionEntry;
            if(_loc2_)
            {
               _loc2_.eliteTries.reset();
            }
         }
      }
      
      public function eliteMissionCanRefill(param1:int) : Boolean
      {
         var _loc2_:PlayerEliteMissionEntry = dictNormal[param1] as PlayerEliteMissionEntry;
         return _loc2_.canRefill;
      }
      
      public function normalMissionGetById(param1:int) : PlayerEliteMissionEntry
      {
         return dictNormal[param1] as PlayerEliteMissionEntry;
      }
      
      public function getByDesc(param1:MissionDescription) : PlayerMissionEntry
      {
         if(!param1)
         {
            return null;
         }
         return dictNormal[param1.id];
      }
      
      public function getCurrentWorldMap() : WorldMapDescription
      {
         var _loc1_:* = null;
         var _loc2_:MissionDescription = getNextPlayableMission();
         if(_loc2_)
         {
            return DataStorage.world.getById(_loc2_.world) as WorldMapDescription;
         }
         _loc1_ = getCurrentMissionDesc();
         if(_loc1_)
         {
            return DataStorage.world.getById(_loc1_.world) as WorldMapDescription;
         }
         return null;
      }
      
      public function getNextPlayableParallelMissions() : Vector.<MissionDescription>
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<MissionDescription> = new Vector.<MissionDescription>();
         var _loc4_:MissionDescription = getCurrentMissionDesc();
         var _loc1_:Vector.<MissionDescription> = DataStorage.mission.getByWorld(_loc4_.world);
         var _loc2_:int = _loc1_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(_loc1_[_loc5_].prevMissionIndex == _loc4_.index)
            {
               _loc3_.push(_loc1_[_loc5_]);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getNextPlayableMission() : MissionDescription
      {
         var _loc2_:MissionDescription = getCurrentMissionDesc();
         var _loc1_:PlayerMissionEntry = getByDesc(_loc2_);
         if(!_loc1_ || !_loc1_.stars)
         {
            return _loc2_;
         }
         return DataStorage.mission.getNextMission(_loc2_);
      }
      
      public function isMissionAvailable(param1:MissionDescription) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:PlayerMissionEntry = getByDesc(param1);
         if(_loc2_ && _loc2_.stars > 0)
         {
            return true;
         }
         _loc3_ = DataStorage.mission.getPreviousMission(param1);
         if(!_loc3_)
         {
            return true;
         }
         _loc2_ = getByDesc(_loc3_);
         if(_loc2_ && _loc2_.stars > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getItemDropList(param1:InventoryItemDescription) : Vector.<MissionItemDropValueObject>
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = false;
         var _loc3_:* = null;
         var _loc5_:Vector.<MissionItemDropValueObject> = new Vector.<MissionItemDropValueObject>();
         var _loc6_:int = normalModeListCache.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = normalModeListCache[_loc7_];
            _loc2_ = _loc8_.consolidatedDrop;
            if(param1 is UnitDescription)
            {
               _loc4_ = _loc2_.fragmentCollection.getItemCount(param1) > 0;
            }
            else
            {
               _loc4_ = Boolean(_loc2_.inventoryCollection.getItemCount(param1) > 0 || _loc2_.fragmentCollection.getItemCount(param1) > 0);
            }
            if(_loc4_)
            {
               _loc3_ = new MissionItemDropValueObject(_loc8_,isMissionAvailable(_loc8_));
               _loc5_.push(_loc3_);
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function itemIsDropableRightNow(param1:InventoryItemDescription) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         var _loc6_:Vector.<MissionDescription> = normalModeListCache;
         var _loc4_:int = normalModeListCache.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = normalModeListCache[_loc5_];
            _loc2_ = _loc7_.consolidatedDrop;
            _loc3_ = _loc2_.inventoryCollection.getItemCount(param1) > 0 || _loc2_.fragmentCollection.getItemCount(param1) > 0;
            if(_loc3_ && isMissionAvailable(_loc7_))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function missionRaid(param1:MissionDescription, param2:int) : void
      {
         var _loc3_:* = null;
         if(param1.isHeroic)
         {
            _loc3_ = getByDesc(param1) as PlayerEliteMissionEntry;
            _loc3_.spendEliteTries(param2);
         }
      }
      
      public function missionEliteRefill(param1:int) : void
      {
         var _loc2_:PlayerEliteMissionEntry = dictNormal[param1] as PlayerEliteMissionEntry;
         _loc2_.refill();
      }
      
      public function updateMissionProgress(param1:PlayerMissionBattle, param2:MultiBattleResult) : void
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc3_:PlayerMissionEntry = getByDesc(param1.desc);
         if(!_loc3_)
         {
            _loc3_ = addByDesc(param1.desc,param2);
            _loc5_ = true;
         }
         else if(param2.victory)
         {
            _loc3_.updateProgress(param2.result);
         }
         if(param1.desc.isHeroic && param2.victory)
         {
            _loc4_ = getByDesc(param1.desc) as PlayerEliteMissionEntry;
            _loc4_.spendEliteTries(1);
         }
         if(_loc5_)
         {
            _signal_newMissionEntry.dispatch(_loc3_);
         }
         _signal_missionProgress.dispatch(_loc3_);
      }
      
      public function getCurrentMissionDesc() : MissionDescription
      {
         var _loc1_:* = null;
         var _loc2_:int = 1;
         var _loc6_:int = 0;
         var _loc5_:* = dictNormal;
         for each(_loc1_ in dictNormal)
         {
            _loc2_ = Math.max(_loc2_,_loc1_.desc.world);
         }
         var _loc4_:int = 1;
         var _loc8_:int = 0;
         var _loc7_:* = dictNormal;
         for each(_loc1_ in dictNormal)
         {
            if(_loc1_.desc.world == _loc2_)
            {
               _loc4_ = Math.max(_loc4_,_loc1_.desc.index);
            }
         }
         var _loc3_:MissionDescription = DataStorage.mission.getByWorldIndex(_loc2_,_loc4_);
         return _loc3_;
      }
      
      private function addByDesc(param1:MissionDescription, param2:MultiBattleResult) : PlayerMissionEntry
      {
         var _loc3_:* = null;
         var _loc4_:Object = !!param2?param2.result:null;
         if(param1.isHeroic)
         {
            var _loc5_:* = new PlayerEliteMissionEntry(param1,_loc4_,vip);
            dictNormal[param1.id] = _loc5_;
            _loc3_ = _loc5_;
            return dictNormal[param1.id];
         }
         _loc5_ = new PlayerMissionEntry(param1,_loc4_);
         dictNormal[param1.id] = _loc5_;
         _loc3_ = _loc5_;
         return dictNormal[param1.id];
      }
      
      protected function onMissionRetreatListener(param1:MissionBattleThread) : void
      {
      }
      
      protected function onMissionCompleteListener(param1:MissionBattleThread) : void
      {
         var _loc2_:CommandMissionEnd = GameModel.instance.actionManager.mission.missionEnd(param1.battleResult);
         _loc2_.onClientExecute(onMissionEndListener);
      }
      
      protected function onMissionEndListener(param1:CommandMissionEnd) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(!(param1.result.body && param1.result.body.error))
         {
            _loc2_ = param1.battleResult;
            if(param1.victory)
            {
               _loc3_ = new MissionRewardPopupMediator(player,_loc2_,currentMission.desc);
               PopUpManager.addPopUp(_loc3_.createPopup());
               AssetStorage.sound.battleWin.play();
            }
            else
            {
               _loc4_ = new MissionDefeatPopupMediator(GameModel.instance.player,_loc2_,MechanicStorage.MISSION);
               _loc4_.open();
            }
         }
      }
   }
}
