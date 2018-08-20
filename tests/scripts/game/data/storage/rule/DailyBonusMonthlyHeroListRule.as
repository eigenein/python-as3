package game.data.storage.rule
{
   import flash.utils.Dictionary;
   
   public class DailyBonusMonthlyHeroListRule
   {
       
      
      private var heroes:Dictionary;
      
      public function DailyBonusMonthlyHeroListRule(param1:Object)
      {
         var _loc3_:int = 0;
         super();
         heroes = new Dictionary();
         var _loc2_:int = param1.heroes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            heroes[_loc3_ + 1] = param1.heroes[_loc3_];
            _loc3_++;
         }
      }
      
      public function getHeroIdByMonth(param1:int) : int
      {
         return heroes[param1];
      }
   }
}
