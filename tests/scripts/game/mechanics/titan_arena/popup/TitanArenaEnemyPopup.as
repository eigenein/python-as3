package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanArenaEnemyPopupMediator;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class TitanArenaEnemyPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:TitanArenaEnemyPopupMediator;
      
      public function TitanArenaEnemyPopup(param1:TitanArenaEnemyPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName(TitanArenaPopup.ASSET_IDENT));
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         super.onAssetLoaded(param1);
         var _loc5_:TitanArenaEnemyPopupClip = param1.create(TitanArenaEnemyPopupClip,"dialog_titan_arena_enemy") as TitanArenaEnemyPopupClip;
         addChild(_loc5_.graphics);
         width = _loc5_.bg.graphics.width;
         height = _loc5_.bg.graphics.height;
         var _loc3_:PlayerTitanArenaEnemy = mediator.enemy;
         _loc5_.portrait_group.portrait.setData(_loc3_);
         _loc5_.layout_name.width = NaN;
         if(_loc3_.clanInfo && !_loc3_.isBot)
         {
            _loc5_.tf_guildname.text = _loc3_.clanInfo.title;
            _loc5_.portrait_group.clan_icon.setData(_loc3_.clanInfo);
         }
         else
         {
            _loc5_.portrait_group.container.removeChild(_loc5_.portrait_group.clan_icon.graphics);
            _loc5_.portrait_group.container.removeChild(_loc5_.portrait_group.clan_icon_bg.graphics);
            _loc5_.tf_guildname.visible = false;
         }
         _loc5_.tf_nickname.text = _loc3_.nickname;
         _loc5_.tf_label_defense_team.text = Translate.translate("UI_TITAN_ARENA_DEFENSE_UI_TF_LABEL_DEFENDERS");
         _loc5_.tf_label_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         _loc5_.tf_power.text = _loc3_.power.toString();
         _loc5_.icon_up.graphics.visible = !_loc3_.isBot && mediator.enemy.isBuffed;
         if(!_loc3_.isBot && mediator.enemy.isBuffed)
         {
            if(mediator.isHeroicStage && Translate.has("UI_DIALOG_TITAN_ARENA_ENEMY_POWER_INFO_LAST_STAGE"))
            {
               _loc4_ = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_POWER_INFO_LAST_STAGE");
            }
            else
            {
               _loc4_ = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_POWER_INFO");
            }
            _loc2_ = new TooltipVO(TooltipTextView,_loc4_);
            TooltipHelper.addTooltip(_loc5_.icon_up.graphics,_loc2_);
         }
         _loc5_.info_icon.graphics.visible = false;
         _loc5_.tf_label_atk_points.text = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_TF_LABEL_ATK_POINTS");
         _loc5_.tf_atk_points.text = _loc3_.points_attack + "/" + _loc3_.points_attackMax;
         _loc5_.tf_label_def_points.text = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_TF_LABEL_DEF_POINTS");
         _loc5_.tf_def_points.text = _loc3_.points_defense + "/" + _loc3_.points_defenseMax;
         _loc5_.tf_label_defeated.text = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_TF_LABEL_DEFEATED");
         _loc5_.tf_label_defeated.visible = _loc3_.defeated;
         if(_loc3_.isBot)
         {
            _loc5_.tf_server.text = Translate.translate("UI_DIALOG_TITAN_ARENA_ENEMY_BOT");
         }
         else
         {
            _loc5_.tf_server.text = Translate.translateArgs("UI_DIALOG_MERGE_SERVER",_loc3_.serverId);
         }
         _loc5_.button_attack.label = Translate.translate("UI_DIALOG_TEAM_GATHER_START");
         _loc5_.button_attack.graphics.visible = !_loc3_.defeated;
         _loc5_.button_attack.signal_click.add(mediator.action_attack);
         _loc5_.button_close.signal_click.add(mediator.close);
         _loc5_.team_1.setUnitTeam(_loc3_.getTeam(0));
         (_loc5_.layout_name.layout as VerticalLayout).paddingTop = -10;
      }
   }
}
