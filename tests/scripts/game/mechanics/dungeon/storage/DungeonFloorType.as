package game.mechanics.dungeon.storage
{
   public class DungeonFloorType
   {
      
      public static const BATTLE_TITAN_CHOICE:DungeonFloorType = new DungeonFloorType("battle_titan_choice");
      
      public static const BATTLE_TITAN_SINGLE:DungeonFloorType = new DungeonFloorType("battle_titan_single");
      
      public static const BATTLE_HERO:DungeonFloorType = new DungeonFloorType("battle_hero");
       
      
      private var _ident:String;
      
      public function DungeonFloorType(param1:String)
      {
         super();
         _ident = param1;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get isTitanBattle() : Boolean
      {
         return _ident == BATTLE_TITAN_CHOICE.ident || _ident == BATTLE_TITAN_SINGLE.ident;
      }
      
      public function get isBattle() : Boolean
      {
         return _ident == BATTLE_TITAN_CHOICE.ident || _ident == BATTLE_TITAN_SINGLE.ident || _ident == BATTLE_HERO.ident;
      }
   }
}
