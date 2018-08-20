package game.model.user.inventory
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class InventoryFragmentItem extends InventoryItem
   {
       
      
      public function InventoryFragmentItem(param1:InventoryItemDescription, param2:Number = 1)
      {
         super(param1,param2);
      }
      
      override public function get name() : String
      {
         var _loc1_:* = null;
         if(item is SkinDescription)
         {
            _loc1_ = DataStorage.hero.getHeroById((item as SkinDescription).heroId).name;
            return _loc1_ + " - " + (item as SkinDescription).name;
         }
         if(item is UnitDescription)
         {
            return super.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_HERO_FRAGMENT");
         }
         return super.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_FRAGMENT");
      }
      
      override public function get sellCost() : RewardData
      {
         return item.fragmentSellCost;
      }
      
      override public function get descText() : String
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = undefined;
         var _loc1_:* = undefined;
         if(item is UnitDescription)
         {
            return Translate.translateArgs("LIB_FRAGMENT_HERO_DESC",item.fragmentCount,item.name);
         }
         if(item is SkinDescription)
         {
            _loc2_ = DataStorage.hero.getById((item as SkinDescription).heroId).name;
            _loc4_ = GameModel.instance.player.heroes.getById((item as SkinDescription).heroId);
            if(!_loc4_)
            {
               return Translate.translateArgs("LIB_FRAGMENT_SKIN_DESC",_loc2_,item.name,amount);
            }
            if(_loc4_.skinData.getSkinLevelByID(item.id))
            {
               return Translate.translate("LIB_FRAGMENT_SKIN_DESC2");
            }
            return Translate.translate("LIB_FRAGMENT_SKIN_DESC1");
         }
         if(item is ArtifactDescription)
         {
            _loc3_ = DataStorage.artifact.getHeroByArtifact(item as ArtifactDescription);
            _loc2_ = "";
            if(_loc3_ && _loc3_.length > 0)
            {
               _loc2_ = _loc3_[0].name;
            }
            if(_loc3_ && _loc3_.length == 1 || !Translate.has("LIB_FRAGMENT_ARTIFACT_DESC_NONWEAPON"))
            {
               return Translate.translateArgs("LIB_FRAGMENT_ARTIFACT_DESC",item.name,_loc2_);
            }
            return Translate.translateArgs("LIB_FRAGMENT_ARTIFACT_DESC_NONWEAPON",item.name);
         }
         if(item is TitanArtifactDescription)
         {
            _loc1_ = DataStorage.titanArtifact.getTitanByArtifact(item as TitanArtifactDescription);
            _loc2_ = "";
            if(_loc1_ && _loc1_.length > 0)
            {
               _loc2_ = _loc1_[0].name;
            }
            if(_loc1_ && _loc1_.length == 1 || !Translate.has("LIB_FRAGMENT_TITAN_ARTIFACT_DESC_NONWEAPON"))
            {
               return Translate.translateArgs("LIB_FRAGMENT_TITAN_ARTIFACT_DESC",item.name,_loc2_);
            }
            return Translate.translateArgs("LIB_FRAGMENT_TITAN_ARTIFACT_DESC_NONWEAPON",item.name);
         }
         return Translate.translateArgs("LIB_FRAGMENT_DESC",item.fragmentCount,item.name);
      }
      
      override public function toString() : String
      {
         return item.name + " (fragment) x" + amount;
      }
   }
}
