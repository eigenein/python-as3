package game.mediator.gui.popup.hero
{
   import game.data.storage.hero.HeroDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class PlayerHeroElementListValueObject extends PlayerHeroListValueObject
   {
       
      
      public function PlayerHeroElementListValueObject(param1:HeroDescription, param2:Player)
      {
         super(param1,param2);
         if(_playerEntry)
         {
            _playerEntry.signal_titanGiftLevelChange.add(handler_titanGiftLevelChange);
         }
      }
      
      override public function dispose() : void
      {
         if(_playerEntry)
         {
            _playerEntry.signal_titanGiftLevelChange.remove(handler_titanGiftLevelChange);
         }
         super.dispose();
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.titanGiftLevelUpAvaliable;
      }
      
      private function handler_titanGiftLevelChange(param1:PlayerHeroEntry) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
