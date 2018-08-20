package game.data.reward
{
   import game.data.storage.hero.HeroDescription;
   
   public class RewardHero
   {
       
      
      private var _desc:HeroDescription;
      
      public function RewardHero(param1:HeroDescription)
      {
         super();
         this._desc = param1;
      }
      
      public function get desc() : HeroDescription
      {
         return _desc;
      }
   }
}
