package game.mediator.gui.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.UnitEntry;
   import starling.textures.Texture;
   
   public class UnitEntryValueObject
   {
       
      
      public function UnitEntryValueObject()
      {
         super();
      }
      
      public static function create(param1:UnitDescription, param2:UnitEntry = null) : UnitEntryValueObject
      {
         if(param1 is HeroDescription)
         {
            return new HeroEntryValueObject(param1 as HeroDescription,param2 as HeroEntry);
         }
         if(param1 is TitanDescription)
         {
            return new TitanEntryValueObject(param1 as TitanDescription,param2 as TitanEntry);
         }
         return null;
      }
      
      public function get empty() : Boolean
      {
         return !unit;
      }
      
      public function get owned() : Boolean
      {
         return false;
      }
      
      public function get id() : int
      {
         return unit.id;
      }
      
      public function get name() : String
      {
         return !!unit?unit.name:"";
      }
      
      public function get descText() : String
      {
         return name + "\n" + Translate.translateArgs("UI_COMMON_LEVEL",level);
      }
      
      public function get levelBackgroundAssetTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("level_white");
      }
      
      public function get icon() : Texture
      {
         return null;
      }
      
      public function get qualityFrame() : Texture
      {
         return HeroColor.defaultFrameAsset;
      }
      
      public function get qualityFrame_small() : Texture
      {
         return HeroColor.defaultFrameAsset_small;
      }
      
      public function get qualityBackground() : Texture
      {
         return HeroColor.defaultBackgroundAsset;
      }
      
      public function get starCount() : int
      {
         return 0;
      }
      
      public function get level() : int
      {
         return 0;
      }
      
      public function get unit() : UnitDescription
      {
         return null;
      }
      
      public function getPower() : int
      {
         return 0;
      }
   }
}
