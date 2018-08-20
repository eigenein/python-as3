package game.battle.gui
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BattleGuiReplayControlsClip extends GuiClipNestedContainer
   {
       
      
      public var button_speed:ButtonMultiToggleButton;
      
      public var button_auto:BattleGuiToggleButton;
      
      public function BattleGuiReplayControlsClip()
      {
         button_speed = new ButtonMultiToggleButton();
         button_auto = new BattleGuiToggleButton();
         super();
      }
   }
}
