package game.mechanics.dungeon.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.model.PlayerDungeonBattleEnemy;
   import game.mechanics.dungeon.model.state.DungeonFloorElement;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import starling.core.Starling;
   
   public class DungeonBattleEnemyPanelClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_nickname:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var button_attack:ClipButtonLabeled;
      
      public var container_element:GuiClipContainer;
      
      public var tf_label_difficulty:ClipLabel;
      
      public var layout_difficulty:ClipLayout;
      
      public var tf_attacker_type:ClipLabel;
      
      public var icon_normal:ClipSprite;
      
      public var icon_hard:ClipSprite;
      
      public var buttons_layout:ClipLayout;
      
      public var team:MiniHeroTeamRenderer;
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var text_layout:ClipLayout;
      
      public var team_layout:ClipLayout;
      
      public var power_layout:ClipLayout;
      
      public function DungeonBattleEnemyPanelClip()
      {
         tf_label_power = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         button_attack = new ClipButtonLabeled();
         container_element = new GuiClipContainer();
         tf_label_difficulty = new ClipLabel();
         layout_difficulty = ClipLayout.horizontalMiddleCentered(0,tf_label_difficulty);
         tf_attacker_type = new ClipLabel();
         buttons_layout = ClipLayout.horizontalCentered(10,button_attack);
         powerIconSmall_inst0 = new ClipSprite();
         text_layout = ClipLayout.horizontalMiddleCentered(4,tf_attacker_type);
         team_layout = ClipLayout.horizontalMiddleCentered(2);
         power_layout = ClipLayout.horizontalMiddleCentered(0,tf_label_power,powerIconSmall_inst0,tf_power);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_power.text = Translate.translate("UI_DIALOG_ARENA_POWER");
         button_attack.label = Translate.translate("UI_DIALOG_ARENA_ATTACK");
      }
      
      public function setData(param1:PlayerDungeonBattleEnemy) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(!param1.attackerType)
         {
            tf_attacker_type.text = Translate.translate("UI_DIALOG_DUNGEON_BATTLE_ATTACKERTYPE_HERO");
         }
         else
         {
            tf_attacker_type.text = Translate.translate("UI_DIALOG_DUNGEON_BATTLE_ATTACKERTYPE_" + param1.attackerType.ident.toUpperCase());
         }
         team.setUnitTeam(param1.heroes);
         var _loc2_:int = team.hero.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            team_layout.addChild(team.hero[_loc3_].graphics);
            _loc3_++;
         }
         if(param1.attackerType)
         {
            _loc4_ = "emblem_" + param1.attackerType.ident;
         }
         else
         {
            _loc4_ = "emblem_" + DungeonFloorElement.NEUTRAL.ident;
         }
         var _loc6_:GuiAnimation = AssetStorage.rsx.dungeon_floors.create(GuiAnimation,_loc4_);
         container_element.container.addChild(_loc6_.graphics);
         tf_power.text = String(param1.power);
         var _loc5_:Boolean = true;
         if(!param1.defenderType)
         {
            tf_label_difficulty.text = Translate.translate("UI_DUNGEON_SELECT_HERO_ENEMY");
         }
         else
         {
            tf_label_difficulty.text = Translate.translate("UI_DUNGEON_SELECT_TITAN_" + param1.defenderType.ident.toUpperCase());
         }
         if(icon_normal)
         {
            icon_normal.graphics.visible = !_loc5_;
         }
         icon_hard.graphics.visible = _loc5_;
         var _loc7_:* = 0.95;
         graphics.scaleY = _loc7_;
         graphics.scaleX = _loc7_;
         Starling.juggler.tween(graphics,0.25,{
            "transition":"easeOut",
            "delay":0.05 + (!!_loc5_?0.05:0),
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
         buttons_layout.visible = !param1;
         if(param1)
         {
            graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
         }
      }
   }
}
