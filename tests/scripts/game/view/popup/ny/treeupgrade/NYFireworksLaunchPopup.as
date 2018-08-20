package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class NYFireworksLaunchPopup extends ClipBasedPopup
   {
       
      
      private var mediator:NYFireworksLaunchPopupMediator;
      
      private var clip:NYFireworksLaunchPopupClip;
      
      public function NYFireworksLaunchPopup(param1:NYFireworksLaunchPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.ny_gifts.create(NYFireworksLaunchPopupClip,"fireworks_launch_popup");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         width = clip.popup_bg.graphics.width;
         height = clip.popup_bg.graphics.height;
         clip.tf_header.text = Translate.translate("UI_FIREWORKS_LAUNCH_POPUP_TF_HEADER");
         clip.check_1.label.text = Translate.translate("UI_FIREWORKS_LAUNCH_POPUP_TF_HIDE_CLANNAME");
         clip.check_2.label.text = Translate.translate("UI_FIREWORKS_LAUNCH_POPUP_TF_HIDE_NICKNAME");
         clip.tf_desc_2.text = Translate.translateArgs("UI_FIREWORKS_LAUNCH_POPUP_TF_DESC_2",DataStorage.rule.ny2018TreeRule.fireworks.randomPlayerGiftAmount);
         clip.tf_desc_1.text = Translate.translateArgs("UI_FIREWORKS_LAUNCH_POPUP_TF_DESC_1",mediator.decorateActionRewardItem.amount);
         clip.price.data = mediator.price;
         clip.item1.setData(mediator.decorateActionRewardItem);
         clip.item2.setData(mediator.randomPlayerGiftRewardItem);
         clip.btn_send.label = Translate.translate("UI_FIREWORKS_LAUNCH_POPUP_TF_LAUNCH");
         clip.btn_send.signal_click.add(mediator.action_launch);
         clip.check_1.isSelected = false;
         clip.check_2.isSelected = false;
         clip.check_1.signal_click.add(handler_selectBox1);
         clip.check_2.signal_click.add(handler_selectBox2);
      }
      
      private function handler_selectBox1() : void
      {
         mediator.property_hideClanName.value = clip.check_1.isSelected;
      }
      
      private function handler_selectBox2() : void
      {
         mediator.property_hideNickname.value = clip.check_2.isSelected;
      }
   }
}
