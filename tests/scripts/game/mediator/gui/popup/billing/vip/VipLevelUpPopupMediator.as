package game.mediator.gui.popup.billing.vip
{
   import feathers.data.ListCollection;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.vip.VipLevelUpPopup;
   
   public class VipLevelUpPopupMediator extends PopupMediator
   {
       
      
      private const vipBenefitsAggregator:VipBenefitDataAggregator = new VipBenefitDataAggregator();
      
      public const benefitDataProvider:ListCollection = new ListCollection();
      
      public function VipLevelUpPopupMediator(param1:Player, param2:int)
      {
         super(param1);
         var _loc3_:Vector.<VipBenefitValueObject> = vipBenefitsAggregator.getBenefitsByLevel(param2);
         benefitDataProvider.data = _loc3_;
      }
      
      public function get vipLevel() : int
      {
         return player.vipLevel.level;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new VipLevelUpPopup(this);
         return _popup;
      }
   }
}
