package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.billing.bundle.Bundle3PopupMediator;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.GameModel;
   import game.view.gui.components.HeroPortrait;
   import game.view.popup.PromptPopup;
   
   public class Bundle3Popup extends BundlePopupBase
   {
       
      
      private var mediator:Bundle3PopupMediator;
      
      private var clip:Bundle3PopupClip;
      
      private var portrait:HeroPortrait;
      
      public function Bundle3Popup(param1:Bundle3PopupMediator)
      {
         portrait = new HeroPortrait();
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
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
         }
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         _loc5_ = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(Bundle3PopupClip,"dialog_bundle_3");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.graphics.visible = !mediator.isMissionLocked;
         clip.button_drop.graphics.visible = mediator.isMissionLocked;
         clip.button_close.signal_click.add(close);
         clip.button_drop.signal_click.add(handler_closePrompt);
         clip.button_drop.label = Translate.translate("BUNDLE_3_CLOSE_LABEL");
         clip.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",mediator.discountValue);
         clip.tf_header.text = mediator.bundleTitle;
         clip.tf_label_desc.text = mediator.bundleDescription;
         clip.tf_label_skills.text = Translate.translate("BUNDLE_3_SKILLS_LABEL");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_BUNDLE_REWARD");
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_to_store.signal_click.add(mediator.action_buy);
         var _loc3_:RsxGuiAsset = AssetStorage.rsx.getByName("bundle_3") as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,handler_assetLoaded);
         clip.tf_old_price.text = mediator.oldPrice;
         clip.button_to_store.label = Translate.translate("UI_POPUP_BUNDLE_3_BUTTON");
         clip.tf_new_price.text = mediator.billing.costString;
         _loc4_ = clip.reward_item.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = clip.reward_item[_loc5_];
            _loc2_.setData(mediator.reward[_loc5_]);
            _loc5_++;
         }
         _loc4_ = clip.skill_item.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_ = clip.skill_item[_loc5_];
            _loc1_.setData(mediator.skills[_loc5_]);
            _loc5_++;
         }
         initTimer(clip.timer,mediator.isMissionLocked);
         clip.tf_hero_name.text = mediator.hero.name;
         clip.tf_hero_desc.text = Translate.translateArgs("UI_POPUP_BUNDLE_3_HERO_DESC",mediator.heroEntry.level.level);
         clip.vip_level.setVip(mediator.vipLevel.level);
         clip.tf_vip_desc.text = Translate.translate("LIB_VIP_BENEFIT_MISSIONRAIDAVAILABLE");
         portrait.data = new HeroEntryValueObject(mediator.hero,mediator.heroEntry);
         clip.hero_portrait.container.addChild(portrait);
         mediator.registerSpecialOfferSpot(clip.layout_special_offer);
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:GuiAnimation = param1.create(GuiAnimation,"Hom");
         clip.marker_animaton.container.addChild(_loc2_.graphics);
      }
      
      private function handler_closePrompt() : void
      {
         var _loc1_:PromptPopup = PopupList.instance.prompt(Translate.translate("BUNDLE_3_PROMPT_MESSAGE"),Translate.translate("BUNDLE_3_PROMPT_TITLE"),Translate.translate("BUNDLE_3_PROMPT_YES"),Translate.translate("BUNDLE_3_PROMPT_NO"));
         _loc1_.signal_cancel.add(handler_closeConfirmed);
      }
      
      private function handler_closeConfirmed(param1:PromptPopup) : void
      {
         GameModel.instance.actionManager.billingBundleDrop();
         close();
      }
   }
}
