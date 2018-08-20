package game.model.user.shop
{
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class SpecialShopHeroListValueObject
   {
       
      
      private var _shopHero:SpecialShopHeroValueObject;
      
      private var _playerHero:PlayerHeroEntry;
      
      private var _playerHeroListVO:PlayerHeroListValueObject;
      
      public function SpecialShopHeroListValueObject(param1:SpecialShopHeroValueObject)
      {
         super();
         _shopHero = param1;
      }
      
      public static function sort(param1:SpecialShopHeroListValueObject, param2:SpecialShopHeroListValueObject) : int
      {
         return param2.playerHero.getPower() - param1.playerHero.getPower();
      }
      
      public function get shopHero() : SpecialShopHeroValueObject
      {
         return _shopHero;
      }
      
      public function set shopHero(param1:SpecialShopHeroValueObject) : void
      {
         _shopHero = param1;
      }
      
      public function get playerHero() : PlayerHeroEntry
      {
         return _playerHero;
      }
      
      public function set playerHero(param1:PlayerHeroEntry) : void
      {
         _playerHero = param1;
      }
      
      public function get playerHeroListVO() : PlayerHeroListValueObject
      {
         return _playerHeroListVO;
      }
      
      public function set playerHeroListVO(param1:PlayerHeroListValueObject) : void
      {
         _playerHeroListVO = param1;
      }
   }
}
