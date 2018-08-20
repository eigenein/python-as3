package game.view.popup.dailybonus
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.view.popup.PopupBase;
   
   public class DailyBonusRewardPopup extends PopupBase
   {
       
      
      private var vo:DailyBonusValueObject;
      
      private var actualReward:RewardData;
      
      public function DailyBonusRewardPopup(param1:DailyBonusValueObject, param2:RewardData)
      {
         super();
         stashParams.windowName = "reward_retention_reward";
         this.actualReward = param2;
         this.vo = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:DailyBonusRewardPopupClip = AssetStorage.rsx.popup_theme.create_popup_daily_bonus_reward();
         addChild(_loc1_.graphics);
         _loc1_.button_farm.signal_click.add(close);
         _loc1_.tf_caption.text = Translate.translate("UI_POPUP_DAILY_BONUS_REWARD");
         _loc1_.tf_item_name.text = vo.rewardItem.name;
         _loc1_.inventory_item.graphics.touchable = false;
         _loc1_.inventory_item.data = actualReward.outputDisplay[0];
         _loc1_.button_farm.label = Translate.translate("UI_DIALOG_DAILY_BONUS_REWARD_FARM");
         if(vo.availableDouble)
         {
            _loc1_.t_vip_info.text = Translate.translateArgs("UI_DIALOG_DAILY_BONUS_REWARD_VIP",vo.vipLevelDouble);
         }
         else if(vo.vipLevelDouble > 0)
         {
            _loc1_.t_vip_info.text = Translate.translateArgs("UI_DIALOG_DAILY_BONUS_REWARD_VIP_FARMED",vo.vipLevelDouble);
         }
         else
         {
            _loc1_.layout_vip_notice.visible = false;
         }
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
