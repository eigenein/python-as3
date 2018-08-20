package game.view.popup.arena
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class ArenaCooldownAlertPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var cooldowns_panel:ArenaCooldownsClip;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function ArenaCooldownAlertPopupClip()
      {
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         cooldowns_panel = new ArenaCooldownsClip();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
