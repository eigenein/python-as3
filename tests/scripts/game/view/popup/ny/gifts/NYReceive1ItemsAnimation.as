package game.view.popup.ny.gifts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipAnimatedContainer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class NYReceive1ItemsAnimation extends ClipAnimatedContainer
   {
       
      
      public var item1:InventoryItemRenderer;
      
      public function NYReceive1ItemsAnimation(param1:Boolean = false)
      {
         super(param1);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         playback.isLooping = false;
      }
   }
}
