package game.mechanics.dungeon.mediator
{
   import engine.core.utils.property.IntPropertyWriteable;
   import game.mechanics.dungeon.popup.list.DungeonRoomList;
   
   public class DungeonFloorGroupValueObject
   {
      
      private static var _property_horizontalScrollPosition:IntPropertyWriteable = new IntPropertyWriteable();
      
      private static var _registeredLists:Vector.<DungeonRoomList>;
       
      
      private var _data:Vector.<DungeonFloorValueObject>;
      
      private var _property_verticalScrollPosition:IntPropertyWriteable;
      
      private var _commonState:DungeonScreenState;
      
      public function DungeonFloorGroupValueObject(param1:DungeonScreenState)
      {
         _data = new Vector.<DungeonFloorValueObject>();
         _property_verticalScrollPosition = new IntPropertyWriteable();
         super();
         this._commonState = param1;
      }
      
      public static function get property_horizontalScrollPosition() : IntPropertyWriteable
      {
         return _property_horizontalScrollPosition;
      }
      
      public static function get listToTween() : DungeonRoomList
      {
         return _registeredLists && _registeredLists.length > 0?_registeredLists[0]:null;
      }
      
      public static function action_scrollToIndex(param1:int, param2:Number = 0, param3:String = null) : void
      {
         if(param3 != null)
         {
            _registeredLists[0].throwEase = param3;
         }
         _registeredLists[0].scrollToDisplayIndex(param1,param2);
      }
      
      public static function action_scrollToPosition(param1:Number, param2:Number = NaN, param3:Number = 0, param4:String = null) : void
      {
         if(param4 != null)
         {
            _registeredLists[0].throwEase = param4;
         }
         _registeredLists[0].scrollToPosition(param1,param2,param3);
      }
      
      public static function action_registerList(param1:DungeonRoomList) : void
      {
         if(!_registeredLists)
         {
            _registeredLists = new Vector.<DungeonRoomList>();
         }
         var _loc2_:int = _registeredLists.indexOf(param1);
         if(_loc2_ == -1)
         {
            _registeredLists.push(param1);
         }
      }
      
      public static function action_unregisterList(param1:DungeonRoomList) : void
      {
         if(!_registeredLists)
         {
            _registeredLists = new Vector.<DungeonRoomList>();
         }
         var _loc2_:int = _registeredLists.indexOf(param1);
         if(_loc2_ != -1)
         {
            _registeredLists.splice(_loc2_,1);
         }
      }
      
      public static function action_dispose() : void
      {
         _registeredLists = null;
         _property_horizontalScrollPosition.signal_update.clear();
      }
      
      public static function get registeredLists() : Vector.<DungeonRoomList>
      {
         return _registeredLists;
      }
      
      public function get data() : Vector.<DungeonFloorValueObject>
      {
         return _data;
      }
      
      public function get property_verticalScrollPosition() : IntPropertyWriteable
      {
         return _property_verticalScrollPosition;
      }
      
      public function get commonState() : DungeonScreenState
      {
         return _commonState;
      }
   }
}
