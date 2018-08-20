package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.inventory.InventoryItem;
   import idv.cjcat.signals.Signal;
   
   public class HeroBundleRewardPopupDescription
   {
       
      
      public var reward:Vector.<InventoryItem>;
      
      public var title:String;
      
      public var description:String;
      
      public var buttonLabel:String;
      
      public const signal_close:Signal = new Signal();
      
      public var heroSortWeight:int = 2000;
      
      public var skinSortWeight:int = 1000;
      
      public var starmoneySortWeight:int = 10000;
      
      public var skinCoinSortWeight:int = 0;
      
      public var pseudoResourceSortWeight:int = 100;
      
      public function HeroBundleRewardPopupDescription()
      {
         super();
      }
      
      public function getSortedReward() : Vector.<InventoryItem>
      {
         reward.sort(_sortReward);
         return reward;
      }
      
      protected function _sortReward(param1:InventoryItem, param2:InventoryItem) : int
      {
         var _loc3_:int = getRewardSortValue(param1);
         var _loc4_:int = getRewardSortValue(param2);
         return _loc4_ - _loc3_;
      }
      
      protected function getRewardSortValue(param1:InventoryItem) : int
      {
         var _loc2_:int = 0;
         if(param1.item is HeroDescription)
         {
            _loc2_ = _loc2_ + heroSortWeight;
         }
         if(param1.item is SkinDescription)
         {
            _loc2_ = _loc2_ + skinSortWeight;
         }
         if(param1.item is PseudoResourceDescription)
         {
            _loc2_ = _loc2_ + pseudoResourceSortWeight;
         }
         if(param1.item == DataStorage.pseudo.STARMONEY)
         {
            _loc2_ = _loc2_ + starmoneySortWeight;
         }
         if(param1.item.type == InventoryItemType.COIN && (param1.item as CoinDescription).ident.indexOf("skin_coin_") == 0)
         {
            _loc2_ = _loc2_ + skinCoinSortWeight;
         }
         return _loc2_;
      }
   }
}
