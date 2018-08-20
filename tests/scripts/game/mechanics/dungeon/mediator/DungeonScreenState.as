package game.mechanics.dungeon.mediator
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   import game.mechanics.dungeon.model.PlayerDungeonFloor;
   import game.mechanics.dungeon.popup.floor.DungeonFloorTeamContainer;
   import game.mechanics.dungeon.popup.list.DungeonFloorGroupRenderer;
   import game.mechanics.dungeon.popup.list.DungeonRoomItemRenderer;
   import org.osflash.signals.Signal;
   import starling.display.DisplayObject;
   
   public class DungeonScreenState
   {
       
      
      private var unitContainers:Dictionary;
      
      private var _property_horizontalScrollPosition:IntPropertyWriteable;
      
      private var _floor:PlayerDungeonFloor;
      
      private var _rowVo:DungeonFloorGroupValueObject;
      
      private var _itemVo:DungeonFloorValueObject;
      
      private var _rowIndex:int;
      
      private var _columnIndex:int;
      
      private var _rowRenderer:DungeonFloorGroupRenderer;
      
      private var _itemRenderer:DungeonRoomItemRenderer;
      
      private var _heroesRowVo:DungeonFloorGroupValueObject;
      
      private var _units:DisplayObject;
      
      private var _currentUnitContainer:DungeonFloorTeamContainer;
      
      public const signal_prepareHeroesToMovement:Signal = new Signal();
      
      public const signal_battleEnd:Signal = new Signal();
      
      public const signal_startHeroTravel:Signal = new Signal();
      
      public const signal_cheatTeleportHeroes:Signal = new Signal();
      
      public const signal_readyToSave:Signal = new Signal();
      
      public function DungeonScreenState()
      {
         unitContainers = new Dictionary();
         _property_horizontalScrollPosition = new IntPropertyWriteable();
         super();
      }
      
      public function get floor() : PlayerDungeonFloor
      {
         return _floor;
      }
      
      public function get rowVo() : DungeonFloorGroupValueObject
      {
         return _rowVo;
      }
      
      public function get itemVo() : DungeonFloorValueObject
      {
         return _itemVo;
      }
      
      public function get rowRenderer() : DungeonFloorGroupRenderer
      {
         return _rowRenderer;
      }
      
      public function get itemRenderer() : DungeonRoomItemRenderer
      {
         return _itemRenderer;
      }
      
      public function get rowIndex() : int
      {
         return _rowIndex;
      }
      
      public function get columnIndex() : int
      {
         return _columnIndex;
      }
      
      public function get property_horizontalScrollPosition() : IntProperty
      {
         return _property_horizontalScrollPosition;
      }
      
      public function setCurrentState(param1:PlayerDungeonFloor, param2:DungeonFloorGroupValueObject, param3:DungeonFloorValueObject, param4:int, param5:int) : void
      {
         this._floor = param1;
         this._rowVo = param2;
         this._itemVo = param3;
         this._rowIndex = param4;
         this._columnIndex = param5;
         this._rowRenderer = rowRenderer;
         this._itemRenderer = itemRenderer;
      }
      
      public function registerHeroContainer(param1:DungeonFloorGroupValueObject, param2:DungeonFloorTeamContainer) : void
      {
         unitContainers[param1] = param2;
         if(_heroesRowVo == param1)
         {
            _currentUnitContainer = param2;
            _currentUnitContainer.x = -_property_horizontalScrollPosition.value;
            if(_units != null)
            {
               _currentUnitContainer.addChild(_units);
            }
         }
      }
      
      public function addHeroes(param1:DungeonFloorGroupValueObject, param2:DisplayObject) : void
      {
         _heroesRowVo = param1;
         this._units = param2;
         if(unitContainers[param1])
         {
            _currentUnitContainer = unitContainers[param1];
            _currentUnitContainer.x = -_property_horizontalScrollPosition.value;
         }
         if(_currentUnitContainer)
         {
            _currentUnitContainer.addChild(param2);
         }
      }
      
      public function setScrollPosition(param1:Number) : void
      {
         _property_horizontalScrollPosition.value = int(param1);
      }
   }
}
