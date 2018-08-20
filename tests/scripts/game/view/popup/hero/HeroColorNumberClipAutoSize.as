package game.view.popup.hero
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class HeroColorNumberClipAutoSize extends GuiClipNestedContainer
   {
       
      
      public var tf_number:ClipLabel;
      
      public function HeroColorNumberClipAutoSize()
      {
         tf_number = new ClipLabel(true);
         super();
      }
   }
}
