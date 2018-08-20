package game.view.gui.tutorial.reward
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
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
   import game.view.popup.common.IModalPopup;
   
   public class TutorialRewardExtendedPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IModalPopup
   {
       
      
      private var reward:Vector.<TutorialRewardExtendedPopupValueObject>;
      
      private var clip:TutorialRewardExtendedPopupClip;
      
      private var q:PlayerQuestEntry;
      
      private var title:String;
      
      private var label:String;
      
      private var buttonLabel:String;
      
      public function TutorialRewardExtendedPopup(param1:Vector.<TutorialRewardExtendedPopupValueObject>, param2:String = null, param3:String = null, param4:String = null)
      {
         super(null);
         stashParams.windowName = "tutorial_reward";
         this.reward = param1;
         if(param2 == null)
         {
            param2 = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
         }
         if(param3 == null)
         {
            param3 = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         }
         if(param4 == null)
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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TutorialRewardExtendedPopupClip,"dialog_tutorial_reward_extended");
         addChild(clip.graphics);
         if(label && label.length > 0)
         {
            clip.layout.addChild(clip.tf_label_reward.graphics);
            (clip.layout.layout as VerticalLayout).paddingTop = 5;
         }
         else
         {
            (clip.layout.layout as VerticalLayout).paddingTop = 15;
         }
         clip.layout.height = NaN;
         var _loc3_:int = reward.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = new TutorialRewardExtendedPopupRendererClip();
            clip.reward_item.create(_loc1_);
            _loc1_.setData(reward[_loc2_]);
            clip.layout.addChild(_loc1_.graphics);
            _loc2_++;
         }
         clip.layout.addChild(clip.button_ok.graphics);
         clip.layout.invalidate();
         clip.layout.validate();
         clip.bg.graphics.height = clip.layout.y + clip.layout.height + 20;
         clip.tf_header.text = title;
         clip.tf_label_reward.text = label;
         clip.button_ok.initialize(buttonLabel,close);
      }
   }
}
