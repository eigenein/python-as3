package battle.log
{
   public class BattleLogNameResolver
   {
       
      
      public function BattleLogNameResolver()
      {
      }
      
      public function skill(param1:int, param2:int) : String
      {
         return "" + param1 + " умения";
      }
      
      public function hero(param1:int) : String
      {
         return "" + param1;
      }
   }
}
