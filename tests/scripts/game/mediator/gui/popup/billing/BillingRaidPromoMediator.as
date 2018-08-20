package game.mediator.gui.popup.billing
{
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.stat.Stash;
   import game.view.popup.billing.promo.RaidPromoSideBarRewardView;
   
   public class BillingRaidPromoMediator
   {
       
      
      private var stashParams:PopupStashEventParams;
      
      private var billing:BillingPopupValueObject;
      
      private var player:Player;
      
      private var sideBarBlockValueObject:SideBarBlockValueObject;
      
      private const _sideBarValueObjectsData:Vector.<SideBarBlockValueObject> = new Vector.<SideBarBlockValueObject>();
      
      private const _sideBarValueObjects:VectorPropertyWriteable = new VectorPropertyWriteable(_sideBarValueObjectsData as Vector.<*>);
      
      public function BillingRaidPromoMediator(param1:Player)
      {
         sideBarBlockValueObject = new SideBarBlockValueObject(1);
         super();
         this.player = param1;
         updateBilling();
         sideBarBlockValueObject.signal_initialize.add(handler_initializeBlock);
      }
      
      public function get sideBarValueObjects() : VectorProperty
      {
         return _sideBarValueObjects;
      }
      
      public function updateBilling() : void
      {
         _sideBarValueObjects.remove(sideBarBlockValueObject);
         var _loc1_:PlayerBillingDescription = player.billingData.getRaidPromoBilling();
         if(_loc1_)
         {
            _sideBarValueObjects.push(sideBarBlockValueObject);
            billing = new BillingPopupValueObject(_loc1_,player);
         }
      }
      
      private function handler_initializeBlock(param1:SideBarBlockValueObject) : void
      {
         if(!billing)
         {
            return;
         }
         var _loc2_:RaidPromoSideBarRewardView = new RaidPromoSideBarRewardView(billing);
         _loc2_.signal_click.add(handler_promoBillingClick);
         param1.sideBarBlock = _loc2_;
      }
      
      private function handler_promoBillingClick(param1:PopupStashEventParams) : void
      {
         var _loc2_:RaidPromoPopupMediator = new RaidPromoPopupMediator(player);
         _loc2_.open(Stash.click("raid_promo_billing",param1));
      }
   }
}
