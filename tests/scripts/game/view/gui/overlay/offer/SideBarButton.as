package game.view.gui.overlay.offer
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import starling.display.Quad;
   
   public class SideBarButton extends ClipButton
   {
       
      
      public const sizeQuad:Quad = new Quad(100,100);
      
      public const layout_hitArea:ClipLayout = ClipLayout.none();
      
      public function SideBarButton()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         sizeQuad.width = layout_hitArea.width;
         sizeQuad.height = layout_hitArea.height;
         container.addChild(sizeQuad);
         sizeQuad.alpha = 0;
         layout_hitArea.graphics.touchable = false;
      }
      
      public function updateTime(param1:String) : void
      {
      }
   }
}
