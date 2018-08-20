package game.view.popup.ny.reward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.quest.QuestRewardPopupClip;
   
   public class NYRewardPopup extends ClipBasedPopup
   {
       
      
      private var header:String;
      
      private var reward:Vector.<InventoryItem>;
      
      private var clip:QuestRewardPopupClip;
      
      public function NYRewardPopup(param1:String, param2:Vector.<InventoryItem>)
      {
         super(null);
         this.reward = param2;
         this.header = param1;
         stashParams.windowName = "ny_gift_send_reward";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = header;
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_SEND_NY_GIFT_REWARD_DESC");
         clip.button_ok.label = Translate.translate("UI_DIALOG_SEND_NY_GIFT_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         clip.setReward(reward);
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
