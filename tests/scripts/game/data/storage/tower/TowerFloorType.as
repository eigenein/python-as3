package game.data.storage.tower
{
   public class TowerFloorType
   {
      
      public static const BATTLE:TowerFloorType = new TowerFloorType("battle");
      
      public static const BUFF:TowerFloorType = new TowerFloorType("buff");
      
      public static const CHEST:TowerFloorType = new TowerFloorType("chest");
       
      
      private var _ident:String = "";
      
      public function TowerFloorType(param1:String)
      {
         super();
         _ident = param1;
      }
      
      public static function getByIdent(param1:String) : TowerFloorType
      {
         if(param1 == BATTLE.ident)
         {
            return BATTLE;
         }
         if(param1 == BUFF.ident)
         {
            return BUFF;
         }
         if(param1 == BATTLE.ident)
         {
            return CHEST;
         }
         return CHEST;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
   }
}
