package game.mediator.gui.popup.billing
{
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeat;
   import starling.textures.Texture;
   
   public class BillingPopupValueObjectWithBonus extends BillingPopupValueObject
   {
       
      
      private var _bonus:int = 0;
      
      private var specialOffer:PlayerSpecialOfferPaymentRepeat;
      
      public function BillingPopupValueObjectWithBonus(param1:PlayerBillingDescription, param2:Player, param3:PlayerSpecialOfferPaymentRepeat)
      {
         super(param1,param2);
         this.specialOffer = param3;
      }
      
      public function set bonus(param1:int) : void
      {
         _bonus = param1;
      }
      
      public function get bonus() : int
      {
         return _bonus;
      }
      
      override public function get useGoldFrame() : Boolean
      {
         return true;
      }
      
      override public function get background() : Texture
      {
         return specialOffer.billingBackgroundTexture;
      }
      
      override public function get hasBackground() : Boolean
      {
         return true;
      }
      
      override public function get saleStickerText() : String
      {
         if(specialOffer.hideDefaultSaleSticker)
         {
            return null;
         }
         return super.saleStickerText;
      }
      
      override public function get mainStarmoneyReward() : Number
      {
         return reward.starmoney + vipBonusStarmoney + _bonus;
      }
      
      override public function get hasBonuses() : Boolean
      {
         return super.hasBonuses || _bonus > 0;
      }
   }
}
