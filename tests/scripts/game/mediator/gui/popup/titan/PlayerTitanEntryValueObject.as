package game.mediator.gui.popup.titan
{
   import game.data.storage.titan.TitanDescription;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.TitanEntry;
   
   public class PlayerTitanEntryValueObject extends TitanEntryValueObject
   {
       
      
      public function PlayerTitanEntryValueObject(param1:TitanDescription, param2:TitanEntry)
      {
         super(param1,param2);
      }
      
      protected function get _playerEntry() : PlayerTitanEntry
      {
         return _titanEntry as PlayerTitanEntry;
      }
      
      public function get playerEntry() : PlayerTitanEntry
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
