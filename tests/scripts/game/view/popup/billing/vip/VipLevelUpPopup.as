package game.view.popup.billing.vip
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.vip.VipLevelUpPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class VipLevelUpPopup extends ClipBasedPopup
   {
       
      
      private var mediator:VipLevelUpPopupMediator;
      
      public function VipLevelUpPopup(param1:VipLevelUpPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "vip_level_up";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:VipLevelUpPopupClip = AssetStorage.rsx.popup_theme.create(VipLevelUpPopupClip,"popup_vip_level_up");
         addChild(_loc1_.graphics);
         _loc1_.button_close.signal_click.add(mediator.close);
         _loc1_.button_close.label = Translate.translate("UI_POPUP_VIP_LEVEL_OK");
         _loc1_.tf_header.text = Translate.translate("UI_POPUP_VIP_LEVEL_HEADER");
         _loc1_.vip_level.setVip(mediator.vipLevel);
         _loc1_.benefit_list.list.dataProvider = mediator.benefitDataProvider;
      }
   }
}
