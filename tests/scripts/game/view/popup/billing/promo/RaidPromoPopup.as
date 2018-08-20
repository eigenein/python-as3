package game.view.popup.billing.promo
{
   import com.progrestar.common.lang.LocaleEnum;
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.core.assets.file.ImageFile;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class RaidPromoPopup extends ClipBasedPopup
   {
       
      
      private var clip:RaidPromoPopupClip;
      
      private var mediator:RaidPromoPopupMediator;
      
      public function RaidPromoPopup(param1:RaidPromoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "raid_promo_popup";
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(RaidPromoPopupClip,"vip_promo_bundle_popup");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.tf_0.text = Translate.translate("UI_VIP_PROMO_BUNDLE_POPUP_TF_0");
         clip.tf_1.text = replaceSprite(Translate.translate("UI_VIP_PROMO_BUNDLE_POPUP_TF_1"),"%VIP%","gold_vip");
         clip.tf_2.text = Translate.translate("UI_VIP_PROMO_BUNDLE_POPUP_TF_2");
         clip.tf_reward_0.text = replaceSprite(Translate.translate("UI_VIP_PROMO_BUNDLE_POPUP_TF_REWARD_0"),"%v%","iconvsmall");
         clip.tf_reward_1.text = replaceSprite(Translate.translateArgs("UI_VIP_PROMO_BUNDLE_POPUP_TF_REWARD_1",mediator.reward_potion_amount),"%v%","iconvsmall");
         clip.tf_reward_2.text = replaceSprite(Translate.translateArgs("UI_VIP_PROMO_BUNDLE_POPUP_TF_REWARD_3",mediator.reward_skillPoints),"%v%","iconvsmall");
         if(GameContext.instance.localeID == LocaleEnum.RUSSIAN.id)
         {
            _loc1_ = "superBundleArt_Rus.jpg";
         }
         else
         {
            _loc1_ = "superBundleArt_Eng.jpg";
         }
         var _loc2_:ImageFile = GameContext.instance.assetIndex.getAssetFile(_loc1_) as ImageFile;
         if(_loc2_)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc2_,handler_assetLoaded);
         }
         clip.button_close.signal_click.add(close);
         clip.button_go.label = mediator.costString;
         clip.button_go.signal_click.add(mediator.action_buy);
      }
      
      private function replaceSprite(param1:String, param2:String, param3:String) : String
      {
         param1 = param1.replace(param2,"^{sprite:" + param3 + "}^");
         return param1;
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         if(!mediator)
         {
            return;
         }
         clip.image.graphics.visible = true;
         clip.image.image.image.texture = param1.texture;
      }
   }
}
