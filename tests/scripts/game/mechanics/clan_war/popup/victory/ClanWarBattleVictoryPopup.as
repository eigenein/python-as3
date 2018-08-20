package game.mechanics.clan_war.popup.victory
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarBattleVictoryPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanWarBattleVictoryPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanWarBattleVictoryPopupMediator;
      
      private var clip:ClanWarBattleVictoryPopupClip;
      
      public function ClanWarBattleVictoryPopup(param1:ClanWarBattleVictoryPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarBattleVictoryPopupClip,"clan_war_victory");
         addChild(clip.graphics);
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         clip.okButton.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_OK");
         clip.tf_label_header.text = !!mediator.victory?Translate.translate("UI_DIALOG_ARENA_VICTORY"):Translate.translate("UI_CLAN_WAR_VICTORY_TF_LABEL_HEADER");
         clip.team_1.reversed = true;
         clip.team_1.setUnitTeam(mediator.team_me);
         clip.team_2.setUnitTeam(mediator.team_them,mediator.hpPercentState);
         if(mediator.user_me)
         {
            clip.tf_name_1.text = mediator.user_me.nickname;
         }
         if(mediator.user_them)
         {
            clip.tf_name_2.text = mediator.user_them.nickname;
         }
         clip.player_portrait_1.setData(mediator.user_me);
         clip.player_portrait_2.setData(mediator.user_them);
         clip.tf_points_base.text = "+" + mediator.points_base.toString();
         clip.tf_points_building.text = "+" + mediator.points_building.toString();
         clip.tf_label_points_base.text = !!mediator.victory?Translate.translate("UI_CLAN_WAR_VICTORY_TF_LABEL_POINTS_BASE"):Translate.translate("UI_CLAN_WAR_VICTORY_TF_LABEL_POINTS_BASE_NOT_VICTORY");
         clip.tf_label_points_building.text = Translate.translateArgs("UI_CLAN_WAR_VICTORY_TF_LABEL_POINTS_BUILDING",mediator.buildingName);
         clip.attacker_info.setData(mediator.participant_them);
         clip.defender_info.setData(mediator.participant_us);
         clip.defender_info.button_list.graphics.visible = false;
         clip.attacker_info.button_list.graphics.visible = false;
         clip.button_stats_inst0.signal_click.add(mediator.action_showStats);
         clip.okButton.signal_click.add(mediator.close);
         if(mediator.points_building)
         {
            clip.playback.gotoAndStop(0);
         }
         else
         {
            clip.GlowRed_100_100_2_inst2.graphics.visible = false;
            clip.layout_points_building.graphics.visible = false;
            clip.tf_label_points_building.graphics.visible = false;
            clip.playback.gotoAndStop(1);
         }
         width = clip.layout_size.width;
         height = clip.layout_size.height;
      }
   }
}
