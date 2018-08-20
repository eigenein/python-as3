package game.view.popup
{
   import com.progrestar.framework.ares.core.Node;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButtonLabeledResizeable;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.message.MessagePopupClip;
   
   public class PromptPopupClip extends MessagePopupClip
   {
       
      
      public var button_cancel:ClipButtonLabeledResizeable;
      
      public var layout_buttons:ClipLayout;
      
      public function PromptPopupClip()
      {
         button_cancel = new ClipButtonLabeledResizeable();
         layout_buttons = ClipLayout.horizontalMiddleCentered(4);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         (layout_buttons.layout as HorizontalLayout).paddingTop = 5;
         layout_text.addChild(layout_buttons);
         layout_buttons.addChild(button_ok.graphics);
         layout_buttons.addChild(button_cancel.graphics);
      }
   }
}
