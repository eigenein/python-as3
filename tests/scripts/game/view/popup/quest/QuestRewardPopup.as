package game.view.popup.quest
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   
   public class QuestRewardPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var reward:Vector.<InventoryItem>;
      
      private var clip:QuestRewardPopupClip;
      
      private var q:PlayerQuestEntry;
      
      public function QuestRewardPopup(param1:Vector.<InventoryItem>, param2:PlayerQuestEntry)
      {
         super(null);
         this.q = param2;
         stashParams.windowName = "quest_completed";
         this.reward = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.REWARD_QUEST;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_ok);
         return _loc2_;
      }
      
      override public function close() : void
      {
         Stash.click("get_reward:" + q.desc.id,stashParams);
         Tutorial.events.triggerEvent_rewardDialogClosed();
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         clip.setReward(reward);
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
