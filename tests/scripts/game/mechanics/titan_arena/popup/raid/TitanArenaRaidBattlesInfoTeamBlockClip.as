package game.mechanics.titan_arena.popup.raid
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.gui.components.MiniHeroTeamRendererWithHP;
   
   public class TitanArenaRaidBattlesInfoTeamBlockClip extends GuiClipNestedContainer
   {
       
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const tf_self:ClipLabel = new ClipLabel();
      
      public const tf_enemy:ClipLabel = new ClipLabel();
      
      public const team_self:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public const team_enemy:MiniHeroTeamRendererWithHP = new MiniHeroTeamRendererWithHP();
      
      public const tf_score_label:ClipLabel = new ClipLabel(true);
      
      public const icon_score:ClipSprite = new ClipSprite();
      
      public const tf_score:ClipLabel = new ClipLabel(true);
      
      public const layout_score:ClipLayout = ClipLayout.horizontalMiddleCentered(2,tf_score_label,icon_score,tf_score);
      
      public var button_chat:ClipButton;
      
      public var button_info:ClipButtonLabeled;
      
      public var button_camera:ClipButton;
      
      public var buttons_layout:ClipLayout;
      
      public function TitanArenaRaidBattlesInfoTeamBlockClip()
      {
         button_chat = new ClipButton();
         button_info = new ClipButtonLabeled();
         button_camera = new ClipButton();
         buttons_layout = ClipLayout.horizontalMiddleCentered(5,button_chat,button_info,button_camera);
         super();
      }
   }
}
