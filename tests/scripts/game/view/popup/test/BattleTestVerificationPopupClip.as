package game.view.popup.test
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.battle.gui.BattleGuiToggleButton;
   import game.view.gui.components.ClipLabel;
   
   public class BattleTestVerificationPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_toggle:BattleGuiToggleButton;
      
      public var button_close:BattleGuiToggleButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_count:ClipLabel;
      
      public var tf_result:ClipLabel;
      
      public var marker_girl:GuiClipContainer;
      
      public function BattleTestVerificationPopupClip()
      {
         super();
      }
   }
}
