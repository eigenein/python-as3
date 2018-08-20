package game.view.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.vip.VipBenefitPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class VipBenefitPopup extends ClipBasedPopup
   {
       
      
      private var clip:VipBenefitPopupClip;
      
      private var mediator:VipBenefitPopupMediator;
      
      public function VipBenefitPopup(param1:VipBenefitPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "bank_vip";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_vip_benefit();
         addChild(clip.graphics);
         mediator.signal_updateVip.add(updateVipProgress);
         mediator.signal_updateSelectedVip.add(updateSelectedVip);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_to_store.initialize(Translate.translate("UI_DIALOG_VIP_TO_STORE"),mediator.action_toStore);
         clip.button_right.signal_click.add(mediator.action_next);
         clip.button_left.signal_click.add(mediator.action_prev);
         clip.benefit_list.list.dataProvider = mediator.benefitDataProvider;
         clip.tf_benefits.text = Translate.translate("UI_DIALOG_VIP_BENEFITS");
         updateSelectedVip();
      }
      
      private function updateSelectedVip() : void
      {
         var _loc1_:int = mediator.selectedVipLevel;
         clip.selected_vip_level.setVip(_loc1_);
         clip.layout_vip_selected.invalidate();
         if(mediator.hasNextVipLevel)
         {
            clip.right_vip_level.setVip(_loc1_ + 1);
            var _loc2_:Boolean = true;
            clip.button_right.graphics.visible = _loc2_;
            clip.right_vip_level.graphics.visible = _loc2_;
         }
         else
         {
            _loc2_ = false;
            clip.button_right.graphics.visible = _loc2_;
            clip.right_vip_level.graphics.visible = _loc2_;
         }
         if(mediator.hasPrevVipLevel)
         {
            clip.left_vip_level.setVip(_loc1_ - 1);
            _loc2_ = true;
            clip.button_left.graphics.visible = _loc2_;
            clip.left_vip_level.graphics.visible = _loc2_;
         }
         else
         {
            _loc2_ = false;
            clip.button_left.graphics.visible = _loc2_;
            clip.left_vip_level.graphics.visible = _loc2_;
         }
         updateVipProgress();
      }
      
      private function updateVipProgress() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = NaN;
         var _loc3_:int = 0;
         _loc3_ = 24;
         var _loc1_:int = mediator.playerVipPoints;
         clip.header_vip_level.setVip(mediator.playerVipLevel);
         if(mediator.playerHasNextVipLevel)
         {
            _loc5_ = mediator.targetLevel;
            _loc4_ = mediator.targetLevelVipPoints;
            clip.block_points_needed.showGemIcon = _loc5_ == 1;
            clip.block_points_needed.setProgress(_loc4_ - _loc1_,_loc5_);
            clip.tf_progress_value.text = _loc1_ + "/" + _loc4_;
            _loc2_ = Number(_loc1_ / _loc4_);
         }
         else
         {
            clip.tf_progress_value.text = String(_loc1_);
            clip.block_points_needed.setMax();
            _loc2_ = 1;
         }
         clip.progress_bar.image.width = int(24 + (clip.progress_bg.image.width - 24) * _loc2_);
      }
   }
}
