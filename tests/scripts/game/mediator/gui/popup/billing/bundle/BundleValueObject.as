package game.mediator.gui.popup.billing.bundle
{
   import game.data.reward.BundleRewardHeroInventoryItem;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.model.user.inventory.InventoryItem;
   
   public class BundleValueObject
   {
       
      
      private var mediator:BundleListPopupMediator;
      
      private var _entry:PlayerBillingBundleEntry;
      
      private var _isHeroBundle:Boolean;
      
      private var _isSkinBundle:Boolean;
      
      private var _isResourceBundle:Boolean;
      
      public function BundleValueObject(param1:BundleListPopupMediator, param2:PlayerBillingBundleEntry)
      {
         var _loc4_:* = null;
         super();
         this.mediator = param1;
         this._entry = param2;
         var _loc6_:int = 0;
         var _loc5_:* = _entry.desc.rewardList;
         for each(var _loc3_ in _entry.desc.rewardList)
         {
            if(_loc3_ is BundleRewardHeroInventoryItem)
            {
               _loc4_ = _loc3_ as BundleRewardHeroInventoryItem;
               if(_loc4_.bundleHeroReward.skin)
               {
                  _isSkinBundle = true;
                  break;
               }
               if(_loc4_.bundleHeroReward.hero)
               {
                  _isHeroBundle = true;
                  break;
               }
               trace("hero");
            }
            else if(_loc3_.item is HeroDescription)
            {
               _isHeroBundle = true;
               break;
            }
         }
         if(!_isHeroBundle && !_isSkinBundle)
         {
            _isResourceBundle = true;
         }
      }
      
      private static function voTypeWeight(param1:BundleValueObject) : Number
      {
         if(param1.isSkinBundle)
         {
            return 1000000000 - param1.entry.desc.requirement_teamLevel;
         }
         if(param1.isHeroBundle)
         {
            return 1000000 - param1.entry.desc.requirement_teamLevel;
         }
         return 1000 - param1.entry.desc.requirement_teamLevel;
      }
      
      public static function sort_byType(param1:BundleValueObject, param2:BundleValueObject) : int
      {
         return voTypeWeight(param1) - voTypeWeight(param2);
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _entry.desc.rewardList;
      }
      
      public function get entry() : PlayerBillingBundleEntry
      {
         return _entry;
      }
      
      public function get isHeroBundle() : Boolean
      {
         return _isHeroBundle;
      }
      
      public function get isSkinBundle() : Boolean
      {
         return _isSkinBundle;
      }
      
      public function get isResourceBundle() : Boolean
      {
         return _isResourceBundle;
      }
      
      public function action_select() : void
      {
         mediator.action_select(this);
      }
   }
}
