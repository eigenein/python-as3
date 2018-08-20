package game.view.specialoffer.paymentrepeat
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeatWithTimer;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferViewSlotEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   
   public class SpecialOfferPaymentRepeatResourcePanelView extends GuiClipNestedContainer implements ISpecialOfferViewSlotObject
   {
       
      
      private var data:PlayerSpecialOfferPaymentRepeatWithTimer;
      
      private var entry:SpecialOfferViewSlotEntry;
      
      private var bgPanelRightPartWidth:int;
      
      public var tf_timer:ClipLabel;
      
      public var tf_days:ClipLabel;
      
      public var layout_sale_label:ClipLayout;
      
      public var tf_sale_value:ClipLabel;
      
      public var bg_panel:GuiClipScale3Image;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      public function SpecialOfferPaymentRepeatResourcePanelView(param1:PlayerSpecialOfferWithTimer, param2:SpecialOfferViewSlotEntry)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         tf_timer = new ClipLabel();
         tf_days = new ClipLabel(true);
         layout_sale_label = ClipLayout.horizontalMiddleCentered(0,tf_days);
         tf_sale_value = new ClipLabel();
         super();
         this.data = param1 as PlayerSpecialOfferPaymentRepeatWithTimer;
         this.entry = param2;
         if(param2)
         {
            _loc3_ = AssetStorage.rsx.getByName(param2.assetIdent) as RsxGuiAsset;
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,handler_assetLoaded);
         }
         else
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(this.data.asset,handler_assetLoaded);
            param1.signal_removed.add(handler_removed);
         }
         param1.signal_updated.add(handler_updateProgress);
         if(param2)
         {
            displayStyle.setOverlay(graphics,param2.createAlignment());
            displayStyle.signal_dispose.add(dispose);
         }
         else
         {
            _loc4_ = new RelativeAlignment("center","bottom",false);
            _loc4_.paddingLeft = -17;
            _loc4_.paddingTop = -7;
            displayStyle.setOverlay(graphics,_loc4_);
            displayStyle.signal_dispose.add(dispose);
         }
      }
      
      public function dispose() : void
      {
         displayStyle.signal_dispose.remove(dispose);
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         data.signal_updated.remove(handler_updateProgress);
         data.signal_removed.remove(handler_removed);
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
      }
      
      public function get externalStyle() : GuiElementExternalStyle
      {
         return displayStyle;
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         if(entry)
         {
            param1.initGuiClip(this,entry.assetClip);
         }
         else
         {
            param1.initGuiClip(this,data.assetClipOnResourcePanel);
         }
         if(tf_sale_value)
         {
            tf_sale_value.text = data.saleValueString;
         }
         if(bg_panel && tf_timer)
         {
            bgPanelRightPartWidth = bg_panel.image.x + bg_panel.image.width - (tf_timer.x + tf_timer.width);
         }
         handler_updateProgress();
      }
      
      private function handler_updateProgress() : void
      {
         var _loc1_:Boolean = data.someDaysLeft;
         tf_days.visible = _loc1_;
         tf_timer.visible = !_loc1_;
         if(data.someDaysLeft)
         {
            tf_days.text = data.timerString;
            tf_days.validate();
            if(bg_panel)
            {
               bg_panel.image.width = int(tf_days.x + tf_days.width - bg_panel.image.x + bgPanelRightPartWidth);
            }
            graphics.dispatchEventWith("resize");
         }
         else
         {
            tf_timer.text = data.timerString;
            tf_timer.validate();
            if(bg_panel)
            {
               bg_panel.image.width = int(tf_timer.x + tf_timer.width - bg_panel.image.x + bgPanelRightPartWidth);
            }
            graphics.dispatchEventWith("resize");
         }
      }
      
      private function handler_removed() : void
      {
         displayStyle.dispose();
      }
   }
}
