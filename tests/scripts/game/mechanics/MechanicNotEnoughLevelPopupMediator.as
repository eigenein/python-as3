package game.mechanics
{
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class MechanicNotEnoughLevelPopupMediator extends PopupMediator
   {
       
      
      private var mechanic:MechanicDescription;
      
      public function MechanicNotEnoughLevelPopupMediator(param1:Player, param2:MechanicDescription)
      {
         super(param1);
         this.mechanic = param2;
      }
      
      public function get level() : int
      {
         return mechanic.teamLevel;
      }
      
      public function get mechanicType() : String
      {
         return mechanic.type;
      }
      
      public function isClanMechanic() : Boolean
      {
         return mechanic == MechanicStorage.CLAN;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MechanicNotEnoughLevelPopup(this);
         return _popup;
      }
   }
}
