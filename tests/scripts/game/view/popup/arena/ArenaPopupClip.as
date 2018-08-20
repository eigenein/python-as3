package game.view.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import feathers.layout.VerticalLayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArenaPopupClip extends PopupClipBase
   {
       
      
      private var _skipAvailable:Boolean;
      
      public var btn_shop:ClipButtonLabeled;
      
      public var btn_team:ClipButtonLabeled;
      
      public var btn_logs:ClipButtonLabeled;
      
      public var btn_rules:ClipButtonLabeled;
      
      public var tf_label_my_power:ClipLabel;
      
      public var tf_my_power:ClipLabel;
      
      public var tf_label_my_team:ClipLabel;
      
      public var tf_label_place:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var tf_label_rankingLocked:ClipLabel;
      
      public var cooldowns_panel:ArenaCooldownsClip;
      
      public var battle_count_panel:ArenaBattleCountClip;
      
      public var button_rerollEnemies:ClipButtonLabeled;
      
      public var layout_timer:ClipLayout;
      
      public var enemy:Vector.<ArenaEnemyPanelClip>;
      
      public var decorDivider_inst0:ClipSprite;
      
      public var decorDivider_inst1:ClipSprite;
      
      public var inst0_underBGglow:ClipSprite;
      
      public var powerIconRays_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var sideBGLight_inst3:ClipSprite;
      
      public var team_list_container:ClipLayout;
      
      public var PlaceBG_34_34_1_inst0:GuiClipScale3Image;
      
      public var layout_team_title:ClipLayout;
      
      public function ArenaPopupClip()
      {
         btn_shop = new ClipButtonLabeled();
         btn_team = new ClipButtonLabeled();
         btn_logs = new ClipButtonLabeled();
         btn_rules = new ClipButtonLabeled();
         tf_label_my_power = new ClipLabel();
         tf_my_power = new ClipLabel();
         tf_label_my_team = new ClipLabel(true);
         tf_label_place = new ClipLabel();
         tf_place = new ClipLabel();
         tf_label_rankingLocked = new ClipLabel();
         cooldowns_panel = new ArenaCooldownsClip();
         battle_count_panel = new ArenaBattleCountClip();
         button_rerollEnemies = new ClipButtonLabeled();
         layout_timer = ClipLayout.verticalMiddleCenter(8,battle_count_panel,cooldowns_panel);
         enemy = new Vector.<ArenaEnemyPanelClip>();
         decorDivider_inst0 = new ClipSprite();
         decorDivider_inst1 = new ClipSprite();
         inst0_underBGglow = new ClipSprite();
         powerIconRays_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         sideBGLight_inst3 = new ClipSprite();
         team_list_container = ClipLayout.horizontalCentered(0);
         PlaceBG_34_34_1_inst0 = new GuiClipScale3Image(34,1);
         layout_team_title = ClipLayout.horizontalMiddleCentered(4,decorDivider_inst0,tf_label_my_team,decorDivider_inst1);
         super();
      }
      
      public function get skipAvailable() : Boolean
      {
         return _skipAvailable;
      }
      
      public function set skipAvailable(param1:Boolean) : void
      {
         _skipAvailable = param1;
         if(_skipAvailable)
         {
            (layout_timer.layout as VerticalLayout).paddingBottom = 0;
         }
         else
         {
            (layout_timer.layout as VerticalLayout).paddingBottom = 60;
         }
         if(!skipAvailable && layout_timer.contains(cooldowns_panel.graphics))
         {
            layout_timer.removeChild(cooldowns_panel.graphics);
         }
         if(skipAvailable && !layout_timer.contains(cooldowns_panel.graphics))
         {
            layout_timer.addChild(cooldowns_panel.graphics);
         }
         if(skipAvailable && button_rerollEnemies.graphics.parent)
         {
            button_rerollEnemies.graphics.parent.removeChild(button_rerollEnemies.graphics);
         }
         if(!skipAvailable && !button_rerollEnemies.graphics.parent)
         {
            container.addChild(button_rerollEnemies.graphics);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_my_team.text = Translate.translate("UI_DIALOG_ARENA_MY_TEAM");
         tf_label_place.text = Translate.translate("UI_DIALOG_ARENA_MY_PLACE");
         battle_count_panel.tf_header.text = Translate.translate("UI_DIALOG_ARENA_BATTLE_COUNT");
         btn_team.label = Translate.translate("UI_DIALOG_ARENA_MY_TEAM_SETUP");
         tf_label_my_power.text = Translate.translate("UI_DIALOG_ARENA_POWER");
         btn_shop.label = Translate.translate("UI_DIALOG_ARENA_SHOP");
         btn_rules.label = Translate.translate("UI_DIALOG_ARENA_RULES");
         btn_logs.label = Translate.translate("UI_DIALOG_ARENA_LOGS");
      }
   }
}
