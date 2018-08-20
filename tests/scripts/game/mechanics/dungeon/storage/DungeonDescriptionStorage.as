package game.mechanics.dungeon.storage
{
   import flash.utils.Dictionary;
   
   public class DungeonDescriptionStorage
   {
       
      
      private var floor:Vector.<DungeonFloorDescription>;
      
      private var _dynamicFloorCount:int;
      
      private var _staticFloorCount:int;
      
      private var _firstDynamicFloorId:int;
      
      private var floor_staticById:Dictionary;
      
      private var floor_dynamicById:Dictionary;
      
      public function DungeonDescriptionStorage()
      {
         floor = new Vector.<DungeonFloorDescription>();
         floor_staticById = new Dictionary();
         floor_dynamicById = new Dictionary();
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _firstDynamicFloorId = 2147483647;
         var _loc5_:int = 0;
         var _loc4_:* = param1.floor;
         for each(_loc2_ in param1.floor)
         {
            _loc3_ = new DungeonFloorDescription(_loc2_);
            if(!_loc3_.isStatic)
            {
               _firstDynamicFloorId = Math.min(_loc3_.id,_firstDynamicFloorId);
            }
            if(_loc3_.isStatic)
            {
               _staticFloorCount = Number(_staticFloorCount) + 1;
               floor_staticById[_loc3_.id] = _loc3_;
            }
            if(!_loc3_.isStatic)
            {
               _dynamicFloorCount = Number(_dynamicFloorCount) + 1;
               floor_dynamicById[_loc3_.id] = _loc3_;
            }
            floor.push(_loc3_);
         }
      }
      
      public function getDescriptionByFloorNumber(param1:int) : DungeonFloorDescription
      {
         if(param1 <= _staticFloorCount)
         {
            return floor_staticById[param1];
         }
         return floor_dynamicById[(param1 - _staticFloorCount - 1) % _dynamicFloorCount + _firstDynamicFloorId];
      }
   }
}
