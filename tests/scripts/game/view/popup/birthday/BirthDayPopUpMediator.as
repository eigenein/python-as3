package game.view.popup.birthday
{
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferWithSideBarIcon;
   import game.view.popup.PopupBase;
   
   public class BirthDayPopUpMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferWithSideBarIcon;
      
      public function BirthDayPopUpMediator(param1:Player, param2:PlayerSpecialOfferWithSideBarIcon)
      {
         super(param1);
         this.offer = param2;
      }
      
      public function get bonusDuration() : Number
      {
         var _loc1_:PlayerSpecialOfferWithSideBarIcon = player.specialOffer.getSpecialOffer("sideBarIcon") as PlayerSpecialOfferWithSideBarIcon;
         if(_loc1_)
         {
            return _loc1_.endTime - GameTimer.instance.currentServerTime;
         }
         return 0;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BirthDayPopUp(this);
         return _popup;
      }
      
      public function action_continue() : void
      {
         close();
      }
   }
}
