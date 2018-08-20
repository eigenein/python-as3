package game.mechanics.clan_war.popup.start
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.ClanWarStartScreenMediator;
   import game.mechanics.clan_war.popup.plan.ClanWarDefenderTeamClip;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarStartScreen extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ClanWarStartScreenMediator;
      
      private var clip:ClanWarStartScreenClip;
      
      private var _points_them:IntProperty;
      
      private var _points_us:IntProperty;
      
      public function ClanWarStartScreen(param1:ClanWarStartScreenMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         unsubscribePoints();
         super.dispose();
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
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         mediator.signal_updateDefenseTeams.add(handler_updateTeams);
         mediator.signal_updatePlayerSlotPosition.add(handler_updateTeamSlots);
         width = 1000;
         height = 640;
         clip = asset.create(ClanWarStartScreenClip,"clan_war_start_view");
         clip.tf_header.text = Translate.translate("UI_CLANMENU_WAR");
         clip.tf_label_defenders.text = Translate.translate("UI_DIALOG_ARENA_MY_TEAM");
         if(mediator.tries_me)
         {
            mediator.tries_me.signal_update.add(handler_updateTries);
         }
         handler_updateTries();
         mediator.signal_timer.add(handler_timer);
         handler_timer();
         clip.button_shop.label = Translate.translate("UI_DIALOG_ARENA_SHOP");
         clip.button_log.initialize(Translate.translate("UI_DIALOG_ARENA_LOGS"),mediator.action_navigateToLog);
         clip.button_leagues.label = Translate.translate("UI_CLAN_WAR_LEAGUES");
         clip.button_leagues.signal_click.add(mediator.action_navigateToLeagues);
         addChild(clip.graphics);
         clip.button_defense_plan.button_defense_plan.label = Translate.translate("UI_CLAN_WAR_VIEW_LABEL_PLAN");
         clip.button_defense_plan.button_defense_plan.signal_click.add(mediator.action_navigateToPlan);
         clip.button_close.signal_click.add(close);
         if(mediator.defenseLocked)
         {
            clip.tf_no_war_desc.text = Translate.translate("UI_CLAN_WAR_START_VIEW_TF_LOCK_TOOLTIP");
         }
         else
         {
            clip.tf_no_war_desc.text = Translate.translate("UI_CLAN_WAR_START_VIEW_TF_NO_WAR_DESC");
         }
         clip.attack_block.button_attack.label = Translate.translate("UI_CLAN_WAR_ATTACK_BLOCK_ATTACK");
         clip.attack_block.button_attack.signal_click.add(mediator.action_navigateToWar);
         clip.button_shop.signal_click.add(mediator.action_shop);
         setupTeamRenderer(clip.defender_team_titans,false);
         setupTeamRenderer(clip.defender_team_heroes,true);
         updateTeams();
         updateTeamSlots();
         updateState();
         mediator.signal_updateOccupiedSlotsCount.add(handler_updateOccupiedSlotsCount);
         mediator.signal_attackAvaliableForMeUpdate.add(handler_attackAvaliableForMeUpdate);
         mediator.signal_setDefenseAvaliableUpdate.add(handler_setDefenseAvaliableUpdate);
      }
      
      protected function setupTeamRenderer(param1:ClanWarDefenderTeamClip, param2:Boolean) : void
      {
         param1.tf_label_empty_team.text = Translate.translate("UI_DEFENDER_TEAM_VIEW_CLIP_TF_LABEL_EMPTY_TEAM");
         param1.team.reversed = true;
         var _loc4_:Function = !!param2?mediator.action_gatherHeroTeam:mediator.action_gatherTitanTeam;
         param1.button_edit.signal_click.add(_loc4_);
         param1.button_gather.signal_click.add(_loc4_);
         var _loc3_:String = !!param2?Translate.translate("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDERS_HEROES"):Translate.translate("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDERS_TITANS");
         param1.tf_label_defenders.text = _loc3_;
      }
      
      protected function setTeamRendererData(param1:ClanWarDefenderTeamClip, param2:Vector.<UnitEntryValueObject>, param3:Boolean, param4:Boolean) : void
      {
         param1.tf_label_empty_team.graphics.visible = param2.length == 0;
         param1.team.setUnitTeam(param2);
         param1.button_gather.graphics.visible = param2.length == 0;
         if(param1.button_gather.graphics.visible)
         {
            AssetStorage.rsx.popup_theme.setDisabledFilter(param1.button_gather.graphics,param4);
            param1.button_gather.isEnabled = !param4;
         }
         param1.button_edit.graphics.visible = !param4 && param2.length != 0;
      }
      
      protected function setTeamRendererPosition(param1:ClanWarDefenderTeamClip, param2:Boolean) : void
      {
         var _loc3_:String = !!param2?Translate.translateArgs("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDER_POSITION",mediator.playerHeroTeamPositionString):Translate.translateArgs("UI_CLAN_WAR_START_VIEW_TF_LABEL_DEFENDER_POSITION",mediator.playerTitanTeamPositionString);
         param1.tf_label_position.text = _loc3_;
      }
      
      protected function updateState() : void
      {
         if(mediator.participant_them)
         {
            clip.playback.gotoAndStop(0);
            setVisibility(true,mediator.occupiedSlotCount_enough);
            clip.attack_block.vs_header.attacker_info.setData(mediator.participant_them);
            clip.attack_block.vs_header.defender_info.setData(mediator.participant_us);
            clip.attack_block.vs_header.attacker_info.button_list.signal_click.add(mediator.action_openMemberList_enemy);
            clip.attack_block.vs_header.defender_info.button_list.signal_click.add(mediator.action_openMemberList_our);
            reSubscribePoints();
         }
         else
         {
            clip.playback.gotoAndStop(1);
            setVisibility(false,mediator.occupiedSlotCount_enough);
         }
         clip.tf_no_war_no_defenders.text = Translate.translateArgs("UI_CLAN_WAR_START_VIEW_TF_NO_WAR_NO_DEFENDERS_HEADER",mediator.occupiedSlotCount_min,mediator.occupiedSlotCount_current);
      }
      
      private function setVisibility(param1:Boolean, param2:Boolean) : void
      {
         clip.attack_block.graphics.visible = param1;
         clip.bg_attack.graphics.visible = param1;
         clip.tf_no_war_desc.graphics.visible = !param1 && param2;
         clip.tf_no_war_header.graphics.visible = !param1 && param2;
         clip.tf_no_war_no_defenders.graphics.visible = !param1 && !param2;
         updateAttackMarker();
      }
      
      private function updateTeams() : void
      {
         var _loc1_:Vector.<UnitEntryValueObject> = mediator.defenders_hero;
         setTeamRendererData(clip.defender_team_heroes,_loc1_,true,mediator.defenseLocked);
         var _loc3_:Vector.<UnitEntryValueObject> = mediator.defenders_titan;
         setTeamRendererData(clip.defender_team_titans,_loc3_,false,mediator.defenseLocked);
         var _loc2_:Boolean = _loc3_.length != 0 && _loc1_.length != 0;
         clip.button_defense_plan.setState_buttonEnabled(_loc2_);
         clip.button_defense_plan.setState_buttonVisible(!mediator.defenseLocked);
         updateDefeseMarker();
      }
      
      private function updateTeamSlots() : void
      {
         setTeamRendererPosition(clip.defender_team_titans,false);
         setTeamRendererPosition(clip.defender_team_heroes,true);
      }
      
      private function reSubscribePoints() : void
      {
         unsubscribePoints();
         _points_us = !!mediator.participant_us?mediator.participant_us.property_points:null;
         _points_them = !!mediator.participant_them?mediator.participant_them.property_points:null;
         if(_points_us)
         {
            _points_us.signal_update.add(handler_updatePoints);
         }
         if(_points_them)
         {
            _points_them.signal_update.add(handler_updatePoints);
         }
      }
      
      private function unsubscribePoints() : void
      {
         if(_points_us)
         {
            _points_us.signal_update.remove(handler_updatePoints);
         }
         if(_points_them)
         {
            _points_them.signal_update.remove(handler_updatePoints);
         }
      }
      
      private function updateAttackMarker() : void
      {
         clip.attack_block.red_dot.graphics.visible = mediator.redMarkerState_attackAvaliableForMe;
      }
      
      private function updateDefeseMarker() : void
      {
         clip.button_defense_plan.red_dot.graphics.visible = mediator.redMarkerState_setDefenseAvaliable;
      }
      
      private function handler_updateTeamSlots() : void
      {
         updateTeamSlots();
      }
      
      private function handler_updateTeams() : void
      {
         updateTeams();
      }
      
      private function handler_serverDataReady(param1:Boolean) : void
      {
         _initialize();
      }
      
      private function handler_timer() : void
      {
         clip.button_defense_plan.updateTimerText(mediator.timeLeft_defenseLock);
         clip.tf_no_war_header.text = Translate.translateArgs("UI_CLAN_WAR_START_VIEW_TF_NO_WAR_HEADER",mediator.timeLeft_warStart);
         clip.attack_block.tf_state.text = Translate.translateArgs("UI_CLAN_WAR_ATTACK_BLOCK_TF_STATE",mediator.timeLeft_warEnd);
      }
      
      private function handler_updateTries(param1:int = 0) : void
      {
         if(mediator.tries_clan && mediator.tries_me)
         {
            clip.attack_block.tf_tries.text = Translate.translateArgs("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES",mediator.tries_me.value,mediator.tries_clan.value);
            if(mediator.showClanTries)
            {
               clip.attack_block.tf_tries.text = clip.attack_block.tf_tries.text + ("\n" + Translate.translateArgs("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES_CLAN",mediator.tries_clan.value));
            }
         }
      }
      
      private function handler_updateOccupiedSlotsCount() : void
      {
         updateState();
      }
      
      private function handler_updatePoints(param1:int) : void
      {
         clip.attack_block.vs_header.attacker_info.tf_points.text = String(mediator.participant_them.pointsEarned);
         clip.attack_block.vs_header.defender_info.tf_points.text = String(mediator.participant_us.pointsEarned);
      }
      
      private function handler_attackAvaliableForMeUpdate() : void
      {
         updateAttackMarker();
      }
      
      private function handler_setDefenseAvaliableUpdate() : void
      {
         updateDefeseMarker();
      }
   }
}
