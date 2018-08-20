package game.mediator.gui.component
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import starling.textures.Texture;
   
   public class RewardHeroExpValueObject
   {
       
      
      private var _hero:HeroDescription;
      
      private var _xp:int;
      
      public function RewardHeroExpValueObject(param1:HeroDescription, param2:int)
      {
         super();
         this._xp = param2;
         this._hero = param1;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get xp() : int
      {
         return _xp;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getItemTexture(_hero);
      }
      
      public function get name() : String
      {
         return _hero.name;
      }
   }
}
