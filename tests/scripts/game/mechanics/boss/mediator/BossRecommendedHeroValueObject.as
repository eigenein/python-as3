package game.mechanics.boss.mediator
{
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.GameModel;
   import game.model.user.hero.HeroEntry;
   
   public class BossRecommendedHeroValueObject extends HeroEntryValueObject
   {
       
      
      public function BossRecommendedHeroValueObject(param1:HeroDescription, param2:HeroEntry)
      {
         super(param1,param2);
      }
      
      public static function sort_byFragments(param1:BossRecommendedHeroValueObject, param2:BossRecommendedHeroValueObject) : int
      {
         if(param1._heroEntry && !param2._heroEntry)
         {
            return -1;
         }
         if(!param1._heroEntry && param2._heroEntry)
         {
            return 1;
         }
         return GameModel.instance.player.inventory.getFragmentCount(param1.hero) - GameModel.instance.player.inventory.getFragmentCount(param2.hero);
      }
      
      override public function get starCount() : int
      {
         if(_heroEntry)
         {
            return !!_heroEntry.star?_heroEntry.star.star.id:0;
         }
         return hero.startingStar.star.id;
      }
   }
}
