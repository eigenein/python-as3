package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.timer.GameTimer;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.mechanics.titan_arena.mediator.TitanArenaPopupMediator;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.common.PopupTitle;
   
   public class TitanArenaPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter
   {
      
      public static var ASSET_IDENT:String = "dialog_titan_arena";
       
      
      private var mediator:TitanArenaPopupMediator;
      
      private var clip:TitanArenaPopupClip;
      
      public function TitanArenaPopup(param1:TitanArenaPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName(ASSET_IDENT));
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.signal_pointsUpdate.remove(handler_pointsUpdate);
         mediator.property_canRaid.unsubscribe(handler_canRaid);
         GameTimer.instance.oneSecTimer.remove(handler_timer);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_ARENA;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         if(clip.peace_time.graphics.visible)
         {
            _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_ARENA_RULES,clip.peace_time.button_rules);
         }
         else
         {
            _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_ARENA_RULES,clip.enemy_select_ui.button_rules);
         }
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         if(!mediator.property_serverDataReady.value)
         {
            mediator.property_serverDataReady.signal_update.add(handler_serverDataReady);
            return;
         }
         _initialize();
      }
      
      protected function _initialize() : void
      {
         var _loc3_:int = 0;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         width = 1000;
         height = 640;
         clip = asset.create(TitanArenaPopupClip,"dialog_titan_arena");
         addChild(clip.graphics);
         var _loc4_:PopupTitle = PopupTitle.create(Translate.translate("UI_TITAN_ARENA_ENEMY_HEADER"),clip.header_layout_container);
         clip.peace_time.button_shop.initialize(Translate.translate("UI_DIALOG_ARENA_SHOP"),mediator.action_shop);
         clip.peace_time.button_rules.initialize(Translate.translate("UI_DIALOG_ARENA_RULES"),mediator.action_rules);
         clip.enemy_select_ui.button_shop.initialize(Translate.translate("UI_DIALOG_ARENA_SHOP"),mediator.action_shop);
         clip.enemy_select_ui.button_rules.initialize(Translate.translate("UI_DIALOG_ARENA_RULES"),mediator.action_rules);
         clip.enemy_select_ui.button_rating.initialize(Translate.translate("UI_DIALOG_GRAND_RATING"),mediator.action_rating);
         clip.enemy_select_ui.button_raid.initialize(Translate.translate("UI_DIALOG_MISSION_RAID"),mediator.action_raid);
         clip.enemy_select_ui.tf_raid.text = Translate.translate("UI_TITAN_ARENA_ENEMY_SELECT_UI_TF_RAID");
         clip.enemy_select_ui.tf_select_enemy.text = Translate.translate("UI_TITAN_ARENA_ENEMY_SELECT_UI_TF_HEADER");
         clip.enemy_select_ui.tf_label_points.text = Translate.translate("UI_DIALOG_RATING_TYPE_TITAN_ARENA");
         clip.defense_ui.tf_label_gather_defense.text = Translate.translate("UI_TITAN_ARENA_DEFENSE_UI_TF_LABEL_GATHER_DEFENSE");
         clip.defense_ui.button_defense.initialize(Translate.translate("UI_DIALOG_ARENA_MY_TEAM_SETUP"),mediator.action_defense);
         clip.defense_ui.button_set_defense.initialize(Translate.translate("UI_TITAN_ARENA_WARNING_LABEL_ASSEMBLE"),mediator.action_defense);
         clip.button_close.signal_click.add(mediator.close);
         clip.chest_button.signal_click.add(mediator.action_chest);
         clip.defense_ui.tf_label_defenders.text = Translate.translate("UI_TITAN_ARENA_DEFENSE_UI_TF_LABEL_DEFENDERS");
         var _loc2_:int = clip.enemy_select_ui.enemy_list.enemy.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.enemy_select_ui.enemy_list.enemy[_loc3_].signal_click.add(mediator.action_select);
            _loc3_++;
         }
         mediator.signal_updateRivals.add(handler_enemiesUpdate);
         onEnemiesUpdate();
         var _loc1_:TooltipVO = new TooltipVO(TooltipTextView,Translate.translate("UI_TITAN_ARENA_LOCK_TOOLTIP"));
         TooltipHelper.addTooltip(clip.defense_ui.lock_icon.graphics,_loc1_);
         mediator.signal_updateDefenseTeam.add(handler_updateDefenseTeam);
         mediator.property_canRaid.onValue(handler_canRaid);
         mediator.status_canUpdateDefense.signal_update.add(handler_canUpdateDefenseTeam);
         updateDefenseUI();
         GameTimer.instance.oneSecTimer.add(handler_timer);
         updateStatus();
         mediator.signal_pointsUpdate.add(handler_pointsUpdate);
         updatePoints();
         mediator.action_checkForNextRound();
         mediator.property_stage.signal_update.add(handler_stage_update);
         updateStage();
         mediator.signal_farmReward.add(handler_farmReward);
         updatePointsProgressBar();
         updateChestMarker();
         mediator.status_peace.signal_update.add(handler_peaceStateUpdate);
         updatePeaceState();
         Tutorial.updateActionsFrom(this);
      }
      
      private function updateChestMarker() : void
      {
         clip.chest_marker.graphics.visible = mediator.firstNotFarmedReward != null;
      }
      
      private function updatePointsProgressBar() : void
      {
         var _loc2_:* = 0;
         var _loc1_:Vector.<TitanArenaReward> = mediator.dailyRewardList;
         if(mediator.firstNotFarmedReward)
         {
            clip.points_progressbar.value = mediator.dailyScore;
            clip.points_progressbar.maxValue = mediator.firstNotFarmedReward.points;
         }
         else
         {
            _loc2_ = uint(0);
            while(_loc2_ < _loc1_.length)
            {
               if(mediator.dailyScore < _loc1_[_loc2_].tournamentPoints || _loc2_ == _loc1_.length - 1)
               {
                  if(_loc2_ > 0)
                  {
                     clip.points_progressbar.minValue = _loc1_[_loc2_ - 1].tournamentPoints;
                  }
                  else
                  {
                     clip.points_progressbar.minValue = 0;
                  }
                  clip.points_progressbar.maxValue = _loc1_[_loc2_].tournamentPoints;
                  clip.points_progressbar.value = mediator.dailyScore;
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      private function updateStage() : void
      {
         clip.enemy_select_ui.tf_stage.text = Translate.translateArgs("UI_TITAN_ARENA_ENEMY_SELECT_UI_TF_STAGE",mediator.property_stage.value);
         var _loc1_:Boolean = mediator.isFinalStage;
         clip.enemy_select_ui.bg_stage.graphics.visible = !_loc1_;
         clip.enemy_select_ui.bg_final_stage.graphics.visible = _loc1_;
         if(_loc1_)
         {
            clip.enemy_select_ui.tf_stage_desc.text = Translate.translate("UI_TITAN_ARENA_ENEMY_SELECT_UI_TF_STAGE_DESC_LAST");
         }
         else
         {
            clip.enemy_select_ui.tf_stage_desc.text = Translate.translate("UI_TITAN_ARENA_ENEMY_SELECT_UI_TF_STAGE_DESC");
         }
      }
      
      private function updatePoints() : void
      {
         clip.enemy_select_ui.tf_points.text = String(mediator.points);
         clip.enemy_select_ui.tf_label_position.text = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_TF_LABEL_POSITION",mediator.string_place);
      }
      
      private function updateDefenseUI() : void
      {
         var _loc1_:Boolean = false;
         if(!mediator.status_peace.value)
         {
            _loc1_ = mediator.playerTeam.length;
            if(_loc1_)
            {
               clip.defense_ui.team_container_layout.visible = true;
               clip.defense_ui.tf_label_defenders.graphics.visible = true;
               clip.defense_ui.team.setUnitTeam(mediator.playerTeam);
               clip.defense_ui.button_set_defense.graphics.visible = false;
               clip.defense_ui.tf_label_gather_defense.visible = false;
               clip.defense_ui.button_defense.graphics.visible = mediator.status_canUpdateDefense.value;
               clip.defense_ui.lock_icon.graphics.visible = !mediator.status_canUpdateDefense.value;
               clip.defense_ui.tf_label_status.visible = true;
            }
            else
            {
               clip.defense_ui.team_container_layout.visible = false;
               clip.defense_ui.tf_label_defenders.graphics.visible = false;
               clip.defense_ui.tf_label_gather_defense.visible = true;
               clip.defense_ui.tf_label_status.visible = false;
            }
            handler_canRaid(mediator.property_canRaid.value);
         }
      }
      
      private function updateStatus() : void
      {
         if(mediator.status_peace.value)
         {
            clip.peace_time.tf_label_status.text = mediator.string_status;
         }
         else
         {
            clip.defense_ui.tf_label_status.text = mediator.string_status;
         }
      }
      
      private function updatePeaceState() : void
      {
         var _loc1_:Boolean = mediator.status_peace.value;
         clip.defense_ui.graphics.visible = !_loc1_;
         clip.enemy_select_ui.graphics.visible = !_loc1_;
         clip.chest_button.graphics.visible = !_loc1_;
         clip.points_progressbar.graphics.visible = !_loc1_;
         clip.peace_time.graphics.visible = _loc1_;
      }
      
      protected function onEnemiesUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _loc1_ = 0;
         _loc3_ = 0;
         var _loc2_:Vector.<TitanArenaEnemyClip> = clip.enemy_select_ui.enemy_list.enemy;
         var _loc4_:Vector.<PlayerTitanArenaEnemy> = mediator.enemies;
         if(_loc4_)
         {
            if(_loc4_.length == 5)
            {
               clip.enemy_select_ui.enemy_list.playback.gotoAndStop(0);
            }
            else if(_loc4_.length == 7)
            {
               clip.enemy_select_ui.enemy_list.playback.gotoAndStop(1);
            }
            else
            {
               clip.enemy_select_ui.enemy_list.playback.gotoAndStop(2);
            }
            _loc1_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(_loc4_.length > _loc3_)
               {
                  _loc5_ = _loc4_[_loc3_];
                  _loc2_[_loc3_].data = mediator.enemies[_loc3_];
                  _loc6_ = new TooltipVO(TooltipTitanArenaEnemyTeamView,_loc4_[_loc3_],"TooltipVO.HINT_BEHAVIOR_MOVING");
                  TooltipHelper.removeTooltip(_loc2_[_loc3_].graphics);
                  TooltipHelper.addTooltip(_loc2_[_loc3_].graphics,_loc6_);
               }
               else
               {
                  _loc2_[_loc3_].data = null;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc1_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_[_loc3_].data = null;
               _loc3_++;
            }
            clip.enemy_select_ui.graphics.visible = false;
         }
      }
      
      private function handler_serverDataReady(param1:Boolean) : void
      {
         _initialize();
      }
      
      private function handler_canUpdateDefenseTeam(param1:Boolean) : void
      {
         updateDefenseUI();
      }
      
      private function handler_updateDefenseTeam() : void
      {
         updateDefenseUI();
      }
      
      private function handler_timer() : void
      {
         updateStatus();
      }
      
      private function handler_pointsUpdate() : void
      {
         updatePoints();
         updatePointsProgressBar();
         updateChestMarker();
      }
      
      private function handler_enemiesUpdate() : void
      {
         onEnemiesUpdate();
      }
      
      private function handler_stage_update(param1:int) : void
      {
         updateStage();
      }
      
      private function handler_farmReward() : void
      {
         updatePointsProgressBar();
         updateChestMarker();
      }
      
      private function handler_canRaid(param1:Boolean) : void
      {
         if(param1 && (mediator.playerTeam == null || mediator.playerTeam.length == 0))
         {
            param1 = false;
         }
         clip.enemy_select_ui.button_raid.graphics.visible = param1;
         clip.enemy_select_ui.tf_raid.visible = param1;
         clip.enemy_select_ui.tf_select_enemy.visible = !param1;
      }
      
      private function handler_peaceStateUpdate(param1:Boolean) : void
      {
         updatePeaceState();
      }
   }
}
