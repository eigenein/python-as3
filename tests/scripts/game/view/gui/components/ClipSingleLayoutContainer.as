package game.view.gui.components
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class ClipSingleLayoutContainer extends GuiClipNestedContainer
   {
       
      
      public var layout:ClipLayout;
      
      public function ClipSingleLayoutContainer(param1:ClipLayout)
      {
         this.layout = param1;
         super();
      }
   }
}
