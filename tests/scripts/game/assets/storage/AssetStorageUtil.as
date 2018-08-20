package game.assets.storage
{
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import starling.textures.Texture;
   
   public class AssetStorageUtil
   {
       
      
      public function AssetStorageUtil()
      {
         super();
      }
      
      public static function getItemTexture(param1:InventoryItem) : Texture
      {
         return getItemDescTexture(param1.item);
      }
      
      public static function getItemDescTexture(param1:InventoryItemDescription) : Texture
      {
         if(param1 is HeroDescription)
         {
            return AssetStorage.inventory.getUnitSquareTexture(param1 as HeroDescription);
         }
         if(param1 is TitanDescription)
         {
            return AssetStorage.rsx.titan_icons.getTexture(param1.assetTexture);
         }
         if(param1 is ArtifactDescription)
         {
            return AssetStorage.rsx.artifact_icons.getTexture(param1.assetTexture);
         }
         if(param1 is TitanArtifactDescription)
         {
            return AssetStorage.rsx.titan_artifact_icons.getTexture(param1.assetTexture);
         }
         return AssetStorage.inventory.getItemTexture(param1);
      }
      
      public static function getItemFrameTexture(param1:InventoryItem) : Texture
      {
         if(param1 is InventoryFragmentItem)
         {
            if(param1.item is HeroDescription)
            {
               return HeroColor.defaultFragmentFrameAsset;
            }
            if(param1.item is TitanDescription)
            {
               return AssetStorage.rsx.popup_theme.getTexture("border_fragment_titan");
            }
            if(param1.item is SkinDescription)
            {
               return AssetStorage.rsx.popup_theme.getTexture("border_item_skin");
            }
            if(param1.item is ArtifactDescription)
            {
               return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact");
            }
            if(param1.item is TitanArtifactDescription)
            {
               return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact");
            }
            return param1.item.color.fragmentFrameAsset;
         }
         return getItemDescFrameTexture(param1.item);
      }
      
      public static function getArtifactSmallFrameTexture(param1:PlayerHeroArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_small_" + param1.color);
      }
      
      public static function getTitanArtifactSmallFrameTexture(param1:PlayerTitanArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_small_" + param1.color);
      }
      
      public static function getArtifactBigFrameTexture(param1:PlayerHeroArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_big_" + param1.color);
      }
      
      public static function getTitanArtifactBigFrameTexture(param1:PlayerTitanArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_big_" + param1.color);
      }
      
      public static function getArtifactLevelTexture(param1:PlayerHeroArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_lvl_" + param1.color);
      }
      
      public static function getTitanArtifactLevelTexture(param1:PlayerTitanArtifact) : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("artifact_lvl_" + param1.color);
      }
      
      public static function getArtifactFragmentTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact");
      }
      
      public static function getTitanArtifactFragmentTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact");
      }
      
      public static function getArtifactSmallFragmentTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact_small");
      }
      
      public static function getTitanArtifactSmallFragmentTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture("border_fragment_artifact_small");
      }
      
      public static function getProxyFrameTexture(param1:InventoryItemCountProxy) : Texture
      {
         if(param1.fragment)
         {
            return param1.item.color.fragmentFrameAsset;
         }
         return getItemDescFrameTexture(param1.item);
      }
      
      public static function getItemDescFrameTexture(param1:InventoryItemDescription) : Texture
      {
         if(param1 is PseudoResourceDescription || param1 is CoinDescription)
         {
            return AssetStorage.rsx.popup_theme.getTexture("SimpleFrame");
         }
         if(param1 is HeroDescription)
         {
            return AssetStorage.rsx.popup_theme.getTexture("border_super_white");
         }
         if(param1 is TitanDescription)
         {
            if((param1 as TitanDescription).details.type == "ultra")
            {
               return AssetStorage.rsx.popup_theme.getTexture("border_hexagon_super_titan");
            }
            return AssetStorage.rsx.popup_theme.getTexture("border_hexagon_titan");
         }
         return param1.color.frameAsset;
      }
      
      public static function getItemGUIIcon(param1:InventoryItemDescription) : Texture
      {
         return AssetStorage.inventory.getItemGUIIconTexture(param1);
      }
   }
}
