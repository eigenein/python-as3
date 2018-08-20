package game.mechanics.dungeon.model.state
{
   public class DungeonFloorElementalGroup
   {
       
      
      private var _element1:DungeonFloorElement;
      
      private var _element2:DungeonFloorElement;
      
      private var _DEFAULT:DungeonFloorElementalGroup;
      
      public function DungeonFloorElementalGroup(param1:DungeonFloorElement, param2:DungeonFloorElement = null)
      {
         super();
         this._element1 = param1;
         if(!param2)
         {
            param2 = param1;
         }
         this._element2 = param2;
      }
      
      public function get element1() : DungeonFloorElement
      {
         return _element1;
      }
      
      public function get element2() : DungeonFloorElement
      {
         return _element2;
      }
      
      public function get differentElements() : Boolean
      {
         return _element1 != _element2;
      }
      
      public function get DEFAULT() : DungeonFloorElementalGroup
      {
         if(!_DEFAULT)
         {
            _DEFAULT = new DungeonFloorElementalGroup(DungeonFloorElement.NEUTRAL,DungeonFloorElement.NEUTRAL);
         }
         return _DEFAULT;
      }
   }
}
