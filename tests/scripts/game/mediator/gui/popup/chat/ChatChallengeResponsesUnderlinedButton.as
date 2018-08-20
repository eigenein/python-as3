package game.mediator.gui.popup.chat
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   
   public class ChatChallengeResponsesUnderlinedButton extends ClipButtonLabeledUnderlined
   {
      
      private static const ALPHA_MOUSE_OVER:Number = 1;
      
      private static const ALPHA_MOUSE_OUT:Number = 0.6;
       
      
      public function ChatChallengeResponsesUnderlinedButton()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.alpha = 0.6;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            graphics.alpha = !!isInHover?1:0.6;
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
   }
}
