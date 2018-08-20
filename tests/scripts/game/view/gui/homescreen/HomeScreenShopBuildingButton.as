package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.popup.shop.ShopPopup;
   
   public class HomeScreenShopBuildingButton extends HomeScreenBuildingButton
   {
       
      
      public function HomeScreenShopBuildingButton()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return ShopPopup.music;
      }
   }
}
