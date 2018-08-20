package game.mediator.gui.popup.chat.userinfo
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ChatUserInfoPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var title_tf:ClipLabel;
      
      public var id_tf:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var hero_description_line_inst0:ClipSprite;
      
      public var line:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_content:ClipLayout;
      
      public var ban_tf:ClipLabel;
      
      public var action_button1:ClipButtonLabeled;
      
      public var action_button2:ClipButtonLabeled;
      
      public var action_button3:ClipButtonLabeled;
      
      public var button_profile:ClipButtonLabeledUnderlined;
      
      public var layout_profile:ClipLayout;
      
      public var blackListActionButton:ClipButtonLabeled;
      
      public var layout_ban_grouop:ClipLayout;
      
      public function ChatUserInfoPopUpClip()
      {
         button_close = new ClipButton();
         title_tf = new ClipLabel();
         id_tf = new ClipLabel();
         portrait = new PlayerPortraitClip();
         hero_description_line_inst0 = new ClipSprite();
         line = new GuiClipScale3Image();
         bg = new GuiClipScale9Image();
         layout_content = ClipLayout.horizontalMiddleCentered(20,portrait);
         ban_tf = new ClipLabel(true);
         action_button1 = new ClipButtonLabeled();
         action_button2 = new ClipButtonLabeled();
         action_button3 = new ClipButtonLabeled();
         button_profile = new ClipButtonLabeledUnderlined();
         layout_profile = ClipLayout.horizontalCentered(0,button_profile);
         blackListActionButton = new ClipButtonLabeled();
         layout_ban_grouop = ClipLayout.horizontalMiddleCentered(4,ban_tf,action_button1,action_button2,action_button3);
         super();
      }
   }
}
