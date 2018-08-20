package game.view.specialoffer.paymentrepeat
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeatWithTimer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SpecialOfferPaymentRepeatOnBillingViewWithTimer extends GuiClipNestedContainer
   {
       
      
      private var data:PlayerSpecialOfferPaymentRepeatWithTimer;
      
      public var tf_title:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var tf_days:ClipLabel;
      
      public var layout_sale_label:ClipLayout;
      
      public var tf_sale_value:ClipLabel;
      
      public function SpecialOfferPaymentRepeatOnBillingViewWithTimer(param1:PlayerSpecialOfferPaymentRepeatWithTimer)
      {
         tf_days = new ClipLabel();
         layout_sale_label = ClipLayout.horizontalMiddleCentered(0,tf_days);
         super();
         this.data = param1;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1.asset,handler_assetLoaded);
         _container.touchable = false;
         param1.signal_updated.add(handler_updateProgress);
         param1.signal_removed.add(handler_removed);
      }
      
      public function dispose() : void
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
         if(data)
         {
            data.signal_updated.remove(handler_updateProgress);
            data.signal_removed.remove(handler_removed);
            data = null;
         }
      }
      
      public function setData(param1:PlayerSpecialOfferPaymentRepeatWithTimer) : void
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
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         if(data.doubleBillingMode)
         {
            param1.initGuiClip(this,data.assetClipOnBillingDouble);
         }
         else
         {
            param1.initGuiClip(this,data.assetClipOnBilling);
         }
         if(tf_title)
         {
            tf_title.text = data.title;
         }
         if(tf_sale_value)
         {
            tf_sale_value.text = data.saleValueString;
         }
         handler_updateProgress();
      }
      
      private function handler_updateProgress() : void
      {
         var _loc1_:Boolean = data.someDaysLeft;
         if(tf_days)
         {
            tf_days.visible = _loc1_;
            if(_loc1_)
            {
               if(data.doubleBillingMode)
               {
                  tf_days.text = data.billingDoubleText + " " + data.timerString;
               }
               else
               {
                  tf_days.text = data.timerString;
               }
            }
         }
         if(tf_timer)
         {
            tf_timer.visible = !_loc1_;
            if(!_loc1_)
            {
               if(data.doubleBillingMode)
               {
                  tf_timer.text = data.billingDoubleText + " " + data.timerString;
               }
               else
               {
                  tf_timer.text = data.timerString;
               }
            }
         }
      }
      
      private function handler_removed() : void
      {
         dispose();
      }
   }
}
