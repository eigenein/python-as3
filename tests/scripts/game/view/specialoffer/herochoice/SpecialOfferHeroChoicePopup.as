package game.view.specialoffer.herochoice
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.billing.bundle.BundlePopupRewardClip;
   import starling.filters.ColorMatrixFilter;
   
   public class SpecialOfferHeroChoicePopup extends ClipBasedPopup
   {
       
      
      private var stickerAsset:RsxGuiAsset;
      
      private var mediator:SpecialOfferHeroChoicePopupMediator;
      
      private var clip:SpecialOfferHeroChoicePopupClip;
      
      public function SpecialOfferHeroChoicePopup(param1:SpecialOfferHeroChoicePopupMediator)
      {
         stickerAsset = AssetStorage.rsx.getByName("offer_sticker_really_unique") as RsxGuiAsset;
         super(param1);
         this.mediator = param1;
         AssetStorage.instance.globalLoader.requestAsset(stickerAsset);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         mediator.timerString.unsubscribe(handler_timerString);
         mediator.selectedHero.unsubscribe(handler_selectedHero);
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
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SpecialOfferHeroChoicePopupClip,"dialog_specialOffer_heroChoice");
         addChild(clip.graphics);
         clip.tf_header.text = mediator.title;
         clip.tf_label_desc.text = mediator.description;
         clip.tf_label_hero.text = Translate.translate("UI_SPECIALOFFER_HEROCHOICE_LABEL_HERO");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_old_price.text = mediator.oldPrice;
         clip.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         clip.button_close.signal_click.add(mediator.close);
         clip.button_buy.initialize(mediator.costString,mediator.action_buy);
         clip.button_select.initialize(Translate.translate("UI_SPECIALOFFER_HEROCHOICE_SELECT"),mediator.action_select);
         clip.tf_label_question_mark.text = "?";
         clip.tf_label_hero_fragments.text = Translate.translateArgs("UI_SPECIALOFFER_HEROCHOICE_LABEL_HERO_FRAGMENTS",mediator.heroFramgentsCount);
         var _loc5_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         clip.layout_hero_rays.container.addChild(_loc5_.graphics);
         var _loc1_:Vector.<InventoryItem> = mediator.reward;
         var _loc3_:int = clip.reward_item.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = clip.reward_item[_loc6_];
            if(_loc1_.length > _loc6_)
            {
               _loc2_.setData(_loc1_[_loc6_]);
            }
            _loc6_++;
         }
         var _loc4_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"bundle_bg_purple");
         clip.marker_bg.container.addChild(_loc4_.graphics);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(stickerAsset,handler_stickerAsset);
         centerPopupBy(clip.dialog_frame.graphics);
         height = height - 30;
         mediator.timerString.onValue(handler_timerString);
         mediator.selectedHero.onValue(handler_selectedHero);
      }
      
      private function handler_stickerAsset(param1:RsxGuiAsset) : void
      {
         var _loc2_:SpecialOfferHeroChoiceStickerClip = param1.create(SpecialOfferHeroChoiceStickerClip,"specialoffer_really_unique_offer");
         _loc2_.tf_header.text = Translate.translate("UI_SPECIALOFFER_ATTENTION");
         _loc2_.tf_text.text = Translate.translate("UI_SPECIALOFFER_REALLY_UNIQUE_OFFER");
         clip.layout_special_offer.addChild(_loc2_.graphics);
      }
      
      private function handler_timerString(param1:String) : void
      {
         clip.tf_timer.text = param1;
      }
      
      private function handler_selectedHero(param1:UnitDescription) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = param1 != null;
         if(_loc2_)
         {
            clip.hero_preview.hero.loadHero(param1);
            clip.icon_hero.setData(new InventoryFragmentItem(param1,mediator.heroFramgentsCount));
            if(clip.hero_preview.filter)
            {
               clip.hero_preview.filter.dispose();
               clip.hero_preview.filter = null;
            }
            var _loc4_:* = 0.8;
            clip.hero_preview.scaleY = _loc4_;
            clip.hero_preview.scaleX = _loc4_;
         }
         else
         {
            clip.hero_preview.hero.loadHero(mediator.defaultUnknownHero);
            if(!clip.hero_preview.filter)
            {
               _loc3_ = new ColorMatrixFilter();
               _loc3_.tint(0,0.94);
               clip.hero_preview.filter = _loc3_;
            }
            _loc4_ = 0.7;
            clip.hero_preview.scaleY = _loc4_;
            clip.hero_preview.scaleX = _loc4_;
         }
         clip.hero_preview.hero.isPlaying = _loc2_;
         clip.tf_label_question_mark.visible = !_loc2_;
         clip.tf_label_hero_fragments.visible = !_loc2_;
         clip.icon_hero.graphics.visible = _loc2_;
         clip.button_buy.isEnabled = _loc2_;
         clip.button_buy.graphics.alpha = !!_loc2_?1:0.5;
      }
   }
}
