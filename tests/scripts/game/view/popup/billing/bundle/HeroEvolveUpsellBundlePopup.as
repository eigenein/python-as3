package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.HeroEvolveUpsellBundlePopupMediator;
   import game.view.gui.components.HeroPreview;
   import starling.filters.ColorMatrixFilter;
   
   public class HeroEvolveUpsellBundlePopup extends BundlePopupBase
   {
       
      
      private var mediator:HeroEvolveUpsellBundlePopupMediator;
      
      private var clip:HeroEvolveUpsellBundlePopupClip;
      
      public function HeroEvolveUpsellBundlePopup(param1:HeroEvolveUpsellBundlePopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(HeroEvolveUpsellBundlePopupClip,"dialog_bundle_hero_upsell");
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
         initTimer(clip.timer);
         var _loc4_:HeroPreview = new HeroPreview();
         clip.hero_position_before.container.addChild(_loc4_.graphics);
         _loc4_.graphics.touchable = false;
         _loc4_.loadHero(mediator.hero);
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc3_.adjustSaturation(-0.5);
         _loc4_.graphics.filter = _loc3_;
         _loc4_.isPlaying = false;
         var _loc2_:HeroPreview = new HeroPreview();
         clip.hero_position_after.container.addChild(_loc2_.graphics);
         _loc2_.graphics.touchable = false;
         _loc2_.loadHero(mediator.hero);
         clip.tf_label_gold_desc.text = Translate.translate("UI_DIALOG_BUNDLE_HERO_UPSELL_TF_LABEL_GOLD_DESC");
         clip.gold_reward.data = mediator.goldReward;
         var _loc1_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         var _loc5_:* = 1.3;
         _loc1_.graphics.scaleY = _loc5_;
         _loc1_.graphics.scaleX = _loc5_;
         clip.hero_position_rays.container.addChild(_loc1_.graphics);
         clip.star_counter_before.setStarCount(mediator.starCount_before);
         clip.star_counter_after.setStarCount(mediator.starCount_after);
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
      }
   }
}
