package game.assets.storage
{
   import engine.core.assets.RequestableAsset;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.skin.SkinDescription;
   import starling.textures.Texture;
   
   public class InventoryAssetStorage extends AssetTypeStorage
   {
      
      public static const KEY_HERO_ICONS:String = "2";
      
      public static const KEY_QUEST_ICONS:String = "9";
      
      public static const KEY_RUNE_ICONS:String = "12";
       
      
      public function InventoryAssetStorage()
      {
         super();
      }
      
      public function getItemTexture(param1:InventoryItemDescription) : Texture
      {
         var _loc3_:* = null;
         if(param1 is PlayerAvatarDescription)
         {
            return DataStorage.playerAvatar.getTexture(param1 as PlayerAvatarDescription);
         }
         var _loc2_:PseudoResourceDescription = param1 as PseudoResourceDescription;
         if(_loc2_)
         {
            if(!_loc2_.assetAtlas)
            {
               return AssetStorage.rsx.popup_theme.getTexture(_loc2_.iconAssetTexture);
            }
         }
         var _loc5_:CoinDescription = param1 as CoinDescription;
         if(_loc5_)
         {
            if(!_loc5_.assetAtlas)
            {
               return AssetStorage.rsx.popup_theme.getTexture(_loc5_.iconAssetTexture);
            }
         }
         if(param1 is UnitDescription)
         {
            return getUnitSquareTexture(param1 as UnitDescription);
         }
         if(!param1.assetAtlas)
         {
            return missing;
         }
         var _loc4_:IconAtlasAsset = dict[param1.assetAtlas] as IconAtlasAsset;
         _loc3_ = _loc4_.atlas.getTexture(param1.assetTexture);
         if(_loc3_)
         {
            return _loc3_;
         }
         return missing;
      }
      
      public function getItemGUIIconTexture(param1:InventoryItemDescription) : Texture
      {
         if(param1.iconAssetTexture)
         {
            return AssetStorage.rsx.popup_theme.getTexture(param1.iconAssetTexture);
         }
         return missing;
      }
      
      public function getQuestTexture(param1:String) : Texture
      {
         var _loc2_:* = null;
         var _loc3_:IconAtlasAsset = dict["9"] as IconAtlasAsset;
         if(_loc3_)
         {
            _loc2_ = _loc3_.atlas.getTexture(param1);
         }
         if(!_loc2_)
         {
            return missing;
         }
         return _loc2_;
      }
      
      public function getUnitSquareTexture(param1:UnitDescription) : Texture
      {
         var _loc2_:* = null;
         _loc2_ = null;
         if(!param1)
         {
            return missing;
         }
         if(!param1.isPlayable)
         {
            _loc2_ = (dict[param1.assetAtlas] as IconAtlasAsset).atlas.getTexture(param1.assetTexture);
            if(!_loc2_)
            {
               _loc2_ = missing;
            }
            return _loc2_;
         }
         _loc2_ = (dict[param1.assetAtlas] as IconAtlasAsset).atlas.getTexture(param1.assetTexture);
         if(!_loc2_)
         {
            _loc2_ = missing;
         }
         return _loc2_;
      }
      
      public function getSkinTexture(param1:UnitDescription, param2:SkinDescription) : Texture
      {
         var _loc3_:* = null;
         if(!param2)
         {
            return missing;
         }
         if(dict[param2.assetAtlas])
         {
            _loc3_ = (dict[param2.assetAtlas] as IconAtlasAsset).atlas.getTexture(param2.assetTexture);
         }
         else
         {
            _loc3_ = getUnitSquareTexture(param1);
         }
         if(!_loc3_)
         {
            _loc3_ = missing;
         }
         return _loc3_;
      }
      
      override protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         var _loc3_:* = param1;
         if("2" !== _loc3_)
         {
            dict[param1] = new IconAtlasAsset(param2);
         }
         else
         {
            dict[param1] = new HeroIconAssetStorage(param2);
         }
         return dict[param1];
      }
      
      public function getTexture(param1:int, param2:String) : Texture
      {
         var _loc4_:IconAtlasAsset = dict[param1] as IconAtlasAsset;
         var _loc3_:Texture = _loc4_.atlas.getTexture(param2);
         if(_loc3_)
         {
            return _loc3_;
         }
         return missing;
      }
      
      private function get missing() : Texture
      {
         return AssetStorage.rsx.popup_theme.missing_texture;
      }
   }
}
