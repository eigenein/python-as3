package game.view.specialoffer.paymentrepeat
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeat;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialOfferPaymentRepeatOnBillingViewNoTimer extends GuiClipNestedContainer
   {
      
      private static const CLIP:String = "special_offer_paymentx2_on_billing_notimer";
       
      
      private var data:PlayerSpecialOfferPaymentRepeat;
      
      public var tf_sale_value:ClipLabel;
      
      public function SpecialOfferPaymentRepeatOnBillingViewNoTimer(param1:PlayerSpecialOfferPaymentRepeat)
      {
         super();
         AssetStorage.rsx.asset_bundle.initGuiClip(this,"special_offer_paymentx2_on_billing_notimer");
         _container.touchable = false;
         setData(param1);
      }
      
      public function dispose() : void
      {
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
      }
      
      public function setData(param1:PlayerSpecialOfferPaymentRepeat) : void
      {
         if(this.data)
         {
            this.data.signal_updated.remove(handler_updateProgress);
            this.data.signal_removed.remove(handler_removed);
         }
         this.data = param1;
         if(param1)
         {
            param1.signal_updated.add(handler_updateProgress);
            param1.signal_removed.add(handler_removed);
            handler_updateProgress();
            tf_sale_value.text = param1.saleValueString;
         }
      }
      
      private function handler_updateProgress() : void
      {
      }
      
      private function handler_removed() : void
      {
         dispose();
      }
   }
}
