package game.mechanics.zeppelin.popup.clip
{
   public class ZeppelinPopupDealerButton extends ZeppelinPopupButton
   {
       
      
      public var character_1:ZeppelinPopupCharacter;
      
      public function ZeppelinPopupDealerButton()
      {
         character_1 = new ZeppelinPopupCharacter();
         super();
      }
      
      public function dispose() : void
      {
         character_1.dispose();
      }
   }
}
