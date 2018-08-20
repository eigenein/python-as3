package game.view.popup.clan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.ArenaCooldownsClip;
   
   public class ClanEnterCooldownPopupClip extends GuiClipNestedContainer
   {
       
      
      public var cooldowns_panel:ArenaCooldownsClip;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var line:GuiClipScale3Image;
      
      public var layout_main:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public var button_close:ClipButton;
      
      public function ClanEnterCooldownPopupClip()
      {
         cooldowns_panel = new ArenaCooldownsClip();
         tf_header = new ClipLabel();
         tf_message = new ClipLabel();
         line = new GuiClipScale3Image(148,1);
         layout_main = ClipLayout.verticalCenter(8,tf_header,line,tf_message,cooldowns_panel);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         button_close = new ClipButton();
         super();
      }
   }
}
