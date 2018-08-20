package game.view.gui.tutorial.reward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
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
   import game.view.popup.quest.QuestRewardPopupClip;
   
   public class TutorialRewardPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var reward:Vector.<InventoryItem>;
      
      private var clip:QuestRewardPopupClip;
      
      private var q:PlayerQuestEntry;
      
      private var title:String;
      
      private var label:String;
      
      private var buttonLabel:String;
      
      public function TutorialRewardPopup(param1:RewardData, param2:String = null, param3:String = null, param4:String = null)
      {
         super(null);
         stashParams.windowName = "tutorial_reward";
         this.reward = param1.outputDisplay;
         if(!param2)
         {
            param2 = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
         }
         if(!param3)
         {
            param3 = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         }
         if(!param4)
         {
            param4 = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         }
         this.title = param2;
         this.label = param3;
         this.buttonLabel = param4;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_ok);
         return _loc2_;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.REWARD_TUTORIAL;
      }
      
      override public function close() : void
      {
         Stash.click("get_tutorial_reward",stashParams);
         Tutorial.events.triggerEvent_rewardDialogClosed();
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = title;
         clip.tf_label_reward.text = label;
         clip.button_ok.label = buttonLabel;
         clip.button_ok.signal_click.add(close);
         clip.setReward(reward);
         AssetStorage.sound.dailyBonus.play();
      }
   }
}
