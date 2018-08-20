package game.mechanics.dungeon.mediator
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import flash.utils.getTimer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.model.PlayerDungeonBattleFloor;
   import game.mechanics.dungeon.model.PlayerDungeonFloor;
   import game.mechanics.dungeon.model.state.DungeonFloorBattleState;
   import game.mechanics.dungeon.model.state.DungeonFloorElement;
   import game.mechanics.dungeon.model.state.DungeonFloorElementalGroup;
   import game.mechanics.dungeon.model.state.DungeonFloorSaveState;
   import game.mechanics.dungeon.popup.cfg.DungeonScreenConfig;
   import game.mechanics.dungeon.popup.floor.DungeonAnyBattleFloorClip;
   import game.mechanics.dungeon.popup.floor.DungeonBattleFloorWithStairsClip;
   import game.mechanics.dungeon.popup.floor.DungeonEntranceFloorClip;
   import game.mechanics.dungeon.popup.floor.DungeonFloorClipBase;
   import game.mechanics.dungeon.popup.floor.DungeonLeverFloorClip;
   import game.mechanics.dungeon.storage.DungeonFloorDescription;
   import game.mechanics.dungeon.storage.SaveInteractionType;
   import org.osflash.signals.Signal;
   
   public class DungeonFloorValueObject
   {
       
      
      private var playerFloor:PlayerDungeonFloor;
      
      private var _signal_playBridge:Signal;
      
      private var _signal_animateSave:Signal;
      
      private var _desc:DungeonFloorDescription;
      
      private var _state_battle:ObjectPropertyWriteable;
      
      private var _state_saveIsCaptured:BooleanPropertyWriteable;
      
      private var _state_saveCanBeCaptured:BooleanPropertyWriteable;
      
      private var _saveAnimationStartTime:Number = 0;
      
      private var _property_isCurrent:BooleanPropertyWriteable;
      
      private var _elements:DungeonFloorElementalGroup;
      
      private var _isRightmost:Boolean;
      
      private var _isLeftmost:Boolean;
      
      private var _number:int;
      
      public function DungeonFloorValueObject(param1:DungeonFloorDescription, param2:int, param3:Boolean, param4:Boolean)
      {
         _signal_playBridge = new Signal();
         _signal_animateSave = new Signal();
         _state_battle = new ObjectPropertyWriteable(DungeonFloorBattleState);
         _state_saveIsCaptured = new BooleanPropertyWriteable(true);
         _state_saveCanBeCaptured = new BooleanPropertyWriteable(true);
         _property_isCurrent = new BooleanPropertyWriteable(false);
         super();
         this._desc = param1;
         this._number = param2;
         _elements = new DungeonFloorElementalGroup(DungeonFloorElement.NEUTRAL);
         _isRightmost = !!rightExit?param4:Boolean(param3);
         _isLeftmost = !!rightExit?param3:Boolean(param4);
      }
      
      public function get signal_playBridge() : Signal
      {
         return _signal_playBridge;
      }
      
      public function get signal_animateSave() : Signal
      {
         return _signal_animateSave;
      }
      
      public function get desc() : DungeonFloorDescription
      {
         return _desc;
      }
      
      public function get state_battle() : ObjectProperty
      {
         return _state_battle;
      }
      
      public function get state_saveIsCaptured() : BooleanProperty
      {
         return _state_saveIsCaptured;
      }
      
      public function get state_saveCanBeCaptured() : BooleanProperty
      {
         return _state_saveCanBeCaptured;
      }
      
      public function get saveAnimationStartTime() : Number
      {
         return _saveAnimationStartTime;
      }
      
      public function get property_isCurrent() : BooleanProperty
      {
         return _property_isCurrent;
      }
      
      public function get elements() : DungeonFloorElementalGroup
      {
         return _elements;
      }
      
      public function get isRightmost() : Boolean
      {
         return _isRightmost;
      }
      
      public function get isLeftmost() : Boolean
      {
         return _isLeftmost;
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      public function get saveInteractionType() : SaveInteractionType
      {
         return !!desc?desc.saveInteractionType:null;
      }
      
      public function get rightExit() : Boolean
      {
         return DungeonScreenConfig.isRightExit(_number);
      }
      
      public function createAsset() : DungeonFloorClipBase
      {
         if(desc)
         {
            if(desc.id == 1)
            {
               return AssetStorage.rsx.dungeon_floors.create(DungeonEntranceFloorClip,"dungeon_floor_first");
            }
            if(_isRightmost)
            {
               return AssetStorage.rsx.dungeon_floors.create(DungeonBattleFloorWithStairsClip,"dungeon_floor_battle_right");
            }
            if(desc.saveInteractionType == SaveInteractionType.ENTRANCE)
            {
               return AssetStorage.rsx.dungeon_floors.create(DungeonEntranceFloorClip,"dungeon_floor_entrance");
            }
            if(desc.saveInteractionType == SaveInteractionType.LEVER)
            {
               return AssetStorage.rsx.dungeon_floors.create(DungeonLeverFloorClip,"dungeon_floor_lever");
            }
            if(_isLeftmost)
            {
               return AssetStorage.rsx.dungeon_floors.create(DungeonBattleFloorWithStairsClip,"dungeon_floor_10");
            }
            return AssetStorage.rsx.dungeon_floors.create(DungeonAnyBattleFloorClip,"dungeon_floor_any_battle" + (!!rightExit?"_right":"_left"));
         }
         return AssetStorage.rsx.dungeon_floors.create(DungeonAnyBattleFloorClip,"dungeon_floor_any_battle" + (!!rightExit?"_right":"_left"));
      }
      
      public function setPlayerFloor(param1:PlayerDungeonFloor) : void
      {
         var _loc2_:* = null;
         _loc2_ = null;
         if(this.playerFloor)
         {
            _loc2_ = this.playerFloor as PlayerDungeonBattleFloor;
            if(_loc2_)
            {
               _loc2_.state_battle.signal_update.remove(handler_stateUpdateBattle);
               _loc2_.state_save.signal_update.remove(handler_stateUpdateSave);
            }
         }
         this.playerFloor = param1;
         if(param1)
         {
            _loc2_ = this.playerFloor as PlayerDungeonBattleFloor;
            if(_loc2_)
            {
               _elements = _loc2_.elements;
               _loc2_.state_battle.onValue(handler_stateUpdateBattle);
               _loc2_.state_save.onValue(handler_stateUpdateSave);
            }
         }
         _property_isCurrent.value = param1 != null;
      }
      
      public function setFloorState(param1:Boolean, param2:Boolean) : void
      {
         _state_battle.value = !!param1?DungeonFloorBattleState.BATTLE_FINISHED:DungeonFloorBattleState.BATTLE_CAN_NOT_START_YET;
         _state_saveIsCaptured.value = param2;
         _state_saveCanBeCaptured.value = false;
      }
      
      public function action_playBridgeAnimation() : void
      {
         _signal_playBridge.dispatch();
      }
      
      public function action_playSaveAnimation() : void
      {
         _state_saveCanBeCaptured.value = false;
         _saveAnimationStartTime = getTimer();
         _signal_animateSave.dispatch();
      }
      
      private function handler_stateUpdateBattle(param1:DungeonFloorBattleState) : void
      {
         _state_battle.value = param1;
      }
      
      private function handler_stateUpdateSave(param1:DungeonFloorSaveState) : void
      {
         _state_saveIsCaptured.value = param1 == DungeonFloorSaveState.ALREADY_SAVED;
         _state_saveCanBeCaptured.value = param1 == DungeonFloorSaveState.CAN_SAVE;
      }
   }
}
