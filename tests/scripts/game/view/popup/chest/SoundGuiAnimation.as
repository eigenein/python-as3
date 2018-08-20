package game.view.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   
   public class SoundGuiAnimation extends GuiAnimation
   {
       
      
      public function SoundGuiAnimation()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation.playSoundsTo(Game.instance.soundPlayer);
      }
   }
}
