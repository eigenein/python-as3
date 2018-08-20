package game.view.gui.clanscreen
{
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   
   public class ClanScreenTitanArenaButton extends HomeScreenBuildingButton
   {
       
      
      public var island_animation:ClanScreenTitanArenaButtonAnimationClip;
      
      public function ClanScreenTitanArenaButton()
      {
         island_animation = new ClanScreenTitanArenaButtonAnimationClip();
         super();
      }
   }
}
