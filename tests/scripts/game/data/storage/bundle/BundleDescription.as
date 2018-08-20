package game.data.storage.bundle
{
   import game.data.reward.BundleRewardHeroInventoryItem;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   
   public class BundleDescription extends DescriptionBase
   {
      
      public static const BUNDLE_SKIN_DEMON_ASTAROTH:int = 27;
      
      public static const BUNDLE_SKIN_DEMON_CHABBA:int = 28;
      
      public static const BUNDLE_SKIN_DEMON_GINGER:int = 29;
       
      
      private var _desc_locale_key:String;
      
      private var _title_locale_key:String;
      
      private var _groupId:int;
      
      private var _rawReward:Object;
      
      private var _requirement:Object;
      
      private var _reward:RewardData;
      
      private var _rewardList:Vector.<InventoryItem>;
      
      private var _duration:int;
      
      private var _iconClipType:String;
      
      private var _iconClip:String;
      
      private var _dialogType:String;
      
      private var _dialogClip:String;
      
      public function BundleDescription(param1:Object)
      {
         var _loc3_:* = null;
         super();
         _rawReward = param1.reward;
         _id = param1.id;
         if(param1.reward is Array)
         {
            _rewardList = new Vector.<InventoryItem>();
            _reward = new RewardData();
            var _loc5_:int = 0;
            var _loc4_:* = param1.reward;
            for each(var _loc2_ in param1.reward)
            {
               _loc3_ = new RewardData(_loc2_);
               _rewardList = _rewardList.concat(_loc3_.outputDisplay);
               _reward.add(_loc3_);
            }
         }
         else
         {
            _reward = new RewardData(param1.reward);
            _rewardList = _reward.outputDisplay;
            _rewardList.sort(_sortReward);
         }
         _requirement = param1.requirement;
         _duration = param1.duration;
         _groupId = param1.groupId;
         _desc_locale_key = param1.desc_locale_key;
         _title_locale_key = param1.title_locale_key;
         if(param1.view)
         {
            _iconClipType = param1.view.iconClipType;
            _iconClip = param1.view.iconClip;
            _dialogType = param1.view.dialogType;
            _dialogClip = param1.view.dialogClip;
         }
      }
      
      public function get desc_locale_key() : String
      {
         return _desc_locale_key;
      }
      
      public function get title_locale_key() : String
      {
         return _title_locale_key;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get bundleHeroReward() : Vector.<BundleHeroReward>
      {
         return _reward.bundleHeroReward;
      }
      
      public function get requirement_teamLevel() : int
      {
         if(_requirement && _requirement.teamLevel)
         {
            return _requirement.teamLevel;
         }
         return 0;
      }
      
      public function get requirement_missionId() : int
      {
         try
         {
            if(_requirement && _requirement.mission)
            {
               var _loc2_:* = _requirement.mission[1].id;
               return _loc2_;
            }
         }
         catch(error:Error)
         {
         }
         return 0;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         if(_rewardList)
         {
            return _rewardList.concat();
         }
         return null;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get iconClipType() : String
      {
         return _iconClipType;
      }
      
      public function get iconClip() : String
      {
         return _iconClip;
      }
      
      public function get dialogType() : String
      {
         return _dialogType;
      }
      
      public function get dialogClip() : String
      {
         return _dialogClip;
      }
      
      public function getRewardList(param1:Player) : Vector.<InventoryItem>
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc4_:Vector.<InventoryItem> = _rewardList.concat();
         var _loc3_:int = _loc4_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc4_[_loc5_] is BundleRewardHeroInventoryItem)
            {
               _loc2_ = _loc4_[_loc5_] as BundleRewardHeroInventoryItem;
               _loc6_ = _loc2_.item as HeroDescription;
               if(_loc2_.bundleHeroReward.type != "skin")
               {
                  if(param1.heroes.getById(_loc6_.id))
                  {
                     _loc4_[_loc5_] = _loc2_.bundleHeroReward.heroFragments;
                  }
               }
            }
            _loc5_++;
         }
         return _loc4_;
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
         if(param1.item == DataStorage.pseudo.STARMONEY)
         {
            _loc2_ = 10000;
         }
         if(param1.item is HeroDescription)
         {
            _loc2_ = 1000;
         }
         if(param1.item is CoinDescription)
         {
            _loc2_ = 500;
         }
         if(param1.item is PseudoResourceDescription)
         {
            _loc2_ = 100;
         }
         return _loc2_;
      }
   }
}
