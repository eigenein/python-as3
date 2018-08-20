package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanArenaBattleEndPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaBattleEndPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaBattleEndPopupMediator;
      
      public function TitanArenaBattleEndPopup(param1:TitanArenaBattleEndPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:RsxGuiAsset = AssetStorage.rsx.getByName(TitanArenaPopup.ASSET_IDENT) as RsxGuiAsset;
         var _loc2_:TitanArenaBattleEndPopupClip = _loc1_.create(TitanArenaBattleEndPopupClip,"titan_arena_battle_end_popup2");
         addChild(_loc2_.graphics);
         _loc2_.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         _loc2_.okButton.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_OK");
         _loc2_.tf_label_reward.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_REWARD");
         _loc2_.tf_label_result_improved.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_RESULT_IMPROVED");
         _loc2_.tf_label_points.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_POINTS");
         _loc2_.tf_label_header.text = !!mediator.victory?Translate.translate("UI_DIALOG_ARENA_VICTORY"):Translate.translate("UI_CLAN_WAR_VICTORY_TF_LABEL_HEADER");
         _loc2_.tf_label_result_round_1.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP_TF_LABEL_RESULT_ROUND_1");
         _loc2_.tf_label_result_round_2.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP_TF_LABEL_RESULT_ROUND_2");
         _loc2_.team_1.reversed = true;
         _loc2_.team_1.setUnitTeam(mediator.roundResult.team_me);
         _loc2_.team_2.setUnitTeam(mediator.roundResult.team_them,mediator.roundResult.hpPercentState);
         _loc2_.team_3.reversed = true;
         _loc2_.team_3.setUnitTeam(mediator.roundResult_def.team_me,mediator.roundResult_def.hpPercentState);
         _loc2_.team_4.setUnitTeam(mediator.roundResult_def.team_them);
         if(mediator.user_me)
         {
            _loc2_.tf_name_1.text = mediator.user_me.nickname;
         }
         if(mediator.user_them)
         {
            _loc2_.tf_name_2.text = mediator.user_them.nickname;
         }
         _loc2_.player_portrait_2.portrait.direction = -1;
         _loc2_.player_portrait_1.setData(mediator.user_me);
         _loc2_.player_portrait_2.setData(mediator.user_them);
         _loc2_.tf_label_defender_1.text = Translate.translate("UI_DIALOG_GRAND_LOG_ENEMY_TEAM");
         _loc2_.tf_label_defender_2.text = Translate.translate("UI_DIALOG_GRAND_LOG_YOUR_TEAM");
         _loc2_.tf_label_attacker_1.text = Translate.translate("UI_DIALOG_GRAND_LOG_YOUR_TEAM");
         _loc2_.tf_label_attacker_2.text = Translate.translate("UI_DIALOG_GRAND_LOG_ENEMY_TEAM");
         _loc2_.tf_label_points_1.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP2_POINTS_EARNED");
         _loc2_.tf_label_points_2.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP2_POINTS_EARNED");
         _loc2_.tf_points_1.text = mediator.reward_attackPoints_string;
         _loc2_.tf_points_2.text = mediator.reward_defensePoints_string;
         _loc2_.tf_points_improve_1.text = mediator.reward_attackPoints_improveString;
         _loc2_.tf_points_improve_2.text = mediator.reward_defensePoints_improveString;
         if(mediator.reward && mediator.reward.outputDisplay.length)
         {
            _loc2_.reward_item_1.setData(mediator.reward.outputDisplayFirst);
            _loc2_.playback.gotoAndStop(0);
         }
         else
         {
            _loc2_.playback.gotoAndStop(1);
            _loc2_.layout_reward.visible = false;
            _loc2_.tf_label_reward.graphics.visible = false;
            _loc2_.reward_item_1.graphics.visible = false;
         }
         _loc2_.button_stats_inst0.signal_click.add(mediator.action_showStats);
         _loc2_.okButton.signal_click.add(mediator.close);
         width = _loc2_.layout_size.width;
         height = _loc2_.layout_size.height;
      }
   }
}
