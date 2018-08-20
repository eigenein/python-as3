package game.data.reward
{
   public class RewardTitanExp
   {
       
      
      public var id:int;
      
      public var exp:int;
      
      public function RewardTitanExp()
      {
         super();
      }
      
      public function toString() : String
      {
         return id + ":" + exp;
      }
   }
}
