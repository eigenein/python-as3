package game.mechanics.titan_arena.mediator.trophies
{
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaHallOfFameGetTrophies;
   import game.mechanics.titan_arena.popup.trophies.TitanArenaTrophiesPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class TitanArenaTrophiesPopupMediator extends PopupMediator
   {
       
      
      public function TitanArenaTrophiesPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaTrophiesPopup(this);
         return _popup;
      }
      
      public function getTrophyList() : Vector.<PlayerTitanArenaTrophyData>
      {
         return player.titanArenaData.getTrophyList();
      }
      
      public function action_navigate_arena() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_ARENA,Stash.click("titan_arena",_popup.stashParams));
      }
      
      private function handler_hallOfFameGetTrophies(param1:CommandTitanArenaHallOfFameGetTrophies) : void
      {
      }
   }
}
