package game.view.popup.refillable
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ClipLabelCrossed extends GuiClipNestedContainer
   {
       
      
      private var crossLineExtraWidth:int;
      
      public var tf_label:ClipLabel;
      
      public var cross_line:ClipSprite;
      
      public function ClipLabelCrossed(param1:int = 6)
      {
         tf_label = new ClipLabel(true);
         cross_line = new ClipSprite();
         super();
         this.crossLineExtraWidth = param1;
      }
      
      public function set text(param1:String) : void
      {
         tf_label.text = param1;
         tf_label.validate();
         cross_line.graphics.width = tf_label.width + crossLineExtraWidth;
      }
   }
}
