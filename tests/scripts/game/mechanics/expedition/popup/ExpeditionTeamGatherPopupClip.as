package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.team.TeamGatherPopupEmptyTeamClip;
   
   public class ExpeditionTeamGatherPopupClip extends GuiClipNestedContainer
   {
       
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const tf_label_power:ClipLabel = new ClipLabel();
      
      public const tf_power:ClipLabel = new ClipLabel();
      
      public const tf_label_power_requirement:ClipLabel = new ClipLabel();
      
      public const tf_power_requirement:ClipLabel = new ClipLabel();
      
      public const tf_label_count_requirement:ClipLabel = new ClipLabel();
      
      public const empty_team:TeamGatherPopupEmptyTeamClip = new TeamGatherPopupEmptyTeamClip();
      
      public const button_start:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_auto:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_close:ClipButton = new ClipButton();
      
      public const popup_size:GuiClipLayoutContainer = new GuiClipLayoutContainer();
      
      public const progress_back:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const progress:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const animation_full:GuiAnimation = new GuiAnimation();
      
      public const team_list:GameScrolledList = new GameScrolledList(null,null,null);
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const hero_list:GameScrolledList = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
      
      public function ExpeditionTeamGatherPopupClip()
      {
         super();
      }
   }
}
