package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanArenaRoundEndPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaRoundEndPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaRoundEndPopupMediator;
      
      public function TitanArenaRoundEndPopup(param1:TitanArenaRoundEndPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:RsxGuiAsset = AssetStorage.rsx.getByName(TitanArenaPopup.ASSET_IDENT) as RsxGuiAsset;
         var _loc2_:TitanArenaRoundEndPopupClip = _loc1_.create(TitanArenaRoundEndPopupClip,"titan_arena_round_end_popup");
         _loc2_.button_continue.label = Translate.translate("UI_TITAN_ARENA_ROUND_END_POPUP_WATCH_NEXT_ROUND");
         if(Translate.has("UI_TITAN_ARENA_ROUND_END_POPUP_DO_NOT_WATCH_NEXT_ROUND"))
         {
            _loc2_.button_skip_defense.label = Translate.translate("UI_TITAN_ARENA_ROUND_END_POPUP_DO_NOT_WATCH_NEXT_ROUND");
         }
         else
         {
            _loc2_.button_skip_defense.graphics.visible = false;
         }
         addChild(_loc2_.graphics);
         _loc2_.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         _loc2_.tf_label_reward.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_REWARD");
         _loc2_.tf_label_result_improved.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_RESULT_IMPROVED");
         _loc2_.tf_label_points.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_POINTS");
         _loc2_.tf_label_header.text = Translate.translate("UI_TITAN_ARENA_ROUND_END_POPUP_TF_LABEL_HEADER");
         _loc2_.team_1.reversed = true;
         _loc2_.team_1.setUnitTeam(mediator.roundResult.team_me);
         _loc2_.team_2.setUnitTeam(mediator.roundResult.team_them,mediator.roundResult.hpPercentState);
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
         _loc2_.button_stats_inst0.signal_click.add(mediator.action_showStats);
         _loc2_.button_continue.signal_click.add(mediator.action_continue);
         _loc2_.button_skip_defense.signal_click.add(mediator.action_skip);
         _loc2_.playback.gotoAndStop(0);
         if(mediator.state != 3)
         {
            if(mediator.state == 2)
            {
               _loc2_.playback.gotoAndStop(0);
            }
            else
            {
               _loc2_.playback.gotoAndStop(2);
               _loc2_.tf_label_result_improved.visible = false;
            }
            _loc2_.reward_item.data = mediator.reward_attackPoints;
         }
         else
         {
            _loc2_.GlowRed_100_100_2_inst0.graphics.visible = false;
            _loc2_.tf_label_reward.graphics.visible = false;
            _loc2_.playback.gotoAndStop(1);
            _loc2_.tf_label_result_improved.visible = false;
            _loc2_.tf_label_points.visible = false;
            _loc2_.reward_item.graphics.visible = false;
         }
         width = _loc2_.layout_size.width;
         height = _loc2_.layout_size.height;
      }
   }
}
