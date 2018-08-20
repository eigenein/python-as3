package game.mediator.gui.popup.hero.skin
{
   import game.data.storage.skin.SkinDescription;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class HeroPopupSkinValueObject
   {
       
      
      private var _hero:PlayerHeroEntry;
      
      private var _skin:SkinDescription;
      
      public function HeroPopupSkinValueObject(param1:PlayerHeroEntry, param2:SkinDescription)
      {
         super();
         _hero = param1;
         _skin = param2;
      }
      
      public function get skin() : SkinDescription
      {
         return _skin;
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
   }
}
