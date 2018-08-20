package game.mediator.gui.popup.billing.vip
{
   import feathers.data.ListCollection;
   import game.data.storage.level.VIPLevel;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.VipBenefitPopup;
   import idv.cjcat.signals.Signal;
   
   public class VipBenefitPopupMediator extends PopupMediator
   {
       
      
      private var _selectedVipLevel:VIPLevel;
      
      private const vipBenefitsAggregator:VipBenefitDataAggregator = new VipBenefitDataAggregator();
      
      public const benefitDataProvider:ListCollection = new ListCollection();
      
      public const signal_updateSelectedVip:Signal = new Signal();
      
      public function VipBenefitPopupMediator(param1:Player)
      {
         super(param1);
         _selectedVipLevel = (!!param1.vipLevel.nextLevel?param1.vipLevel.nextLevel:param1.vipLevel) as VIPLevel;
         updateBenefits();
      }
      
      override protected function dispose() : void
      {
      }
      
      public function get signal_updateVip() : Signal
      {
         return player.signal_update.vip_points;
      }
      
      public function get selectedVipLevel() : int
      {
         return _selectedVipLevel.level;
      }
      
      public function get hasNextVipLevel() : Boolean
      {
         return _selectedVipLevel.nextLevel;
      }
      
      public function get hasPrevVipLevel() : Boolean
      {
         return _selectedVipLevel.level > 1;
      }
      
      public function get targetLevelVipPoints() : int
      {
         if(_selectedVipLevel.level <= player.vipLevel.level)
         {
            return player.vipLevel.nextLevel.exp;
         }
         return _selectedVipLevel.exp;
      }
      
      public function get targetLevel() : int
      {
         if(_selectedVipLevel.level <= player.vipLevel.level)
         {
            return player.vipLevel.level + 1;
         }
         return _selectedVipLevel.level;
      }
      
      public function get playerVipPoints() : int
      {
         return player.vipPoints;
      }
      
      public function get playerVipLevel() : int
      {
         return player.vipLevel.level;
      }
      
      public function get playerHasNextVipLevel() : Boolean
      {
         return player.vipLevel.nextLevel;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new VipBenefitPopup(this);
         return _popup;
      }
      
      public function action_next() : void
      {
         if(hasNextVipLevel)
         {
            _selectedVipLevel = _selectedVipLevel.nextLevel as VIPLevel;
            updateBenefits();
            signal_updateSelectedVip.dispatch();
         }
      }
      
      public function action_prev() : void
      {
         if(hasPrevVipLevel)
         {
            _selectedVipLevel = _selectedVipLevel.prevLevel as VIPLevel;
            updateBenefits();
            signal_updateSelectedVip.dispatch();
         }
      }
      
      public function action_toStore() : void
      {
         var _loc1_:PopupStashEventParams = _popup.stashParams;
         var _loc2_:BillingPopupMediator = new BillingPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("action_toStore",_loc1_));
         close();
      }
      
      protected function updateBenefits() : void
      {
         var _loc1_:Vector.<VipBenefitValueObject> = vipBenefitsAggregator.getBenefitsByLevel(selectedVipLevel);
         benefitDataProvider.data = _loc1_;
      }
   }
}
