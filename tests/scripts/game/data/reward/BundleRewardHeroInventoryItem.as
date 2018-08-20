package game.data.reward
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleHeroReward;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class BundleRewardHeroInventoryItem extends InventoryItem
   {
       
      
      private var _bundleHeroReward:BundleHeroReward;
      
      public function BundleRewardHeroInventoryItem(param1:BundleHeroReward)
      {
         var _loc2_:UnitDescription = param1.hero;
         super(_loc2_,1);
         this._bundleHeroReward = param1;
      }
      
      public function get bundleHeroReward() : BundleHeroReward
      {
         return _bundleHeroReward;
      }
      
      override public function get name() : String
      {
         if(bundleHeroReward.type == "skin")
         {
            return Translate.translate("UI_POPUP_BUNDLE_HERO_REWARD_SKIN");
         }
         return super.name;
      }
      
      public function get description() : String
      {
         var _loc1_:* = null;
         if(bundleHeroReward.type == "skin")
         {
            _loc1_ = DataStorage.skin.getById(bundleHeroReward.reward.id) as SkinDescription;
            return _item.name + " - " + _loc1_.name;
         }
         var _loc2_:int = bundleHeroReward.heroEntry.level.level;
         if(bundleHeroReward.type == "summon" && bundleHeroReward.reward_level > 1)
         {
            return Translate.translateArgs("UI_POPUP_BUNDLE_3_HERO_DESC",_loc2_);
         }
         if(bundleHeroReward.type == "evolve")
         {
            return Translate.translate("UI_POPUP_BUNDLE_HERO_REWARD_EVOLVE");
         }
         return Translate.translate("UI_POPUP_BUNDLE_HERO_REWARD");
      }
   }
}
