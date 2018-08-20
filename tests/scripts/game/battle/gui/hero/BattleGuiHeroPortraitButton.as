package game.battle.gui.hero
{
   import engine.core.clipgui.GuiClipImage;
   import game.view.gui.components.ClipButton;
   
   public class BattleGuiHeroPortraitButton extends ClipButton
   {
       
      
      public var frame:GuiClipImage;
      
      public var portrait:GuiClipImage;
      
      public var bg:GuiClipImage;
      
      public function BattleGuiHeroPortraitButton()
      {
         super();
      }
      
      override protected function playClickSound() : void
      {
      }
   }
}
