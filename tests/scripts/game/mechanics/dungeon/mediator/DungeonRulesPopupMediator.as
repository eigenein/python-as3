package game.mechanics.dungeon.mediator
{
   import game.mechanics.dungeon.popup.DungeonRulesPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class DungeonRulesPopupMediator extends PopupMediator
   {
       
      
      public function DungeonRulesPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonRulesPopup(this);
         return _popup;
      }
   }
}
