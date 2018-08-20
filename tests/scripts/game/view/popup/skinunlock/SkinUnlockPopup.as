package game.view.popup.skinunlock
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.skinunlock.SkinUnlockPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   import starling.display.Image;
   
   public class SkinUnlockPopup extends ClipBasedPopup
   {
       
      
      private var mediator:SkinUnlockPopupMediator;
      
      private var clip:SkinUnlockPopupClip;
      
      private var heroPreview:HeroPreview;
      
      public function SkinUnlockPopup(param1:SkinUnlockPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SkinUnlockPopupClip,"dialog_skin_unlock");
         addChild(clip.graphics);
         height = 520;
         clip.tf_header.text = mediator.billing.name;
         var _loc2_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"bundle_bg");
         clip.marker_bg.container.addChild(_loc2_.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_unlock_1.text = Translate.translateArgs("UI_DIALOG_SKIN_UNLOCK_DESC_1",mediator.upgradeCost.outputDisplayFirst.amount);
         clip.tf_unlock_2.text = Translate.translateArgs("UI_DIALOG_SKIN_UNLOCK_DESC_2",mediator.billingRewardVIPPointsItem.amount + " " + "^{sprite:" + "gold_vip_small}^");
         var _loc7_:* = Translate.translate("UI_DIALOG_SKIN_UNLOCK_SKIN");
         clip.tf_skin_2.text = _loc7_;
         clip.tf_skin_1.text = _loc7_;
         _loc7_ = mediator.hero.name + " - " + Translate.translate(mediator.skin.localeKey);
         clip.tf_skin_name_2.text = _loc7_;
         clip.tf_skin_name_1.text = _loc7_;
         clip.btn_unclock_1.cost = mediator.upgradeCost.outputDisplayFirst;
         clip.btn_unclock_1.signal_click.add(mediator.action_skinUpgrade);
         clip.btn_unclock_2.label = mediator.billing.costString;
         clip.btn_unclock_2.signal_click.add(mediator.action_billing_buy);
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_old_price.text = mediator.oldPrice;
         var _loc5_:Image = new Image(mediator.icon);
         _loc5_.width = 72;
         _loc5_.height = 72;
         clip.skin_image_1.container.addChild(_loc5_);
         var _loc6_:Image = new Image(mediator.icon);
         _loc6_.width = 72;
         _loc6_.height = 72;
         clip.skin_image_2.container.addChild(_loc6_);
         var _loc4_:InventoryItem = mediator.billingRewardCoinItem;
         clip.reward_item_coin.setData(_loc4_);
         clip.reward_item_coin.item_counter.container.visible = false;
         clip.tf_reward_coin.text = _loc4_.name;
         clip.tf_reward_coin_amount.text = _loc4_.amount.toString();
         clip.stat_tf.text = mediator.getSkinDescriptionByLevel(mediator.level);
         var _loc1_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"skin_background");
         clip.skin_bg.container.addChild(_loc1_.container);
         var _loc3_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         _loc7_ = 1.3;
         _loc3_.graphics.scaleY = _loc7_;
         _loc3_.graphics.scaleX = _loc7_;
         clip.hero_position_rays.container.addChild(_loc3_.graphics);
         heroPreview = new HeroPreview();
         _loc7_ = 1.35;
         heroPreview.graphics.scaleY = _loc7_;
         heroPreview.graphics.scaleX = _loc7_;
         clip.hero_position_after.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         heroPreview.loadHero(mediator.hero.hero,mediator.skin.id);
      }
   }
}
