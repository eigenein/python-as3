package game.mechanics.expedition.mediator
{
   import game.mechanics.expedition.popup.ExpeditionRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ExpeditionRewardPopupMediator extends PopupMediator
   {
       
      
      private var _expedition:ExpeditionValueObject;
      
      public function ExpeditionRewardPopupMediator(param1:Player, param2:ExpeditionValueObject)
      {
         this._expedition = param2;
         super(param1);
      }
      
      public function get expedition() : ExpeditionValueObject
      {
         return _expedition;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ExpeditionRewardPopup(this);
         return _popup;
      }
   }
}
