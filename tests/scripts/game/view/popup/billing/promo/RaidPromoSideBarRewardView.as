package game.view.popup.billing.promo
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBarSide;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   
   public class RaidPromoSideBarRewardView implements IPopupSideBarBlock
   {
       
      
      private var _stashEventParams:PopupStashEventParams;
      
      private var _clip:BillingPromoButtonClip;
      
      public const signal_click:Signal = new Signal(PopupStashEventParams);
      
      public function RaidPromoSideBarRewardView(param1:BillingPopupValueObject)
      {
         _clip = new BillingPromoButtonClip();
         super();
         AssetStorage.rsx.asset_bundle.initGuiClip(_clip,"raid_promo_billing_item");
         _clip.setData(param1);
         _clip.signal_click.add(handler_click);
      }
      
      public function dispose() : void
      {
         signal_click.clear();
         _clip.signal_click.clear();
         graphics.removeFromParent(true);
      }
      
      public function get stashEventParams() : PopupStashEventParams
      {
         return _stashEventParams;
      }
      
      public function get graphics() : DisplayObject
      {
         return _clip.graphics;
      }
      
      public function get popupOffset() : Number
      {
         return 60;
      }
      
      public function get popupGap() : Number
      {
         return 0;
      }
      
      public function get popupSide() : PopupSideBarSide
      {
         return PopupSideBarSide.left;
      }
      
      public function initialize(param1:PopupStashEventParams) : void
      {
         this._stashEventParams = param1;
      }
      
      private function handler_click(param1:BillingPopupValueObject) : void
      {
         signal_click.dispatch(_stashEventParams);
      }
   }
}
