package game.mechanics.dungeon.model.state
{
   import flash.utils.Dictionary;
   
   public class DungeonFloorElement
   {
      
      public static const FIRE:DungeonFloorElement = new DungeonFloorElement("fire");
      
      public static const WATER:DungeonFloorElement = new DungeonFloorElement("water");
      
      public static const EARTH:DungeonFloorElement = new DungeonFloorElement("earth");
      
      public static const NEUTRAL:DungeonFloorElement = new DungeonFloorElement("neutral");
      
      private static var elements:Dictionary;
       
      
      private var _ident:String;
      
      public function DungeonFloorElement(param1:String)
      {
         super();
         this._ident = param1;
         if(!elements)
         {
            elements = new Dictionary();
         }
         elements[_ident] = this;
      }
      
      public static function getByIdent(param1:String) : DungeonFloorElement
      {
         return elements[param1];
      }
      
      public function get ident() : String
      {
         return _ident;
      }
   }
}
