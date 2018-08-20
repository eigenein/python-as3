package game.mechanics.dungeon.mediator
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.quest.CommandQuestFarm;
   import game.data.storage.DataStorage;
   import game.mechanics.dungeon.model.PlayerDungeonFloor;
   import game.mechanics.dungeon.popup.DungeonScreen;
   import game.mechanics.dungeon.popup.cfg.DungeonScreenConfig;
   import game.mechanics.dungeon.popup.list.DungeonScreenFloorTransitionController;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.quest.QuestRewardPopup;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class DungeonScreenMediator extends ClanPopupMediatorBase
   {
      
      public static var current:DungeonScreenMediator;
       
      
      private var firstFloorIndex:int;
      
      private var lastFloorIndex:int;
      
      private var isInSavingRoutine:Boolean = false;
      
      private var _property_playerDungeonActivityPoints:IntPropertyWriteable;
      
      private var _property_titanWatcherIconState:BooleanPropertyWriteable;
      
      private var _property_dungeonActivityPoints:IntPropertyWriteable;
      
      private var _property_dungeonMaxActivityPoints:IntPropertyWriteable;
      
      private var _property_nextTitaniteReward:ObjectPropertyWriteable;
      
      private var _property_currentQuest:ObjectPropertyWriteable;
      
      private var _signal_currentQuestProgressUpdate:Signal;
      
      private var _floorList:Vector.<DungeonFloorGroupValueObject>;
      
      public const floorList:ListCollection = new ListCollection();
      
      private var _transitionController:DungeonScreenFloorTransitionController;
      
      private var _signal_floorUpdate:Signal;
      
      public const state:DungeonScreenState = new DungeonScreenState();
      
      public function DungeonScreenMediator(param1:Player)
      {
         _property_playerDungeonActivityPoints = new IntPropertyWriteable();
         _property_titanWatcherIconState = new BooleanPropertyWriteable();
         _property_dungeonActivityPoints = new IntPropertyWriteable();
         _property_dungeonMaxActivityPoints = new IntPropertyWriteable();
         _property_nextTitaniteReward = new ObjectPropertyWriteable(InventoryItem);
         _property_currentQuest = new ObjectPropertyWriteable(PlayerQuestValueObject);
         _signal_currentQuestProgressUpdate = new Signal();
         _signal_floorUpdate = new Signal();
         super(param1);
         if(param1.dungeon.initialized)
         {
            playerDungeonDataReady();
         }
         else
         {
            param1.dungeon.initRequest();
            param1.dungeon.signal_init.addOnce(playerDungeonDataReady);
         }
         param1.questData.signal_questAdded.add(handler_playerQuestsAdded);
         param1.questData.signal_questRemoved.remove(handler_playerQuestRemoved);
         updateActiveQuest();
         param1.clan.clan.dungeonActivityPoints.signal_update.add(handler_playerDungeonActivityPointsUpdate);
         param1.titans.watcher.signal_update.add(handler_titanWatcherIconUpdate);
         _property_titanWatcherIconState.value = param1.titans.watcher.hasAvailableTitanUpgrades;
      }
      
      override protected function dispose() : void
      {
         if(player == null)
         {
            return;
         }
         if(currentQuestVO)
         {
            currentQuestVO.signal_progressUpdate.remove(handler_currentQuestProgress);
         }
         player.questData.signal_questAdded.remove(handler_playerQuestsAdded);
         player.questData.signal_questRemoved.remove(handler_playerQuestRemoved);
         player.titans.watcher.signal_update.remove(handler_titanWatcherIconUpdate);
         player.dungeon.floor.signal_update.remove(handler_floorUpdate);
         player.dungeon.signal_batlleEnd.remove(handler_battleEnd);
         player.dungeon.signal_saveLeverIsAvailable.remove(handler_saveLeverIsAvailable);
         DungeonFloorGroupValueObject.action_dispose();
         if(_transitionController)
         {
            _transitionController.dispose();
         }
         if(player.clan.clan)
         {
            player.clan.clan.dungeonActivityPoints.signal_update.remove(handler_playerDungeonActivityPointsUpdate);
         }
         super.dispose();
         DungeonScreenMediator.current = null;
      }
      
      public function get property_playerDungeonActivityPoints() : IntProperty
      {
         return _property_playerDungeonActivityPoints;
      }
      
      public function get property_titanWatcherIconState() : BooleanProperty
      {
         return _property_titanWatcherIconState;
      }
      
      public function get property_dungeonActivityPoints() : IntProperty
      {
         return _property_dungeonActivityPoints;
      }
      
      public function get property_dungeonMaxActivityPoints() : IntProperty
      {
         return _property_dungeonMaxActivityPoints;
      }
      
      public function get property_nextTitaniteReward() : ObjectProperty
      {
         return _property_nextTitaniteReward;
      }
      
      public function get property_currentQuest() : ObjectProperty
      {
         return _property_currentQuest;
      }
      
      public function get signal_currentQuestProgressUpdate() : Signal
      {
         return _signal_currentQuestProgressUpdate;
      }
      
      public function get currentFloor() : int
      {
         return player.dungeon.floor.value;
      }
      
      public function get currentFloorColumnIndex() : int
      {
         var _loc1_:int = this.currentFloor;
         if(DungeonScreenConfig.isRightExit(_loc1_))
         {
            return (_loc1_ - 1) % 5;
         }
         return 4 - (_loc1_ - 1) % 5;
      }
      
      public function get prevFloorColumnIndex() : int
      {
         var _loc1_:int = this.currentFloor - 1;
         if(DungeonScreenConfig.isRightExit(_loc1_))
         {
            return (_loc1_ - 1) % 5;
         }
         return 4 - (_loc1_ - 1) % 5;
      }
      
      public function get currentFloorGroupIndex() : int
      {
         return int((currentFloor - firstFloorIndex) / 5);
      }
      
      public function get transitionController() : DungeonScreenFloorTransitionController
      {
         return _transitionController;
      }
      
      public function get signal_floorUpdate() : Signal
      {
         return _signal_floorUpdate;
      }
      
      public function get currentQuestVO() : PlayerQuestValueObject
      {
         return _property_currentQuest.value as PlayerQuestValueObject;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonScreen(this);
         return _popup;
      }
      
      public function action_initUIValues() : void
      {
         if(player)
         {
            updateActiveQuest();
            updateNextTitaniteReward();
         }
      }
      
      public function action_showGuide() : void
      {
         var _loc1_:DungeonRulesPopupMediator = new DungeonRulesPopupMediator(player);
         _loc1_.open(Stash.click("rules",_popup.stashParams));
      }
      
      public function action_showTitans() : void
      {
         Game.instance.navigator.navigateToTitans(Stash.click("titans",_popup.stashParams));
      }
      
      public function action_farmCurrentQuest() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(currentQuestVO && currentQuestVO.canFarm)
         {
            _loc1_ = Stash.click("get_reward:" + currentQuestVO.entry.desc.id,_popup.stashParams);
            _loc2_ = GameModel.instance.actionManager.quest.questFarm(currentQuestVO.entry);
            _loc2_.onClientExecute(handler_questFarmComplete);
         }
      }
      
      public function whenDataReady(param1:Function) : void
      {
         if(player.dungeon.initialized)
         {
            param1();
         }
         else
         {
            player.dungeon.signal_init.addOnce(param1);
         }
      }
      
      public function action_selectFloor(param1:DungeonFloorValueObject) : void
      {
         player.dungeon.action_openFloorPopup(Stash.click("dungeon_floor",_popup.stashParams));
      }
      
      public function action_initiateSaving(param1:DungeonFloorValueObject) : void
      {
         _transitionController.action_startSave(player.dungeon.floor.value,player.dungeon.getNextNotCapturedSaveEntrance());
         state.signal_readyToSave.addOnce(handler_readyToClaimSaveReward);
      }
      
      public function action_save() : void
      {
         isInSavingRoutine = true;
         player.dungeon.action_saveProgress();
      }
      
      protected function playerDungeonDataReady() : void
      {
         var _loc3_:* = null;
         _floorList = new Vector.<DungeonFloorGroupValueObject>();
         floorList.data = _floorList;
         _loc3_ = new DungeonFloorGroupValueObject(state);
         var _loc1_:int = 5;
         firstFloorIndex = int((player.dungeon.floor.value - 1) / _loc1_) * _loc1_ + 1;
         var _loc2_:int = player.dungeon.getNextNotCapturedSaveEntrance();
         var _loc4_:int = player.dungeon.floor.value + 5;
         firstFloorIndex = Math.min(_loc2_,firstFloorIndex);
         lastFloorIndex = firstFloorIndex - 1;
         while(lastFloorIndex <= _loc4_)
         {
            addFloorRow();
         }
         player.dungeon.floor.signal_update.add(handler_floorUpdate);
         player.dungeon.signal_batlleEnd.add(handler_battleEnd);
         player.dungeon.signal_saveLeverIsAvailable.add(handler_saveLeverIsAvailable);
         _transitionController = new DungeonScreenFloorTransitionController(this);
      }
      
      private function updateNextTitaniteReward() : void
      {
         handler_playerDungeonActivityPointsUpdate(player.clan.clan.dungeonActivityPoints.value);
      }
      
      private function setActiveQuest(param1:PlayerQuestEntry) : void
      {
         if(currentQuestVO)
         {
            currentQuestVO.signal_progressUpdate.remove(handler_currentQuestProgress);
         }
         if(param1)
         {
            _property_currentQuest.value = new PlayerQuestValueObject(param1,false);
            currentQuestVO.signal_progressUpdate.add(handler_currentQuestProgress);
         }
         else
         {
            _property_currentQuest.value = null;
         }
      }
      
      private function updateActiveQuest() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<PlayerQuestEntry> = player.questData.getNormalList();
         var _loc1_:int = _loc2_.length;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            if(_loc2_[_loc4_].desc.farmCondition.stateFunc.ident == "dungeonMaxFloor")
            {
               if(!currentQuestVO || currentQuestVO.entry != _loc2_[_loc4_])
               {
                  setActiveQuest(_loc2_[_loc4_]);
               }
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            _property_currentQuest.value = null;
         }
      }
      
      private function addFloorRow() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = 0;
         var _loc1_:DungeonFloorGroupValueObject = new DungeonFloorGroupValueObject(state);
         var _loc7_:int = player.dungeon.floor.value;
         var _loc5_:int = player.dungeon.findLastCapturedSaveLeverFloor();
         var _loc2_:int = lastFloorIndex + 5;
         var _loc3_:int = 0;
         _loc6_ = lastFloorIndex + 1;
         while(_loc6_ <= _loc2_)
         {
            _loc4_ = new DungeonFloorValueObject(DataStorage.dungeon.getDescriptionByFloorNumber(_loc6_),_loc6_,_loc3_ == 0,_loc3_ == 5 - 1);
            if(_loc4_.number == _loc7_)
            {
               _loc4_.setPlayerFloor(player.dungeon.currentFloor);
               _loc8_ = _loc3_;
               if(!_loc4_.rightExit)
               {
                  _loc8_ = int(5 - _loc8_ - 1);
               }
               state.setCurrentState(player.dungeon.currentFloor,_loc1_,_loc4_,int((_loc6_ - 1) / 5),_loc8_);
            }
            else
            {
               _loc4_.setPlayerFloor(null);
               _loc4_.setFloorState(_loc6_ < _loc7_,_loc6_ <= _loc5_);
            }
            _loc3_++;
            if(_loc4_.rightExit)
            {
               _loc1_.data.push(_loc4_);
            }
            else
            {
               _loc1_.data.unshift(_loc4_);
            }
            _loc6_++;
         }
         lastFloorIndex = _loc2_;
         floorList.push(_loc1_);
      }
      
      private function startTransition() : void
      {
         if(isInSavingRoutine)
         {
            isInSavingRoutine = false;
            _transitionController.action_completeSave(player.dungeon.floor.value - 1,player.dungeon.floor.value);
         }
         else
         {
            state.signal_prepareHeroesToMovement.dispatch();
            _transitionController.action_transition(player.dungeon.floor.value - 1,player.dungeon.floor.value);
         }
      }
      
      private function handler_floorUpdate(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc7_:PlayerDungeonFloor = player.dungeon.currentFloor;
         if(param1 + 5 > lastFloorIndex)
         {
            addFloorRow();
         }
         var _loc5_:int = player.dungeon.findLastCapturedSaveLeverFloor();
         var _loc2_:int = _floorList.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = _floorList[_loc6_];
            _loc9_ = _loc3_.data.length;
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc4_ = _loc3_.data[_loc8_];
               if(_loc4_.number == param1)
               {
                  _loc4_.setPlayerFloor(_loc7_);
                  state.setCurrentState(_loc7_,_loc3_,_loc4_,_loc6_,_loc8_);
               }
               else
               {
                  _loc4_.setPlayerFloor(null);
                  _loc4_.setFloorState(_loc4_.number < param1,_loc4_.number <= _loc5_);
               }
               _loc8_++;
            }
            _loc6_++;
         }
         _signal_floorUpdate.dispatch();
         if(_popup.stage)
         {
            startTransition();
         }
         else
         {
            _popup.addEventListener("addedToStage",handler_popupOnStage);
         }
      }
      
      private function handler_battleEnd() : void
      {
         transitionController.action_reset();
         state.signal_battleEnd.dispatch();
      }
      
      private function handler_saveLeverIsAvailable() : void
      {
         transitionController.action_scrollToSaveLever();
      }
      
      private function handler_popupOnStage(param1:Event) : void
      {
         startTransition();
         _popup.removeEventListener("addedToStage",handler_popupOnStage);
      }
      
      private function handler_readyToClaimSaveReward() : void
      {
         action_save();
      }
      
      public function findFloorValueObject(param1:int) : DungeonFloorValueObject
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = _floorList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _floorList[_loc5_];
            _loc7_ = _loc3_.data.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_ = _loc3_.data[_loc6_];
               if(_loc4_.number == param1)
               {
                  return _loc4_;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return null;
      }
      
      private function handler_playerQuestsAdded(param1:PlayerQuestEntry) : void
      {
         if(param1.desc.farmCondition.stateFunc.ident == "dungeonMaxFloor")
         {
            setActiveQuest(param1);
         }
      }
      
      private function handler_playerQuestRemoved(param1:PlayerQuestEntry) : void
      {
         if(currentQuestVO.entry == param1)
         {
            setActiveQuest(null);
         }
      }
      
      private function handler_questFarmComplete(param1:CommandQuestFarm) : void
      {
         var _loc2_:QuestRewardPopup = new QuestRewardPopup(param1.reward.outputDisplay,param1.entry);
         _loc2_.stashSourceClick = param1.stashClick;
         PopUpManager.addPopUp(_loc2_);
      }
      
      private function handler_playerDungeonActivityPointsUpdate(param1:int) : void
      {
         var _loc2_:* = null;
         _property_playerDungeonActivityPoints.value = player.clan.clan.stat.todayDungeonActivity.value;
         _property_dungeonActivityPoints.value = param1;
         var _loc3_:int = DataStorage.clanDungeonActivityReward.getPointsForNextKey(param1);
         if(_property_dungeonMaxActivityPoints.value != _loc3_ || _property_dungeonActivityPoints.value > _loc3_)
         {
            _property_dungeonMaxActivityPoints.value = _loc3_;
            _loc2_ = DataStorage.clanDungeonActivityReward.getNextRewardItem(param1);
            if(!_loc2_)
            {
               _loc2_ = new InventoryItem(null,0);
            }
            _property_nextTitaniteReward.value = _loc2_;
         }
      }
      
      private function handler_currentQuestProgress(param1:PlayerQuestEntry) : void
      {
         _signal_currentQuestProgressUpdate.dispatch();
      }
      
      private function handler_titanWatcherIconUpdate() : void
      {
         _property_titanWatcherIconState.value = player.titans.watcher.hasAvailableTitanUpgrades;
      }
   }
}
