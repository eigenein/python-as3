package game.view.gui.overlay.offer
{
   import com.progrestar.framework.ares.core.Node;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   import starling.display.Quad;
   
   public class SpecialOfferClipButton extends DataClipButton
   {
       
      
      protected var icon:SpecialOfferIconDescription;
      
      public var sizeQuad:Quad;
      
      public var layout_hitArea:ClipLayout;
      
      public function SpecialOfferClipButton()
      {
         sizeQuad = new Quad(100,100);
         layout_hitArea = ClipLayout.none();
         super(SpecialOfferIconDescription);
      }
      
      public function dispose() : void
      {
         signal_click.clear();
         icon = null;
      }
      
      public function setIcon(param1:SpecialOfferIconDescription) : void
      {
         this.icon = param1;
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
      
      override protected function getClickData() : *
      {
         return icon;
      }
   }
}
