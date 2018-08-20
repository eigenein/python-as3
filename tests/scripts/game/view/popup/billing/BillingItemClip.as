package game.view.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.refillable.ClipLabelCrossed;
   import game.view.popup.reward.GuiElementExternalStyle;
   import idv.cjcat.signals.Signal;
   import starling.display.Image;
   
   public class BillingItemClip extends DataClipButton
   {
       
      
      public var layout_image:GuiClipLayoutContainer;
      
      public var tf_price:ClipLabel;
      
      public var price_back:GuiClipScale3Image;
      
      public var layout_price:ClipLayout;
      
      public var tf_gem_value:ClipLabel;
      
      public var tf_gem_base_value:ClipLabelCrossed;
      
      public var tf_per_day:ClipLabel;
      
      public var gem_icon:ClipSprite;
      
      public var layout_valuables:ClipLayout;
      
      public var dark_plate:ClipSprite;
      
      public var dark_plate_duration:ClipSprite;
      
      public var tf_duration:ClipLabel;
      
      public var tf_sale_value:ClipLabel;
      
      public var tf_sale_label:ClipLabel;
      
      public var layout_sale_label:ClipLayout;
      
      public var sale_ribbon:ClipSprite;
      
      public var sale_sticker:ClipSprite;
      
      public var frame:GuiClipScale3Image;
      
      public var frame_gold:GuiClipScale3Image;
      
      public var overlay_buy_button:BillingItemBuyButtonOverlayClip;
      
      private var data:BillingPopupValueObject;
      
      private var externalStyle:GuiElementExternalStyle;
      
      private var showBuyButtonOverlay:Boolean;
      
      public const signal_hover:Signal = new Signal(BillingPopupValueObject);
      
      public const signal_out:Signal = new Signal(BillingPopupValueObject);
      
      public function BillingItemClip()
      {
         tf_price = new ClipLabel(true);
         layout_price = ClipLayout.horizontalCentered(0,tf_price);
         tf_gem_value = new ClipLabel(true);
         tf_gem_base_value = new ClipLabelCrossed(2);
         tf_per_day = new ClipLabel(true);
         gem_icon = new ClipSprite();
         layout_valuables = ClipLayout.horizontalMiddleCentered(2,tf_gem_base_value,gem_icon,tf_gem_value,tf_per_day);
         tf_sale_label = new ClipLabel();
         layout_sale_label = ClipLayout.horizontalMiddleCentered(0,tf_sale_label);
         showBuyButtonOverlay = DataStorage.rule.showBillingBuyButtonOverlay;
         super(BillingPopupValueObject);
      }
      
      public function dispose() : void
      {
         if(externalStyle)
         {
            externalStyle.dispose();
            externalStyle = null;
         }
         _container.dispose();
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         if(overlay_buy_button && showBuyButtonOverlay)
         {
            if(param2 && param1 == "down")
            {
               playClickSound();
            }
            _loc3_ = param1 == "hover" || param1 == "down";
            overlay_buy_button.graphics.visible = _loc3_;
         }
         else
         {
            super.setupState(param1,param2);
         }
         if(data)
         {
            if(param1 == "hover")
            {
               signal_hover.dispatch(data);
            }
            else if(param1 == "up")
            {
               signal_out.dispatch(data);
            }
         }
      }
      
      public function layoutPrice(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 10;
         tf_price.width = param1;
         layout_price.validate();
         price_back.image.x = tf_price.x - 10;
         price_back.image.width = tf_price.width + 10 * 2;
      }
      
      public function setData(param1:*) : void
      {
         var _loc3_:BillingPopupValueObject = param1 as BillingPopupValueObject;
         if(!_loc3_)
         {
            var _loc7_:Boolean = false;
            graphics.touchable = _loc7_;
            graphics.visible = _loc7_;
            return;
         }
         _loc7_ = true;
         graphics.touchable = _loc7_;
         graphics.visible = _loc7_;
         this.data = _loc3_;
         tf_price.width = NaN;
         tf_price.text = _loc3_.costString;
         var _loc5_:Boolean = _loc3_.useGoldFrame;
         frame.graphics.visible = !_loc5_;
         frame_gold.graphics.visible = _loc5_;
         dark_plate.graphics.alpha = !!_loc5_?0.6:1;
         layout_image.container.removeChildren();
         if(_loc3_.hasBackground)
         {
            layout_image.container.addChild(new Image(_loc3_.background));
         }
         layout_image.container.addChild(new Image(_loc3_.icon));
         tf_gem_value.text = String(int(_loc3_.mainStarmoneyReward));
         if(tf_gem_base_value != null)
         {
            if(_loc3_.hasBonuses)
            {
               tf_gem_base_value.text = String(_loc3_.rewardWithoutBonuses);
               tf_gem_base_value.graphics.visible = true;
            }
            else
            {
               tf_gem_base_value.graphics.visible = false;
            }
         }
         var _loc6_:String = _loc3_.rewardComment;
         if(_loc6_)
         {
            tf_per_day.text = _loc6_;
            tf_per_day.visible = true;
         }
         else
         {
            tf_per_day.visible = false;
         }
         var _loc2_:String = _loc3_.orderDuration;
         if(_loc2_)
         {
            tf_duration.text = _loc2_;
            _loc7_ = true;
            dark_plate_duration.graphics.visible = _loc7_;
            tf_duration.visible = _loc7_;
         }
         else
         {
            _loc7_ = false;
            dark_plate_duration.graphics.visible = _loc7_;
            tf_duration.visible = _loc7_;
         }
         var _loc4_:String = _loc3_.saleStickerText;
         if(_loc4_ && _loc4_.length > 0)
         {
            tf_sale_value.text = _loc4_;
            tf_sale_label.text = _loc3_.saleStickerDescription;
            setSaleElementsVisibility(true);
         }
         else
         {
            setSaleElementsVisibility(false);
         }
         if(overlay_buy_button)
         {
            overlay_buy_button.button_buy.initialize(Translate.translate("UI_DIALOG_BILLING_BUY"),dispatchClickSignal);
            overlay_buy_button.graphics.visible = false;
            frame.image.touchable = false;
            frame_gold.image.touchable = false;
         }
         if(externalStyle)
         {
            externalStyle.dispose();
            externalStyle = null;
         }
         externalStyle = _loc3_.createExternalStyle();
         if(externalStyle)
         {
            externalStyle.apply(layout_image.graphics,_container.parent,_container.parent);
         }
      }
      
      override protected function getClickData() : *
      {
         return data;
      }
      
      private function setSaleElementsVisibility(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         tf_sale_label.visible = _loc2_;
         _loc2_ = _loc2_;
         tf_sale_value.visible = _loc2_;
         _loc2_ = _loc2_;
         sale_sticker.graphics.visible = _loc2_;
         sale_ribbon.graphics.visible = _loc2_;
      }
   }
}
