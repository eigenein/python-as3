package game.view.popup.common.resourcepanel
{
   public class PopupResourcePanelLarge extends PopupResourcePanelBase
   {
       
      
      public function PopupResourcePanelLarge()
      {
         super();
      }
      
      override protected function formatTextWidth() : void
      {
         button_plus.graphics.x = tf_value.x + tf_value.width + 4;
         scalePlate.graphics.width = button_plus.graphics.x + button_plus.graphics.width - scalePlate.graphics.x + 4;
      }
   }
}
