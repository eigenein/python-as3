package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarLogBattleItemClip extends ClipAnimatedContainer
   {
       
      
      public var bg:GuiClipScale9Image;
      
      public var tf_date:ClipLabel;
      
      public var tf_position:ClipLabel;
      
      public var tf_position_index:ClipLabel;
      
      public var tf_points:ClipLabel;
      
      public var tf_free_captured:SpecialClipLabel;
      
      public var panel_attacker:ClanWarLogBattlePlayerPanelClip;
      
      public var panel_defender:ClanWarLogBattlePlayerPanelClip;
      
      public var button_chat:ClipButton;
      
      public var button_info:ClipButtonLabeled;
      
      public var button_replay:ClipButton;
      
      public var icon_vs:ClipSprite;
      
      public var icon_VP:ClipSprite;
      
      public var points_glow:ClipSprite;
      
      public var layout_points:ClipLayout;
      
      public var layout_buttons:ClipLayout;
      
      public var layout_position:ClipLayout;
      
      public var layout_free_captured:ClipLayout;
      
      public var tf_defeat:ClipLabel;
      
      public var tf_draw:ClipLabel;
      
      public var tf_victory:ClipLabel;
      
      public function ClanWarLogBattleItemClip()
      {
         bg = new GuiClipScale9Image();
         tf_date = new ClipLabel();
         tf_position = new ClipLabel();
         tf_position_index = new ClipLabel();
         tf_points = new ClipLabel(true);
         tf_free_captured = new SpecialClipLabel();
         panel_attacker = new ClanWarLogBattlePlayerPanelClip(1);
         panel_defender = new ClanWarLogBattlePlayerPanelClip(-1);
         button_chat = new ClipButton();
         button_info = new ClipButtonLabeled();
         button_replay = new ClipButton();
         icon_vs = new ClipSprite();
         icon_VP = new ClipSprite();
         points_glow = new ClipSprite();
         layout_points = ClipLayout.horizontalMiddleCentered(4,icon_VP,tf_points);
         layout_buttons = ClipLayout.horizontalCentered(0,button_chat,button_info,button_replay);
         layout_position = ClipLayout.horizontalMiddle(0,tf_position);
         layout_free_captured = ClipLayout.horizontalMiddle(0,tf_free_captured);
         tf_defeat = new ClipLabel();
         tf_draw = new ClipLabel();
         tf_victory = new ClipLabel();
         super();
      }
      
      public function toggleWasCapturedWithBattle(param1:Boolean) : void
      {
         panel_attacker.graphics.visible = param1;
         panel_defender.graphics.visible = param1;
         layout_buttons.graphics.visible = param1;
         icon_vs.graphics.visible = param1;
         tf_free_captured.graphics.visible = !param1;
         if(!param1)
         {
            tf_victory.graphics.visible = param1;
            tf_defeat.graphics.visible = param1;
            tf_draw.graphics.visible = param1;
         }
      }
   }
}
