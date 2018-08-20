package game.mediator.gui.popup.hero
{
   import game.data.storage.hero.HeroDescription;
   import game.model.user.Player;
   
   public class PlayerHeroRuneListValueObject extends PlayerHeroListValueObject
   {
       
      
      public function PlayerHeroRuneListValueObject(param1:HeroDescription, param2:Player)
      {
         super(param1,param2);
         _watch.property_canEnchantRune.signal_update.add(handler_canEnchanrRuneUpdated);
      }
      
      override public function dispose() : void
      {
         _watch.property_canEnchantRune.unsubscribe(handler_canEnchanrRuneUpdated);
         super.dispose();
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.property_canEnchantRune.value;
      }
      
      private function handler_canEnchanrRuneUpdated(param1:Boolean) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
