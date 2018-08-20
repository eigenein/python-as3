package game.mechanics.titan_arena.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.model.PlayerTitanArenaDailyNotFarmedRewardData;
   import game.stat.Stash;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.quest.QuestRewardPopupClip;
   
   public class TitanArenaRewardFarmPopup extends ClipBasedPopup
   {
       
      
      private var reward:PlayerTitanArenaDailyNotFarmedRewardData;
      
      private var clip:QuestRewardPopupClip;
      
      public function TitanArenaRewardFarmPopup(param1:PlayerTitanArenaDailyNotFarmedRewardData)
      {
         super(null);
         stashParams.windowName = "titan_arena_points_reward_farm";
         this.reward = param1;
      }
      
      override public function close() : void
      {
         Stash.click("get_titan_arena_points_reward",stashParams);
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_FARM_TITLE",reward.points);
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         clip.setReward(reward.reward.outputDisplay);
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
