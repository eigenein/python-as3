package game.mechanics.dungeon.popup.list
{
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonFloorGroupValueObject;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.popup.floor.DungeonFloorTeamContainer;
   import game.mechanics.dungeon.popup.floor.DungeonScreenColumnsClip;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class DungeonFloorGroupRenderer extends ListItemRenderer
   {
       
      
      private var _vo:DungeonFloorGroupValueObject;
      
      private var parallaxLayerTest_front:DungeonScreenColumnsClip;
      
      private var unitContainer:DungeonFloorTeamContainer;
      
      private var _frontContainer:Sprite;
      
      private var columnMoveSpeed:Number = 2.2;
      
      private var _list:DungeonRoomList;
      
      private var _signal_select:Signal;
      
      private var _signal_saveProgress:Signal;
      
      public function DungeonFloorGroupRenderer()
      {
         unitContainer = new DungeonFloorTeamContainer();
         _frontContainer = new Sprite();
         _signal_select = new Signal(DungeonFloorValueObject);
         _signal_saveProgress = new Signal(DungeonFloorValueObject);
         super();
      }
      
      override public function dispose() : void
      {
         DungeonFloorGroupValueObject.property_horizontalScrollPosition.signal_update.remove(handler_scrollUpdate);
         super.dispose();
      }
      
      public function get list() : DungeonRoomList
      {
         return _list;
      }
      
      override public function set data(param1:Object) : void
      {
         if(!_vo)
         {
         }
         .super.data = param1;
         _vo = param1 as DungeonFloorGroupValueObject;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_saveProgress() : Signal
      {
         return _signal_saveProgress;
      }
      
      public function scrollListTo(param1:int) : void
      {
         _list.horizontalScrollPosition = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         _list = new DungeonRoomList();
         addChild(_list);
         _list.width = 1000;
         height = 490;
         clipContent = false;
         _list.clipContent = false;
         _list.addDataListener("ListItemRenderer.EVENT_SELECT",handler_selectFloor);
         _list.addDataListener("DungeonRoomItemRenderer.EVENT_SAVE_PROGRESS",handler_saveProgress);
         _list.addEventListener("rendererAdd",handler_listRendererAdded);
         _list.addEventListener("rendererRemove",handler_listRendererRemoved);
         _list.property_scrollValue.signal_update.add(handler_scrollValueUpdate);
         (_list.layout as HorizontalLayout).paddingRight = 290;
         (_list.layout as HorizontalLayout).paddingLeft = 290;
         addChild(unitContainer);
         addChild(_frontContainer);
         parallaxLayerTest_front = AssetStorage.rsx.dungeon_floors.create(DungeonScreenColumnsClip,"parallaxLayerTest_front");
         addChild(parallaxLayerTest_front.graphics);
         parallaxLayerTest_front.graphics.touchable = false;
         var _loc1_:int = parallaxLayerTest_front.column.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            parallaxLayerTest_front.column[_loc2_].graphics.x = _loc2_ * (1000 + 300) * columnMoveSpeed;
            _loc2_++;
         }
         DungeonFloorGroupValueObject.property_horizontalScrollPosition.signal_update.add(handler_scrollUpdate);
         handler_scrollUpdate(DungeonFloorGroupValueObject.property_horizontalScrollPosition.value);
      }
      
      override protected function commitData() : void
      {
         if(_vo)
         {
            _list.dataProvider = new ListCollection(_vo.data);
            _list.horizontalScrollPosition = DungeonFloorGroupValueObject.property_horizontalScrollPosition.value;
            _vo.commonState.registerHeroContainer(_vo,unitContainer);
         }
      }
      
      private function handler_listRendererAdded(param1:Event, param2:DungeonRoomItemRenderer) : void
      {
         var _loc3_:DisplayObject = param2.frontDisplayObject;
         if(_loc3_)
         {
            _frontContainer.addChild(_loc3_);
         }
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:DungeonRoomItemRenderer) : void
      {
         var _loc3_:DisplayObject = param2.frontDisplayObject;
         if(_loc3_)
         {
            _frontContainer.removeChild(_loc3_);
         }
      }
      
      private function handler_saveProgress(param1:DungeonFloorValueObject) : void
      {
         _signal_saveProgress.dispatch(param1);
      }
      
      private function handler_selectFloor(param1:DungeonFloorValueObject) : void
      {
         _signal_select.dispatch(param1);
      }
      
      private function handler_scrollValueUpdate(param1:int) : void
      {
         DungeonFloorGroupValueObject.property_horizontalScrollPosition.value = param1;
         _frontContainer.x = -param1;
         unitContainer.x = -param1;
         if(_vo)
         {
            _vo.commonState.setScrollPosition(param1);
         }
      }
      
      private function handler_scrollUpdate(param1:int) : void
      {
         parallaxLayerTest_front.graphics.x = -param1 * columnMoveSpeed;
         _list.horizontalScrollPosition = param1;
      }
   }
}
