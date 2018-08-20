package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import feathers.controls.LayoutGroup;
   
   public class GuiClipLayoutContainer extends GuiClipContainer
   {
       
      
      public function GuiClipLayoutContainer()
      {
         super();
         _container = new LayoutGroup();
      }
      
      override public function setNode(param1:Node) : void
      {
         graphics.width = param1.clip.bounds.width;
         graphics.height = param1.clip.bounds.height;
         super.setNode(param1);
      }
      
      public function get layoutGroup() : LayoutGroup
      {
         return _container as LayoutGroup;
      }
   }
}
