package game.view.popup.clan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipNumericStepper;
   
   public class ClanEditSettingsPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_save_level:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_max_level:ClipLabel;
      
      public var team_level:ClipNumericStepper;
      
      public var bg:GuiClipScale9Image;
      
      public var tf_label_level_is_updating:ClipLabel;
      
      public var button_roles:ClipButtonLabeled;
      
      public var button_banner:ClipButtonLabeled;
      
      public var button_name:ClipButtonLabeled;
      
      public var black_list_label:ClipLabel;
      
      public var black_list_btn:ClipButton;
      
      public function ClanEditSettingsPopupClip()
      {
         button_save_level = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_label_max_level = new ClipLabel();
         team_level = new ClipNumericStepper();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_label_level_is_updating = new ClipLabel();
         button_roles = new ClipButtonLabeled();
         button_banner = new ClipButtonLabeled();
         button_name = new ClipButtonLabeled();
         black_list_label = new ClipLabel();
         black_list_btn = new ClipButton();
         super();
      }
   }
}
