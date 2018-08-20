package game.view.gui.clanscreen
{
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupCharacter;
   import game.view.gui.homescreen.HomeScreenBuildingButton;
   
   public class ClanScreenTitanSoulMerchantButton extends HomeScreenBuildingButton
   {
       
      
      public var character:ZeppelinPopupCharacter;
      
      public function ClanScreenTitanSoulMerchantButton()
      {
         character = new ZeppelinPopupCharacter();
         super();
      }
      
      public function dispose() : void
      {
         character.dispose();
      }
   }
}
