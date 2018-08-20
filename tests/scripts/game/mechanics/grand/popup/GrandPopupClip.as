package game.mechanics.grand.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.popup.arena.ArenaBattleCountClip;
   import game.view.popup.arena.ArenaCooldownsClip;
   
   public class GrandPopupClip extends PopupClipBase
   {
       
      
      public var button_start:ClipButtonLabeled;
      
      public var button_collect:ClipButtonLabeled;
      
      public var button_defenders:ClipButtonLabeled;
      
      public var button_logs:ClipButtonLabeled;
      
      public var button_rules:ClipButtonLabeled;
      
      public var button_shop:ClipButtonLabeled;
      
      public var button_top:ClipButtonLabeled;
      
      public var button_no_defenders:ClipButtonLabeled;
      
      public var tf_placement_amount:ClipLabel;
      
      public var tf_amount:ClipLabel;
      
      public var tf_label_defenders:ClipLabel;
      
      public var tf_label_no_defenders:ClipLabel;
      
      public var tf_label_1:ClipLabel;
      
      public var tf_label_2:ClipLabel;
      
      public var tf_label_3:ClipLabel;
      
      public var tf_label_place:ClipLabel;
      
      public var tf_label_placement_reward:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var icon_power:ClipSprite;
      
      public var team1:MiniHeroTeamRenderer;
      
      public var team2:MiniHeroTeamRenderer;
      
      public var team3:MiniHeroTeamRenderer;
      
      public var cooldowns_panel:ArenaCooldownsClip;
      
      public var battle_count_panel:ArenaBattleCountClip;
      
      public var icon_reward_placement:GuiClipImage;
      
      public var icon_reward:GuiClipImage;
      
      public var icon_has_reward:ClipSprite;
      
      public var decorDivider_inst0:ClipSprite;
      
      public var decorDivider_inst1:ClipSprite;
      
      public var layout_team_title:ClipLayout;
      
      public var layout_timer:ClipLayout;
      
      private var _skipAvailable:Boolean;
      
      public function GrandPopupClip()
      {
         button_start = new ClipButtonLabeled();
         button_collect = new ClipButtonLabeled();
         button_defenders = new ClipButtonLabeled();
         button_logs = new ClipButtonLabeled();
         button_rules = new ClipButtonLabeled();
         button_shop = new ClipButtonLabeled();
         button_top = new ClipButtonLabeled();
         button_no_defenders = new ClipButtonLabeled();
         tf_placement_amount = new ClipLabel(true);
         tf_amount = new ClipLabel(true);
         tf_label_defenders = new ClipLabel();
         tf_label_no_defenders = new ClipLabel();
         tf_label_1 = new ClipLabel();
         tf_label_2 = new ClipLabel();
         tf_label_3 = new ClipLabel();
         tf_label_place = new ClipLabel();
         tf_label_placement_reward = new ClipLabel();
         tf_label_power = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_place = new ClipLabel();
         tf_power = new ClipLabel();
         icon_power = new ClipSprite();
         cooldowns_panel = new ArenaCooldownsClip();
         battle_count_panel = new ArenaBattleCountClip();
         icon_reward_placement = new GuiClipImage();
         icon_reward = new GuiClipImage();
         icon_has_reward = new ClipSprite();
         decorDivider_inst0 = new ClipSprite();
         decorDivider_inst1 = new ClipSprite();
         layout_team_title = ClipLayout.horizontalMiddleCentered(4,decorDivider_inst0,tf_label_defenders,decorDivider_inst1);
         layout_timer = ClipLayout.verticalMiddleCenter(4,battle_count_panel,cooldowns_panel);
         super();
      }
      
      public function get skipAvailable() : Boolean
      {
         return _skipAvailable;
      }
      
      public function set skipAvailable(param1:Boolean) : void
      {
         _skipAvailable = param1;
         if(!skipAvailable && layout_timer.contains(cooldowns_panel.graphics))
         {
            layout_timer.removeChild(cooldowns_panel.graphics);
         }
         if(skipAvailable && !layout_timer.contains(cooldowns_panel.graphics))
         {
            layout_timer.addChild(cooldowns_panel.graphics);
         }
      }
   }
}
