package game.view.gui.homescreen
{
   import game.view.popup.tower.screen.TowerScreen;
   
   public class HomeScreenTowerButton extends HomeScreenBuildingButton
   {
       
      
      public function HomeScreenTowerButton()
      {
         super();
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return TowerScreen.music;
      }
   }
}
