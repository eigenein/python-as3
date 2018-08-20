package game.view.popup.billing
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class BillingItemBuyButtonOverlayClip extends GuiClipNestedContainer
   {
       
      
      public var button_buy:ClipButtonLabeled;
      
      public var bg:ClipSprite;
      
      public function BillingItemBuyButtonOverlayClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(bg)
         {
            bg.graphics.touchable = false;
         }
      }
   }
}
