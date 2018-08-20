package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.file.ImageFile;
   import engine.core.clipgui.GuiAnimation;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.BundlePopupMediator;
   import game.mediator.gui.popup.billing.bundle.GenericHeroBundlePopupMediator;
   import game.view.gui.components.HeroPreview;
   import starling.display.Sprite;
   
   public class Bundle4Popup extends BundlePopupBase
   {
       
      
      private var clip:Bundle4PopupClip;
      
      private var heroPreview:HeroPreview;
      
      public function Bundle4Popup(param1:BundlePopupMediator)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         super.dispose();
         if(clip)
         {
            _loc3_ = clip.reward_item.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = clip.reward_item[_loc4_];
               _loc2_.dispose();
               _loc4_++;
            }
            _loc3_ = clip.skill_item.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_ = clip.skill_item[_loc4_];
               _loc1_.dispose();
               _loc4_++;
            }
            clip = null;
         }
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         if(heroPreview)
         {
            heroPreview.dispose();
         }
      }
      
      protected function get mediator() : GenericHeroBundlePopupMediator
      {
         return __mediator as GenericHeroBundlePopupMediator;
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc5_ = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(Bundle4PopupClip,"dialog_bundle_4");
         addChild(clip.graphics);
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_header.text = mediator.bundleTitle;
         clip.tf_label_desc.text = mediator.bundleDescription;
         clip.tf_label_skills.text = Translate.translate("UI_POPUP_BUNDLE_4_SKILL");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.button_to_store.signal_click.add(mediator.action_buy);
         heroPreview = new HeroPreview();
         var _loc6_:* = 1.35;
         heroPreview.graphics.scaleY = _loc6_;
         heroPreview.graphics.scaleX = _loc6_;
         clip.hero_position.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         heroPreview.loadHero(mediator.hero);
         var _loc4_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         _loc6_ = 1.3;
         _loc4_.graphics.scaleY = _loc6_;
         _loc4_.graphics.scaleX = _loc6_;
         clip.hero_position_rays.container.addChild(_loc4_.graphics);
         clip.tf_old_price.text = mediator.oldPrice;
         clip.button_to_store.label = mediator.billing.costString;
         _loc3_ = clip.reward_item.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = clip.reward_item[_loc5_];
            _loc2_.setData(mediator.reward[_loc5_]);
            _loc5_++;
         }
         _loc3_ = clip.skill_item.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc1_ = clip.skill_item[_loc5_];
            _loc1_.setData(mediator.skills[_loc5_]);
            _loc5_++;
         }
         initTimer(clip.timer);
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(clip)
         {
            clip.image_hero.graphics.visible = true;
            clip.image_hero.image.texture = param1.texture;
            _loc2_ = new Sprite();
            clip.container.addChild(_loc2_);
            _loc2_.x = clip.image_container.graphics.x;
            _loc2_.y = clip.image_container.graphics.y;
            _loc3_ = clip.image_container.graphics.getBounds(clip.image_container.graphics);
            clip.image_hero.graphics.x = 0;
            clip.image_hero.graphics.y = 0;
            if(clip.image_hero.graphics.parent == clip.container)
            {
               clip.container.swapChildren(_loc2_,clip.image_hero.graphics);
            }
            else if(clip.image_hero.graphics.parent == clip.container)
            {
               clip.container.swapChildren(_loc2_,clip.image_hero.graphics.parent);
            }
            _loc2_.addChild(clip.image_hero.graphics);
            _loc2_.clipRect = _loc3_;
         }
      }
   }
}
