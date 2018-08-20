package game.mediator.gui.popup.hero
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.hero.HeroEntry;
   import starling.textures.Texture;
   
   public class HeroEntryValueObject extends UnitEntryValueObject
   {
       
      
      protected var _hero:HeroDescription;
      
      protected var _heroEntry:HeroEntry;
      
      public function HeroEntryValueObject(param1:HeroDescription, param2:HeroEntry)
      {
         super();
         this._hero = param1;
         this._heroEntry = param2;
      }
      
      public static function sort(param1:HeroEntryValueObject, param2:HeroEntryValueObject) : int
      {
         return param2.hero.battleOrder - param1.hero.battleOrder;
      }
      
      public static function sortReversed(param1:HeroEntryValueObject, param2:HeroEntryValueObject) : int
      {
         return param1.hero.battleOrder - param2.hero.battleOrder;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get heroEntry() : HeroEntry
      {
         return _heroEntry;
      }
      
      override public function get unit() : UnitDescription
      {
         return _hero;
      }
      
      override public function get qualityFrame() : Texture
      {
         if(_heroEntry && _heroEntry.color)
         {
            return _heroEntry.color.color.frameAsset;
         }
         return HeroColor.defaultFrameAsset;
      }
      
      override public function get qualityFrame_small() : Texture
      {
         if(_heroEntry)
         {
            return _heroEntry.color.color.frameAsset_small;
         }
         return HeroColor.defaultFrameAsset_small;
      }
      
      override public function get levelBackgroundAssetTexture() : Texture
      {
         if(_heroEntry && _heroEntry.color)
         {
            return AssetStorage.rsx.popup_theme.getTexture(_heroEntry.color.color.levelBackgroundAssetTexture);
         }
         return AssetStorage.rsx.popup_theme.getTexture("level_white");
      }
      
      override public function get qualityBackground() : Texture
      {
         if(_heroEntry && _heroEntry.color)
         {
            return AssetStorage.rsx.popup_theme.getTexture(_heroEntry.color.color.backgroundAssetTexture);
         }
         return HeroColor.defaultBackgroundAsset;
      }
      
      override public function get owned() : Boolean
      {
         return _heroEntry;
      }
      
      override public function get icon() : Texture
      {
         return AssetStorage.inventory.getUnitSquareTexture(_hero);
      }
      
      override public function get starCount() : int
      {
         if(_heroEntry)
         {
            return !!_heroEntry.star?_heroEntry.star.star.id:0;
         }
         return 0;
      }
      
      override public function get level() : int
      {
         if(_heroEntry)
         {
            if(_heroEntry.level)
            {
               return _heroEntry.level.level;
            }
         }
         return 0;
      }
      
      override public function getPower() : int
      {
         return !!_heroEntry?_heroEntry.getPower():0;
      }
   }
}
