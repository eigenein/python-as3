package game.view.popup.ny.gifts
{
   public class NYReceivedGiftWithoutReplyRenderer extends NYReceivedGiftRenderer
   {
       
      
      public function NYReceivedGiftWithoutReplyRenderer()
      {
         super();
      }
      
      override public function get replyAvaliable() : Boolean
      {
         return false;
      }
   }
}
