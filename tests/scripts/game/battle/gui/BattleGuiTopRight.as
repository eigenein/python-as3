package game.battle.gui
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.INeedNestedParsing;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class BattleGuiTopRight extends GuiClipLayoutContainer implements INeedNestedParsing
   {
       
      
      public var button_sound:BattleGuiToggleButton;
      
      public var button_pause:BattleGuiToggleButton;
      
      public var tf_timer:ClipLabel;
      
      public var clock_icon:ClipSprite;
      
      public var clock_glow:ClipSprite;
      
      public function BattleGuiTopRight()
      {
         super();
      }
   }
}
