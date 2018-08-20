package game.view.popup.team
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TeamGatherPopupGuiClip extends PopupClipBase
   {
       
      
      public const scrollBar:GameScrollBar = new GameScrollBar();
      
      public var tf_label_my_power:ClipLabel;
      
      public var tf_my_power:ClipLabel;
      
      public var empty_team:TeamGatherPopupEmptyTeamClip;
      
      public var button_start:ClipButtonLabeled;
      
      public var inst0_powerIconRays:ClipSprite;
      
      public var inst0_powerBG_32_32_2:GuiClipScale3Image;
      
      public var inst0_emptySlot:ClipSprite;
      
      public var emptySlot_inst0:ClipSprite;
      
      public var emptySlot_inst1:ClipSprite;
      
      public var emptySlot_inst2:ClipSprite;
      
      public var emptySlot_inst3:ClipSprite;
      
      public var inst0_mainframe_64_64_2_2:GuiClipScale9Image;
      
      public var inst0_underBGglow:ClipSprite;
      
      public var popup_size:GuiClipLayoutContainer;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var hero_list_container:GuiClipLayoutContainer;
      
      public var team_list_container:GuiClipLayoutContainer;
      
      public function TeamGatherPopupGuiClip()
      {
         tf_label_my_power = new ClipLabel();
         tf_my_power = new ClipLabel();
         empty_team = new TeamGatherPopupEmptyTeamClip();
         super();
         button_start = new ClipButtonLabeled();
         inst0_powerIconRays = new ClipSprite();
         inst0_powerBG_32_32_2 = new GuiClipScale3Image(32,2);
         inst0_emptySlot = new ClipSprite();
         emptySlot_inst0 = new ClipSprite();
         emptySlot_inst1 = new ClipSprite();
         emptySlot_inst2 = new ClipSprite();
         emptySlot_inst3 = new ClipSprite();
         inst0_mainframe_64_64_2_2 = new GuiClipScale9Image(new Rectangle(64,64,2,2));
         inst0_underBGglow = new ClipSprite();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(scroll_slider_container)
         {
            scrollBar.height = scroll_slider_container.height;
            scroll_slider_container.addChild(scrollBar);
         }
      }
   }
}
