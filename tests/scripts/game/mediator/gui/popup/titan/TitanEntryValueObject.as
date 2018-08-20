package game.mediator.gui.popup.titan
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.hero.TitanEntry;
   import starling.textures.Texture;
   
   public class TitanEntryValueObject extends UnitEntryValueObject
   {
       
      
      protected var _titan:TitanDescription;
      
      protected var _titanEntry:TitanEntry;
      
      public function TitanEntryValueObject(param1:TitanDescription, param2:TitanEntry)
      {
         super();
         this._titan = param1;
         this._titanEntry = param2;
      }
      
      public function get titan() : TitanDescription
      {
         return _titan;
      }
      
      public function get titanEntry() : TitanEntry
      {
         return _titanEntry;
      }
      
      override public function get owned() : Boolean
      {
         return _titanEntry;
      }
      
      override public function get icon() : Texture
      {
         return AssetStorage.rsx.titan_icons.getTexture(titan.assetTexture);
      }
      
      override public function get starCount() : int
      {
         if(_titanEntry)
         {
            return !!_titanEntry.star?_titanEntry.star.star.id:0;
         }
         return 0;
      }
      
      override public function get level() : int
      {
         if(_titanEntry)
         {
            if(_titanEntry.level)
            {
               return _titanEntry.level.level;
            }
         }
         return 0;
      }
      
      override public function get unit() : UnitDescription
      {
         return _titan;
      }
      
      override public function get qualityFrame() : Texture
      {
         if(titan.details.type == "ultra")
         {
            return AssetStorage.rsx.popup_theme.getTexture("border_hexagon_super_titan");
         }
         return AssetStorage.rsx.popup_theme.getTexture("border_hexagon_titan");
      }
      
      override public function get qualityFrame_small() : Texture
      {
         if(titan.details.type == "ultra")
         {
            return AssetStorage.rsx.popup_theme.getTexture("border_super_titan_small");
         }
         return AssetStorage.rsx.popup_theme.getTexture("border_titan_small");
      }
      
      override public function get qualityBackground() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("bg_titan_" + titan.details.element.toLowerCase());
      }
      
      override public function get levelBackgroundAssetTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("level_silver");
      }
      
      override public function get descText() : String
      {
         return _titan.descText;
      }
      
      override public function getPower() : int
      {
         return !!_titanEntry?_titanEntry.getPower():0;
      }
   }
}
