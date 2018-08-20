package game.mediator.gui.popup.billing.bundle
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.GuiClipContainer;
   
   public class BundleListItemContainerAnimation extends ClipAnimatedContainer
   {
       
      
      public const layout:GuiClipContainer = new GuiClipContainer();
      
      public function BundleListItemContainerAnimation()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         playback.gotoAndStop(0);
      }
      
      public function playJump(param1:Number) : void
      {
         if(playback.isPlaying)
         {
            return;
         }
         playback.gotoAndPlay(60 - param1 * 60);
         playback.stopOnFrame(96);
      }
      
      public function playShake(param1:Number) : void
      {
         if(playback.isPlaying)
         {
            return;
         }
         playback.gotoAndPlay(180 - param1 * 60);
         playback.stopOnFrame(216);
      }
   }
}
