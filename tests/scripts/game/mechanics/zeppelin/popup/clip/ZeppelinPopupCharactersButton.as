package game.mechanics.zeppelin.popup.clip
{
   public class ZeppelinPopupCharactersButton extends ZeppelinPopupButton
   {
       
      
      public var character_1:ZeppelinPopupCharacter;
      
      public var character_2:ZeppelinPopupCharacter;
      
      public var character_3:ZeppelinPopupCharacter;
      
      public function ZeppelinPopupCharactersButton()
      {
         character_1 = new ZeppelinPopupCharacter();
         character_2 = new ZeppelinPopupCharacter();
         character_3 = new ZeppelinPopupCharacter();
         super();
      }
      
      public function dispose() : void
      {
         character_1.dispose();
         character_2.dispose();
         character_3.dispose();
      }
   }
}
