package game.view.popup.battle
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.settings.SettingToggleButton;
   
   public class BattlePausePopupClip extends GuiClipNestedContainer
   {
       
      
      public var bg:GuiClipScale9Image;
      
      public var tf_header:ClipLabel;
      
      public var button_continue:ClipButtonLabeled;
      
      public var button_sound:SettingToggleButton;
      
      public var button_music:SettingToggleButton;
      
      public var button_retreat:ClipButtonLabeled;
      
      public var tf_footer:SpecialClipLabel;
      
      public var tf_retreat_description:ClipLabel;
      
      public function BattlePausePopupClip()
      {
         super();
      }
   }
}
