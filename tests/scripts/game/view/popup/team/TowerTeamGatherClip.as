package game.view.popup.team
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TowerTeamGatherClip extends GuiClipNestedContainer
   {
       
      
      public const scrollBar:GameScrollBar = new GameScrollBar();
      
      public var tf_header:ClipLabel;
      
      public var tf_label_my_power:ClipLabel;
      
      public var tf_my_power:ClipLabel;
      
      public var tf_enemy_power:ClipLabel;
      
      public var tf_label_enemy_team:ClipLabel;
      
      public var empty_team:TeamGatherPopupEmptyTeamClip;
      
      public var button_start:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var popup_size:GuiClipLayoutContainer;
      
      public var hero_list:GuiClipLayoutContainer;
      
      public var team_list:GuiClipLayoutContainer;
      
      public var enemy_team_list:MiniHeroTeamRenderer;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public function TowerTeamGatherClip()
      {
         tf_header = new ClipLabel();
         tf_label_my_power = new ClipLabel();
         tf_my_power = new ClipLabel();
         tf_enemy_power = new ClipLabel();
         tf_label_enemy_team = new ClipLabel();
         empty_team = new TeamGatherPopupEmptyTeamClip();
         enemy_team_list = new MiniHeroTeamRenderer();
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
