package game.model.user.specialoffer
{
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.view.specialoffer.multibundle.CyberMondayTripleSkinCoinPopupMediator;
   
   public class PlayerSpecialOfferMultiBundleCyberMonday2017 extends PlayerSpecialOfferMultiBundle
   {
      
      public static const OFFER_TYPE:String = "multibundleBlackFriday2017SkinCoins";
       
      
      public function PlayerSpecialOfferMultiBundleCyberMonday2017(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override protected function handler_openPopup(param1:PopupStashEventParams) : void
      {
         var _loc2_:CyberMondayTripleSkinCoinPopupMediator = new CyberMondayTripleSkinCoinPopupMediator(player,this);
         _loc2_.open(param1);
      }
   }
}
