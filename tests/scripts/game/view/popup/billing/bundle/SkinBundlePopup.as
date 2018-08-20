package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.GenericSkinBundlePopupMediator;
   import game.view.gui.components.HeroPreview;
   
   public class SkinBundlePopup extends BundlePopupBase
   {
       
      
      private var clip:SkinBundlePopupClip;
      
      private var heroPreview:HeroPreview;
      
      public function SkinBundlePopup(param1:GenericSkinBundlePopupMediator)
      {
         super(param1);
      }
      
      protected function get mediator() : GenericSkinBundlePopupMediator
      {
         return __mediator as GenericSkinBundlePopupMediator;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(SkinBundlePopupClip,mediator.assetClipName);
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
         var _loc2_:int = clip.reward_item.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = clip.reward_item[_loc4_];
            _loc1_.setData(mediator.reward[_loc4_]);
            _loc4_++;
         }
         heroPreview = new HeroPreview();
         var _loc5_:* = 1.35;
         heroPreview.graphics.scaleY = _loc5_;
         heroPreview.graphics.scaleX = _loc5_;
         clip.hero_position.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         var _loc3_:String = "";
         if(mediator.hero.id == 25)
         {
            _loc3_ = "AMPLIFIED_";
         }
         heroPreview.loadHero(mediator.hero,mediator.skinId,_loc3_);
         clip.tf_label_stat_bonus.text = mediator.statBonus;
         initTimer(clip.timer);
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
      }
   }
}
