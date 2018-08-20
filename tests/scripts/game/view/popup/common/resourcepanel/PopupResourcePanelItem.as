package game.view.popup.common.resourcepanel
{
   public class PopupResourcePanelItem extends PopupResourcePanelBase
   {
       
      
      public function PopupResourcePanelItem()
      {
         super();
      }
      
      override protected function formatTextWidth() : void
      {
         if(button_plus.graphics.visible)
         {
            button_plus.graphics.x = tf_value.x + tf_value.width + 4;
            scalePlate.graphics.width = tf_value.x + tf_value.width + 20 - scalePlate.graphics.x;
         }
         else
         {
            scalePlate.graphics.width = tf_value.x + tf_value.width + 10 - scalePlate.graphics.x;
         }
      }
   }
}
