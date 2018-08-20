package game.view.popup.skincoinsdailyreward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.quest.QuestRewardPopupClip;
   
   public class SkinCoinsDailyRewardPopup extends ClipBasedPopup
   {
       
      
      private var reward:Vector.<InventoryItem>;
      
      private var clip:QuestRewardPopupClip;
      
      public function SkinCoinsDailyRewardPopup(param1:Vector.<InventoryItem>)
      {
         super(null);
         stashParams.windowName = "skin_coins_reward";
         this.reward = param1;
      }
      
      override public function close() : void
      {
         Stash.click("get_skin_coins_reward",stashParams);
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_DIALOG_DAILY_BONUS_TITLE");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_MERGE_COIN_SKIN");
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         clip.setReward(reward);
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
