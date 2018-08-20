package game.data.storage.tower
{
   public class TowerBattleDifficulty
   {
      
      public static const NORMAL:TowerBattleDifficulty = new TowerBattleDifficulty(1);
      
      public static const HARD:TowerBattleDifficulty = new TowerBattleDifficulty(2);
       
      
      private var _value:int;
      
      public function TowerBattleDifficulty(param1:int)
      {
         super();
         _value = param1;
      }
      
      public static function fromInt(param1:int) : TowerBattleDifficulty
      {
         if(param1 == 1)
         {
            return NORMAL;
         }
         return HARD;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}
