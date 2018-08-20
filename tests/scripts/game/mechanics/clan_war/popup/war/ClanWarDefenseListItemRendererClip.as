package game.mechanics.clan_war.popup.war
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.MiniHeroTeamRendererWithHP;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanWarDefenseListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_power:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var tf_label_free:ClipLabel;
      
      public var tf_team_status:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var team:MiniHeroTeamRendererWithHP;
      
      public var icon_VP:ClipSprite;
      
      public var tf_points:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var layout_none:ClipLayout;
      
      public var layout_free:ClipLayout;
      
      public var layout_points:ClipLayout;
      
      public function ClanWarDefenseListItemRendererClip()
      {
         tf_label_power = new ClipLabel();
         tf_name = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         tf_label_free = new ClipLabel();
         tf_team_status = new ClipLabel();
         player_portrait = new PlayerPortraitClip();
         powerIconSmall_inst0 = new ClipSprite();
         team = new MiniHeroTeamRendererWithHP();
         icon_VP = new ClipSprite();
         tf_points = new ClipLabel(true);
         layout_name = ClipLayout.horizontal(4,tf_name,powerIconSmall_inst0,tf_power);
         layout_none = new ClipLayoutNone([tf_label_power,tf_name,tf_power,player_portrait,powerIconSmall_inst0,team,layout_name,tf_team_status]);
         layout_free = ClipLayout.horizontalMiddleCentered(10,tf_label_free);
         layout_points = ClipLayout.horizontalMiddleCentered(4,icon_VP,tf_points);
         super();
      }
   }
}
