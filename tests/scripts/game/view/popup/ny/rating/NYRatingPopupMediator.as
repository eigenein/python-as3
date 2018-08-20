package game.view.popup.ny.rating
{
   import game.mediator.gui.popup.rating.RatingPopupMediator;
   import game.model.user.Player;
   
   public class NYRatingPopupMediator extends RatingPopupMediator
   {
       
      
      public function NYRatingPopupMediator(param1:Player)
      {
         super(param1);
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
      }
      
      override protected function createTabs() : Vector.<String>
      {
         return new <String>["giftsSend","giftsReceived","nyTree"];
      }
      
      private function handler_clanUpdate() : void
      {
         if(player.clan.clan == null)
         {
            close();
         }
      }
   }
}
