package game.view.popup.social
{
   import com.progrestar.common.lang.Translate;
   import engine.context.GameContext;
   import engine.core.assets.file.ImageFile;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.social.CommunityPromoPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class CommunityPromoPopup extends ClipBasedPopup
   {
       
      
      private var clip:CommunityPromoPopupClip;
      
      public function CommunityPromoPopup(param1:CommunityPromoPopupMediator)
      {
         super(param1);
         stashParams.windowName = "CommunityPromoPopup";
      }
      
      private function get mediator() : CommunityPromoPopupMediator
      {
         return _popupMediator as CommunityPromoPopupMediator;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(CommunityPromoPopupClip,"community_promo_popup");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.tf_0.text = Translate.translate("UI_COMMUNITY_PROMO_POPUP_TF_0");
         clip.tf_1.text = Translate.translate("UI_COMMUNITY_PROMO_POPUP_TF_1");
         clip.tf_3.text = Translate.translate("UI_COMMUNITY_PROMO_POPUP_TF_3");
         clip.tf_2.text = Translate.translate("UI_COMMUNITY_PROMO_POPUP_TF_2");
         clip.button_go.label = Translate.translate("UI_COMMUNITY_PROMO_POPUP_BUTTON");
         clip.button_go.signal_click.add(mediator.action_go);
         clip.button_close.signal_click.add(close);
         clip.image_hero.graphics.visible = false;
         var _loc1_:ImageFile = GameContext.instance.assetIndex.getAssetFile("SocialPromo_srcx2.jpg") as ImageFile;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc1_,handler_assetLoaded);
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         if(!mediator)
         {
            return;
         }
         clip.image_hero.graphics.visible = true;
         clip.image_hero.image.texture = param1.texture;
      }
   }
}
