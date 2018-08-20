package game.mechanics.clan_war.popup.start
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.mechanics.clan_war.popup.plan.ClanWarDefenderTeamClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClanWarStartScreenClip extends ClipAnimatedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_defense_plan:ClanWarDefensePlanClip;
      
      public var button_leagues:ClipButtonLabeled;
      
      public var button_log:ClipButtonLabeled;
      
      public var button_shop:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_defenders:ClipLabel;
      
      public var attack_block:ClanWarStartScreenAttackBlockClip;
      
      public var decorDivider_inst0:ClipSprite;
      
      public var decorDivider_inst1:ClipSprite;
      
      public var defender_team_heroes:ClanWarDefenderTeamClip;
      
      public var defender_team_titans:ClanWarDefenderTeamClip;
      
      public var tf_no_war_desc:ClipLabel;
      
      public var tf_no_war_header:ClipLabel;
      
      public var tf_no_war_no_defenders:ClipLabel;
      
      public var bg_attack:GuiClipScale9Image;
      
      public var layout_header:ClipLayout;
      
      public var layout_team_title:ClipLayout;
      
      public function ClanWarStartScreenClip()
      {
         button_close = new ClipButton();
         button_defense_plan = new ClanWarDefensePlanClip();
         button_leagues = new ClipButtonLabeled();
         button_log = new ClipButtonLabeled();
         button_shop = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_defenders = new ClipLabel();
         attack_block = new ClanWarStartScreenAttackBlockClip();
         decorDivider_inst0 = new ClipSprite();
         decorDivider_inst1 = new ClipSprite();
         defender_team_heroes = new ClanWarDefenderTeamClip();
         defender_team_titans = new ClanWarDefenderTeamClip();
         tf_no_war_desc = new ClipLabel();
         tf_no_war_header = new ClipLabel();
         tf_no_war_no_defenders = new ClipLabel();
         bg_attack = new GuiClipScale9Image();
         layout_header = ClipLayout.horizontal(4,tf_header);
         layout_team_title = ClipLayout.horizontalMiddleCentered(4,decorDivider_inst0,tf_label_defenders,decorDivider_inst1);
         super();
      }
   }
}
