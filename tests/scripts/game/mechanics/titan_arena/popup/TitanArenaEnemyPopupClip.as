package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TitanArenaEnemyPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_attack:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_atk_points:ClipLabel;
      
      public var tf_def_points:ClipLabel;
      
      public var tf_guildname:ClipLabel;
      
      public var tf_label_atk_points:ClipLabel;
      
      public var tf_label_def_points:ClipLabel;
      
      public var tf_label_defeated:ClipLabel;
      
      public var tf_label_defense_team:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var tf_server:ClipLabel;
      
      public var icon_victoryPoint_1:ClipSprite;
      
      public var icon_victoryPoint_2:ClipSprite;
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var team_1:MiniHeroTeamRenderer;
      
      public var line:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var icon_up:ClipSprite;
      
      public var info_icon:ClipSprite;
      
      public var layout_power:ClipLayout;
      
      public var layout_atk:ClipLayout;
      
      public var layout_def:ClipLayout;
      
      public var layout_name:ClipLayout;
      
      public var portrait_group:TitanArenaEnemyPopupClipPortraitGroup;
      
      public var layout_header:ClipLayout;
      
      public function TitanArenaEnemyPopupClip()
      {
         button_attack = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_atk_points = new ClipLabel(true);
         tf_def_points = new ClipLabel(true);
         tf_guildname = new ClipLabel(true);
         tf_label_atk_points = new ClipLabel();
         tf_label_def_points = new ClipLabel();
         tf_label_defeated = new ClipLabel();
         tf_label_defense_team = new ClipLabel();
         tf_label_power = new ClipLabel(true);
         tf_nickname = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         tf_server = new ClipLabel(true);
         icon_victoryPoint_1 = new ClipSprite();
         icon_victoryPoint_2 = new ClipSprite();
         powerIconSmall_inst0 = new ClipSprite();
         team_1 = new MiniHeroTeamRenderer();
         line = new GuiClipScale3Image(148,1);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         icon_up = new ClipSprite();
         info_icon = new ClipSprite();
         layout_power = ClipLayout.horizontalMiddleCentered(0,tf_label_power,powerIconSmall_inst0,tf_power,icon_up,info_icon);
         layout_atk = ClipLayout.horizontalMiddleCentered(2,icon_victoryPoint_1,tf_atk_points);
         layout_def = ClipLayout.horizontalMiddleCentered(2,icon_victoryPoint_2,tf_def_points);
         layout_name = ClipLayout.verticalMiddleLeft(0,tf_nickname,tf_guildname,tf_server);
         portrait_group = new TitanArenaEnemyPopupClipPortraitGroup();
         layout_header = ClipLayout.horizontalMiddleCentered(8,portrait_group,layout_name);
         super();
      }
   }
}
