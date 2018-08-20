package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.specialoffer.PlayerSpecialOfferDailyReward;
   import game.model.user.specialoffer.PlayerSpecialOfferTripleSkinBundle;
   
   public class QuestEventSkinShopValueObject extends QuestEventValueObjectBase
   {
       
      
      private var _mediator:SkinShopMediator;
      
      public function QuestEventSkinShopValueObject(param1:PlayerSpecialOfferTripleSkinBundle, param2:PlayerSpecialOfferDailyReward)
      {
         super(player);
         _mediator = new SkinShopMediator(param1,param2);
         if(_mediator.dailyRewardOffer)
         {
            _mediator.dailyRewardOffer.freeRewardObtained.onValue(handler_update);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_mediator.dailyRewardOffer)
         {
            mediator.dailyRewardOffer.freeRewardObtained.unsubscribe(handler_update);
         }
      }
      
      override public function get hasEndTime() : Boolean
      {
         return true;
      }
      
      override public function get endTime() : Number
      {
         return _mediator.offer.endTime;
      }
      
      override public function get name() : String
      {
         return Translate.translate(_mediator.offer.titleLocale);
      }
      
      override public function get desc() : String
      {
         return "";
      }
      
      override public function get iconAsset() : String
      {
         return _mediator.offer.iconAsset;
      }
      
      override public function get backgroundAsset() : String
      {
         return null;
      }
      
      override public function get sortOrder() : int
      {
         return 1;
      }
      
      override public function get canFarmSortIgnore() : Boolean
      {
         return true;
      }
      
      public function get mediator() : SkinShopMediator
      {
         return _mediator;
      }
      
      private function handler_update(param1:Boolean) : void
      {
         _canFarm.value = !param1;
      }
   }
}
