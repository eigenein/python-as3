package game.view.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ChestRewardNewPlaque extends GuiClipNestedContainer
   {
       
      
      public var tf_discount:ClipLabel;
      
      public function ChestRewardNewPlaque()
      {
         tf_discount = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_discount.text = "NEW!";
      }
   }
}
