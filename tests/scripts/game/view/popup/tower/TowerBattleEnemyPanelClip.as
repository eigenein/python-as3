package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.model.user.tower.PlayerTowerBattleEnemy;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import starling.core.Starling;
   
   public class TowerBattleEnemyPanelClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_nickname:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var button_attack:ClipButtonLabeled;
      
      public var button_skip:ClipButtonLabeled;
      
      public var tf_skulls:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var tf_label_difficulty:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_enemy_selected:ClipLabel;
      
      public var icon_normal:ClipSprite;
      
      public var icon_hard:ClipSprite;
      
      public var buttons_layout:ClipLayout;
      
      public var team:MiniHeroTeamRenderer;
      
      public function TowerBattleEnemyPanelClip()
      {
         button_attack = new ClipButtonLabeled();
         button_skip = new ClipButtonLabeled();
         buttons_layout = ClipLayout.horizontalCentered(10,button_attack,button_skip);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_power.text = Translate.translate("UI_DIALOG_ARENA_POWER");
         tf_label_reward.text = Translate.translate("UI_DIALOG_TOWER_BATTLE_FLOOR_ENEMY_REWARD");
         tf_label_points.text = Translate.translate("UI_DIALOG_TOWER_BATTLE_FLOOR_ENEMY_POINTS");
         tf_enemy_selected.text = Translate.translate("UI_DIALOG_TOWER_BATTLE_FLOOR_ENEMY_SELECTED");
         button_attack.label = Translate.translate("UI_DIALOG_ARENA_ATTACK");
         button_skip.label = Translate.translate("UI_TOWER_SKIP_FLOOR_BTN_SKIP");
      }
      
      public function setData(param1:PlayerTowerBattleEnemy) : void
      {
         tf_skulls.text = param1.rewardSkulls;
         tf_points.text = param1.rewardPoints;
         team.setTeam(param1.heroes);
         tf_power.text = String(param1.power);
         var _loc2_:Boolean = true;
         tf_label_difficulty.text = Translate.translate("UI_TOWER_SELECT_ENEMY");
         if(icon_normal)
         {
            icon_normal.graphics.visible = !_loc2_;
         }
         icon_hard.graphics.visible = _loc2_;
         var _loc3_:* = 0.95;
         graphics.scaleY = _loc3_;
         graphics.scaleX = _loc3_;
         Starling.juggler.tween(graphics,0.25,{
            "transition":"easeOut",
            "delay":0.05 + (!!_loc2_?0.05:0),
            "scaleX":1,
            "scaleY":1
         });
      }
      
      public function setDisabled(param1:Boolean) : void
      {
         button_attack.isEnabled = !param1;
         if(graphics.filter)
         {
            graphics.filter.dispose();
            graphics.filter = null;
         }
         tf_enemy_selected.visible = param1;
         buttons_layout.visible = !param1;
         if(param1)
         {
            graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
         }
      }
   }
}
