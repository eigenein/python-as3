package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.core.assets.file.ImageFile;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.HeroSpecialOfferPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import starling.display.Sprite;
   
   public class HeroSpecialOfferPopup extends ClipBasedPopup
   {
       
      
      private var mediator:HeroSpecialOfferPopupMediator;
      
      private var clip:Bundle4PopupClip;
      
      public function HeroSpecialOfferPopup(param1:HeroSpecialOfferPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = param1.stashWindowName;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
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
         mediator.signal_updateTimeLeft.remove(handler_updateTimer);
      }
      
      override protected function initialize() : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         _loc7_ = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(Bundle4PopupClip,"dialog_bundle_specialoffer");
         addChild(clip.graphics);
         var _loc6_:int = mediator.discountValue;
         if(_loc6_)
         {
            clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",_loc6_);
         }
         else
         {
            clip.tf_discount.text = "";
         }
         clip.tf_header.text = mediator.title;
         clip.tf_label_desc.text = mediator.description;
         clip.timer.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_label_skills.text = Translate.translate("UI_POPUP_BUNDLE_4_SKILL");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.button_to_store.signal_click.add(mediator.action_button);
         clip.image_hero.graphics.visible = false;
         var _loc3_:ImageFile = GameContext.instance.assetIndex.getAssetFile(mediator.hero.epicArtAsset) as ImageFile;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,handler_assetLoaded);
         var _loc5_:String = mediator.oldPrice;
         if(_loc5_)
         {
            clip.tf_old_price.text = mediator.oldPrice;
         }
         else
         {
            var _loc8_:Boolean = false;
            clip.tf_old_price.visible = _loc8_;
            clip.old_price_cross.graphics.visible = _loc8_;
         }
         clip.button_to_store.label = mediator.buttonLabel;
         _loc4_ = clip.reward_item.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc2_ = clip.reward_item[_loc7_];
            _loc2_.setData(mediator.reward[_loc7_]);
            _loc7_++;
         }
         _loc4_ = clip.skill_item.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc1_ = clip.skill_item[_loc7_];
            _loc1_.setData(mediator.skills[_loc7_]);
            _loc7_++;
         }
         mediator.signal_updateTimeLeft.add(handler_updateTimer);
         handler_updateTimer();
      }
      
      protected function handler_updateTimer() : void
      {
         if(!clip)
         {
            return;
         }
         if(mediator.isOver)
         {
            clip.timer.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER_IS_OVER");
            clip.timer.tf_timer.text = "";
         }
         else
         {
            clip.timer.tf_timer.text = mediator.timeLeftString;
         }
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
