package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.BirthDayGraphicsAsset;
   import game.mediator.gui.popup.billing.bundle.Bundle2PopupMediator;
   
   public class Bundle2Popup extends BundlePopupBase
   {
       
      
      private var clip:Bundle2PopupClip;
      
      public function Bundle2Popup(param1:Bundle2PopupMediator)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         super.dispose();
         if(clip)
         {
            _loc2_ = clip.reward_item.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = clip.reward_item[_loc3_];
               _loc1_.dispose();
               _loc3_++;
            }
         }
      }
      
      protected function get mediator() : Bundle2PopupMediator
      {
         return __mediator as Bundle2PopupMediator;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = mediator.guiClipAsset.create(Bundle2PopupClip,mediator.clipName);
         addChild(clip.graphics);
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_header.text = mediator.bundleTitle;
         clip.tf_label_desc.text = mediator.bundleDescription;
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.button_to_store.signal_click.add(mediator.action_buy);
         clip.tf_old_price.text = mediator.oldPrice;
         clip.button_to_store.label = mediator.billing.costString;
         var _loc3_:int = clip.reward_item.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = clip.reward_item[_loc4_];
            if(mediator.reward.length > _loc4_)
            {
               _loc1_.setData(mediator.reward[_loc4_]);
            }
            _loc4_++;
         }
         initTimer(clip.timer);
         var _loc2_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"vendor_girl");
         clip.marker_girl.container.addChild(_loc2_.graphics);
         if(mediator.dialogType == "bundle2_purple")
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.birth_day_graphics,handler_assetLoaded);
         }
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
      }
      
      private function handler_assetLoaded(param1:BirthDayGraphicsAsset) : void
      {
         var _loc2_:GuiAnimation = AssetStorage.rsx.birth_day_graphics.create(GuiAnimation,"fx_all_action");
         _loc2_.graphics.x = 356;
         _loc2_.graphics.y = 35;
         _loc2_.graphics.touchable = false;
         if(clip && clip.container)
         {
            clip.container.addChild(_loc2_.graphics);
         }
      }
   }
}
