package game.view.gui.clanscreen
{
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   
   public class ClanSummoningCircleBuildingButton extends HomeScreenBuildingButton implements ITutorialButtonBoundsProvider
   {
       
      
      public function ClanSummoningCircleBuildingButton()
      {
         super();
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return 0;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return 0;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return 150;
      }
   }
}
