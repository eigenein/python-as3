package game.view.popup.fightresult.pve
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.component.StarValueObject;
   import game.mediator.gui.popup.mission.MissionRewardPopupMediator;
   import game.view.gui.components.RewardList;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.PopupBase;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import starling.events.Event;
   
   public class MissionRewardPopup extends PopupBase implements ITutorialNodePresenter, ITutorialActionProvider
   {
       
      
      private var mediator:MissionRewardPopupMediator;
      
      private var clip:MissionRewardDialogClip;
      
      public function MissionRewardPopup(param1:MissionRewardPopupMediator)
      {
         super();
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.REWARD_MISSION;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         _loc2_.addButton(TutorialNavigator.HOME_SCREEN,clip.townButton);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _initialize();
      }
      
      override protected function refreshBackgroundSkin() : void
      {
         super.refreshBackgroundSkin();
      }
      
      private function _initialize() : void
      {
         var _loc4_:int = 0;
         clip = AssetStorage.rsx.popup_theme.create_dialog_victory();
         addChild(clip.graphics);
         width = int(clip.bounds_layout_container.graphics.width);
         height = int(clip.bounds_layout_container.graphics.height);
         clip.tf_reward_empty.text = Translate.translate("UI_POPUP_MULTI_REWARD_EMPTY");
         clip.tf_reward_label.text = Translate.translate("UI_DIALOG_MISSION_VICTORY_REWARDS");
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_MISSION_VICTORY");
         clip.label_level.text = Translate.translate("UI_DIALOG_MISSION_REWARD_TEAM_LVL");
         clip.label_exp.text = Translate.translate("UI_DIALOG_MISSION_REWARD_TEAM_XP");
         clip.label_level_number.text = mediator.teamLevel.toString();
         clip.label_exp_number.text = "+" + mediator.teamXp.toString();
         clip.label_gold_number.text = mediator.gold.toString();
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_MISSION_REWARD_STATS");
         clip.townButton.label = Translate.translate("UI_DIALOG_MISSION_REWARD_FINISH_TOWN_BUTTON");
         clip.okButton.label = Translate.translate("UI_DIALOG_MISSION_REWARD_FINISH_BUTTON");
         clip.campaignButton.label = Translate.translate("UI_DIALOG_MISSION_REWARD_FINISH_CAMPAIGN_BUTTON");
         clip.okButton.signal_click.add(mediator.close);
         clip.townButton.signal_click.add(mediator.action_navigateTown);
         clip.campaignButton.signal_click.add(mediator.action_navigateCampaign);
         clip.okButton.graphics.visible = !mediator.mainTutorialCompleted;
         clip.townButton.graphics.visible = mediator.mainTutorialCompleted;
         clip.campaignButton.graphics.visible = mediator.mainTutorialCompleted;
         var _loc6_:RewardPopupHeroList = new RewardPopupHeroList(MissionRewardPopupHeroExpListItemRenderer);
         _loc6_.addEventListener("rendererAdd",handler_addedRenderer);
         _loc6_.addEventListener("rendererRemove",handler_removedRenderer);
         _loc6_.width = clip.hero_list_layout_container.container.width;
         _loc6_.height = clip.hero_list_layout_container.container.height;
         clip.hero_list_layout_container.container.addChild(_loc6_);
         _loc6_.dataProvider = new ListCollection(mediator.heroExpReward);
         var _loc3_:RewardList = new RewardList();
         var _loc5_:LayoutGroup = clip.item_list_layout_container.container as LayoutGroup;
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         _loc5_.layout = _loc1_;
         clip.item_list_layout_container.container.addChild(_loc3_);
         _loc3_.dataProvider = new ListCollection(mediator.itemRewardList);
         clip.tf_reward_empty.visible = mediator.itemRewardList.length == 0;
         clip.button_stats_inst0.signal_click.add(handler_showStats);
         var _loc2_:int = 3;
         _loc4_ = 1;
         while(_loc4_ <= 3)
         {
            (clip["star_animation_" + _loc4_] as GuiAnimation).graphics.visible = false;
            (clip["star_animation_" + _loc4_] as GuiAnimation).stop();
            _loc4_++;
         }
         clip.button_stats_inst0.graphics.visible = !Tutorial.flags.hideBattleButtons;
         mediator.signal_starAnimation.add(handler_animateStar);
         mediator.action_animateStars();
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_statsButton() : void
      {
      }
      
      private function handler_showStats() : void
      {
         PopUpManager.addPopUp(new BattleStatisticsPopup(mediator.missionResult.attackerTeamStats,mediator.missionResult.defenderTeamStats));
      }
      
      private function handler_addedRenderer(param1:Event, param2:MissionRewardPopupHeroExpListItemRenderer) : void
      {
         param2.signal_levelUp.add(handler_heroLevelUp);
      }
      
      private function handler_removedRenderer(param1:Event, param2:MissionRewardPopupHeroExpListItemRenderer) : void
      {
         param2.signal_levelUp.remove(handler_heroLevelUp);
      }
      
      private function handler_animateStar(param1:StarValueObject) : void
      {
         var _loc2_:GuiAnimation = clip["star_animation_" + param1.star] as GuiAnimation;
         if(_loc2_)
         {
            _loc2_.graphics.visible = true;
            _loc2_.playOnce();
         }
      }
      
      private function handler_heroLevelUp(param1:MissionRewardPopupHeroExpListItemRenderer) : void
      {
         FloatingTextContainer.showInDisplayObjectCenter(param1,0,20,Translate.translate("UI_COMMON_HERO_LEVEL_UP"),mediator);
      }
   }
}
