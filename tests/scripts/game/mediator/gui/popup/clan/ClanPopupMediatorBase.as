package game.mediator.gui.popup.clan
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   
   public class ClanPopupMediatorBase extends PopupMediator
   {
       
      
      public function ClanPopupMediatorBase(param1:Player)
      {
         super(param1);
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_clanUpdate.remove(handler_clanUpdate);
         super.dispose();
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
