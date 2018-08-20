package game.mechanics.clan_war.popup.plan
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanWarPlanScreenClip extends GuiClipNestedContainer
   {
       
      
      public var plan_map:ClanWarPlanMapClip;
      
      public var tf_name:SpecialClipLabel;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var clan_icon_bg:ClipSpriteUntouchable;
      
      public var button_close:ClipButton;
      
      public var button_members:ClipButtonLabeled;
      
      public var red_dot:ClipSprite;
      
      public var layout_button_members:ClipLayout;
      
      public var headerMap_178_178_2_inst0:GuiClipScale3Image;
      
      public var tf_title:ClipLabel;
      
      public var layout_header:ClipLayout;
      
      public var bg_member_status:ClipSprite;
      
      public var tf_desc:SpecialClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var layout_playerstatus:ClipLayout;
      
      public function ClanWarPlanScreenClip()
      {
         plan_map = new ClanWarPlanMapClip();
         tf_name = new SpecialClipLabel();
         clan_icon = new ClanIconWithFrameClip();
         clan_icon_bg = new ClipSpriteUntouchable();
         button_close = new ClipButton();
         button_members = new ClipButtonLabeled();
         red_dot = new ClipSprite();
         layout_button_members = ClipLayout.none(button_members,red_dot);
         headerMap_178_178_2_inst0 = new GuiClipScale3Image(178,2);
         tf_title = new ClipLabel(true);
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_title);
         bg_member_status = new ClipSprite();
         tf_desc = new SpecialClipLabel();
         tf_header = new ClipLabel();
         layout_playerstatus = ClipLayout.verticalCenter(10,tf_header,tf_desc);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_playerstatus.addChild(layout_button_members);
      }
   }
}
