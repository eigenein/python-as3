package game.view.popup.hero.rune
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HeroElementPopupCircleAnimationClip extends GuiClipNestedContainer
   {
       
      
      public var topMc:GuiAnimation;
      
      public var bottomMc:GuiAnimation;
      
      public function HeroElementPopupCircleAnimationClip()
      {
         topMc = new GuiAnimation();
         bottomMc = new GuiAnimation();
         super();
      }
   }
}
