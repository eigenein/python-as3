package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   
   public class ClipButtonMapSecretAnimation extends ClipButton
   {
       
      
      public var anim:GuiAnimation;
      
      public function ClipButtonMapSecretAnimation()
      {
         anim = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         anim.stop();
      }
   }
}
