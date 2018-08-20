package game.model.user.specialoffer
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.specialoffer.blackfriday2017.SpecialOfferBlackFriday2017PopupMediator;
   
   public class PlayerSpecialOfferBlackFriday2017 extends PlayerSpecialOfferCostReplaceAllChests
   {
      
      public static const OFFER_TYPE:String = "blackFriday2017";
       
      
      public function PlayerSpecialOfferBlackFriday2017(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override protected function createPopup() : PopupMediator
      {
         return new SpecialOfferBlackFriday2017PopupMediator(player,this,100,101);
      }
   }
}
