package game.mechanics.titan_arena.popup.raid
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.mediator.raid.TitanArenaRaidBattlesInfoPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaRaidBattlesInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaRaidBattlesInfoPopupMediator;
      
      private var clip:TitanArenaRaidBattlesInfoPopupClip;
      
      public function TitanArenaRaidBattlesInfoPopup(param1:TitanArenaRaidBattlesInfoPopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.createClip("dialog_titan_arena",TitanArenaRaidBattlesInfoPopupClip,"popup_titan_arena_raid_battles_info");
         addChild(clip.graphics);
         centerPopupBy(clip.bg.graphics);
         if(Translate.has("UI_DIALOG_TITAN_ARENA_BATTLES_INFO"))
         {
            clip.title = Translate.translate("UI_DIALOG_TITAN_ARENA_BATTLES_INFO");
         }
         else
         {
            clip.title = Translate.translate("UI_DIALOG_ARENA_INFO_TOOL_TIP");
         }
         clip.button_close.signal_click.add(mediator.close);
         initBlock(clip.block_attack);
         initBlock(clip.block_defence);
         clip.block_attack.tf_score.text = mediator.pointsAttack;
         clip.block_defence.tf_score.text = mediator.pointsDefence;
         clip.block_attack.tf_header.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP_TF_LABEL_RESULT_ROUND_1");
         clip.block_defence.tf_header.text = Translate.translate("UI_TITAN_ARENA_BATTLE_END_POPUP_TF_LABEL_RESULT_ROUND_2");
         clip.attacker.setUser(mediator.playerUserInfo);
         clip.defender.setUser(mediator.enemy);
         clip.attacker.graphics.touchable = true;
         clip.defender.graphics.touchable = true;
         clip.block_attack.team_self.reversed = true;
         clip.block_attack.team_self.setUnitTeam(mediator.resultAttack.team_me);
         clip.block_attack.team_enemy.setUnitTeam(mediator.resultAttack.team_them,mediator.resultAttack.hpPercentState);
         clip.block_defence.team_enemy.reversed = true;
         clip.block_defence.team_self.setUnitTeam(mediator.resultDefence.team_them);
         clip.block_defence.team_enemy.setUnitTeam(mediator.resultDefence.team_me,mediator.resultDefence.hpPercentState);
         clip.block_attack.button_camera.signal_click.add(mediator.attackReplay);
         clip.block_attack.button_info.signal_click.add(mediator.attackInfo);
         clip.block_attack.button_chat.signal_click.add(mediator.attackShare);
         clip.block_defence.button_camera.signal_click.add(mediator.defenceReplay);
         clip.block_defence.button_info.signal_click.add(mediator.defenceInfo);
         clip.block_defence.button_chat.signal_click.add(mediator.defenceShare);
      }
      
      protected function initBlock(param1:TitanArenaRaidBattlesInfoTeamBlockClip) : void
      {
         param1.tf_self.text = Translate.translate("UI_DIALOG_GRAND_LOG_YOUR_TEAM");
         param1.tf_enemy.text = Translate.translate("UI_DIALOG_GRAND_LOG_ENEMY_TEAM");
         param1.tf_score_label.text = Translate.translate("UI_TITAN_ARENA_VICTORY_POPUP_TF_LABEL_POINTS");
         param1.button_info.label = "i";
         TooltipHelper.addTooltip(param1.button_camera.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_CAMERA_TOOL_TIP")));
         TooltipHelper.addTooltip(param1.button_info.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_INFO_TOOL_TIP")));
         TooltipHelper.addTooltip(param1.button_chat.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_REPLAY_TOOL_TIP")));
      }
   }
}
