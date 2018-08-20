package game.data.reward
{
   public class RewardHeroExp
   {
       
      
      public var id:int;
      
      public var exp:int;
      
      public function RewardHeroExp()
      {
         super();
      }
      
      public function toString() : String
      {
         return id + ":" + exp;
      }
   }
}
