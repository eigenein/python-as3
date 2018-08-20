package game.mechanics.clan_war.mediator
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.popup.leaguesandrewards.ClanWarLeaguesAndRewardsPopup;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ClanWarLeaguesAndRewardsPopupMediator extends PopupMediator
   {
       
      
      public function ClanWarLeaguesAndRewardsPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      public function get leagues() : Vector.<ClanWarLeagueDescription>
      {
         return DataStorage.clanWar.getLeaguesList();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarLeaguesAndRewardsPopup(this);
         return _popup;
      }
   }
}
