package game.assets.storage
{
   import engine.core.assets.RequestableAsset;
   import game.data.storage.skills.SkillDescription;
   import starling.textures.Texture;
   
   public class SkillIconAssetStorage extends AssetTypeStorage
   {
       
      
      public function SkillIconAssetStorage()
      {
         super();
      }
      
      public function getItemTexture(param1:SkillDescription) : Texture
      {
         if(!param1.icon_assetAtlas)
         {
            return AssetStorage.rsx.popup_theme.missing_texture;
         }
         var _loc3_:IconAtlasAsset = dict[param1.icon_assetAtlas] as IconAtlasAsset;
         var _loc2_:Texture = _loc3_.atlas.getTexture(param1.icon_assetTexture);
         return !!_loc2_?_loc2_:AssetStorage.rsx.popup_theme.missing_texture;
      }
      
      override protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         var _loc3_:* = new IconAtlasAsset(param2);
         dict[param1] = _loc3_;
         return _loc3_;
      }
   }
}
