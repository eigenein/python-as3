package game.mediator.gui.popup.hero
{
   import game.data.storage.hero.HeroDescription;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class PlayerHeroEntryValueObject extends HeroEntryValueObject
   {
       
      
      public function PlayerHeroEntryValueObject(param1:HeroDescription, param2:HeroEntry)
      {
         super(param1,param2);
      }
      
      protected function get _playerEntry() : PlayerHeroEntry
      {
         return _heroEntry as PlayerHeroEntry;
      }
      
      public function get playerEntry() : PlayerHeroEntry
      {
         return _playerEntry;
      }
      
      public function get exp() : int
      {
         return !!_playerEntry?_playerEntry.experience:0;
      }
      
      public function get expNextLvl() : int
      {
         if(!_playerEntry)
         {
            return 0;
         }
         return !!_playerEntry.level.nextLevel?_playerEntry.level.nextLevel.exp:int(_playerEntry.experience);
      }
   }
}
