package game.view.popup.settings
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SettingsPopupClip extends GuiClipNestedContainer
   {
       
      
      public var bg:GuiClipScale9Image;
      
      public var tf_title:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var volume_item:Vector.<SettingVolumeSliderClip>;
      
      public var settings_item:Vector.<SettingToggleButton>;
      
      public var layout_settings:ClipLayout;
      
      public var button_blacklist:ClipButtonLabeled;
      
      public function SettingsPopupClip()
      {
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_title = new ClipLabel();
         button_close = new ClipButton();
         volume_item = new Vector.<SettingVolumeSliderClip>();
         settings_item = new Vector.<SettingToggleButton>();
         layout_settings = ClipLayout.vertical(0);
         button_blacklist = new ClipButtonLabeled();
         super();
      }
   }
}
