package game.view.popup.billing.promo
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   import starling.filters.ColorMatrixFilter;
   
   public class BillingPromoButtonClip extends DataClipButton
   {
       
      
      private var data:BillingPopupValueObject;
      
      public var tf_raid:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_price:ClipLabel;
      
      public var dark_plate:ClipSprite;
      
      public var price_back:GuiClipScale3Image;
      
      public var layout_price:ClipLayout;
      
      public var animation:GuiAnimation;
      
      public var layout_clip_bounds:ClipLayout;
      
      public var layout_label:ClipLayout;
      
      public var gems_anim:GuiAnimation;
      
      public function BillingPromoButtonClip()
      {
         tf_raid = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_price = new ClipLabel(true);
         dark_plate = new ClipSprite();
         price_back = new GuiClipScale3Image(12,1);
         layout_price = ClipLayout.horizontalCentered(0,tf_price);
         animation = new GuiAnimation();
         layout_clip_bounds = ClipLayout.none(animation);
         layout_label = ClipLayout.verticalMiddleCenter(0,tf_desc);
         gems_anim = new GuiAnimation();
         super(BillingPopupValueObject);
      }
      
      private function layoutPrice(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 10;
         tf_price.width = param1;
         layout_price.validate();
         price_back.image.x = tf_price.x - 10;
         price_back.image.width = tf_price.width + 10 * 2;
      }
      
      public function setData(param1:BillingPopupValueObject) : void
      {
         var _loc2_:BillingPopupValueObject = param1 as BillingPopupValueObject;
         if(!_loc2_)
         {
            graphics.visible = false;
            return;
         }
         graphics.visible = true;
         this.data = _loc2_;
         tf_price.width = NaN;
         tf_price.text = _loc2_.costString;
         tf_price.validate();
         layoutPrice(tf_price.width);
         gems_anim.graphics.touchable = false;
         gems_anim.graphics.visible = param1.reward.starmoney > 0;
         tf_desc.text = Translate.translate("BILLING_RAID_PROMO_NAME_1");
         tf_raid.text = Translate.translate("UI_DIALOG_MISSION_RAID");
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            price_back.graphics.filter = _loc3_;
         }
         else if(price_back.graphics.filter)
         {
            price_back.graphics.filter.dispose();
            price_back.graphics.filter = null;
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      override protected function getClickData() : *
      {
         return data;
      }
   }
}
