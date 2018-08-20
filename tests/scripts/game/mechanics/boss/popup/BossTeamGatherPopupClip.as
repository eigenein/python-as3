package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.team.TeamGatherPopupEmptyTeamClip;
   
   public class BossTeamGatherPopupClip extends PopupClipBase
   {
       
      
      public const scrollBar:GameScrollBar = new GameScrollBar();
      
      public var tf_description:ClipLabel;
      
      public var tf_label_my_power:ClipLabel;
      
      public var tf_my_power:ClipLabel;
      
      public var empty_team:TeamGatherPopupEmptyTeamClip;
      
      public var button_start:ClipButtonLabeled;
      
      public var popup_size:GuiClipLayoutContainer;
      
      public var hero_list:GuiClipLayoutContainer;
      
      public var team_list:GuiClipLayoutContainer;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public function BossTeamGatherPopupClip()
      {
         tf_description = new ClipLabel();
         tf_label_my_power = new ClipLabel();
         tf_my_power = new ClipLabel();
         empty_team = new TeamGatherPopupEmptyTeamClip();
         scroll_slider_container = new ClipLayoutNone();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         scrollBar.height = scroll_slider_container.height;
         scroll_slider_container.addChild(scrollBar);
      }
   }
}
