package game.mediator.gui.component
{
   import game.data.reward.RewardData;
   import game.data.reward.RewardTitan;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class RewardValueObjectList
   {
       
      
      protected var _rewards:Vector.<RewardData>;
      
      protected var _merged:RewardData;
      
      protected var _rewardValueObjectList:Vector.<RewardValueObject>;
      
      protected var _hasShardedHeroes:Boolean;
      
      protected var _hasHeroes:Boolean;
      
      protected var _hasShardedTitans:Boolean;
      
      protected var _hasTitans:Boolean;
      
      protected var _rewardList:Vector.<InventoryItem>;
      
      protected var _rewardTitans:Vector.<RewardTitan>;
      
      protected var _heroExperience:Vector.<RewardHeroExpValueObject>;
      
      public function RewardValueObjectList(param1:Vector.<RewardData>)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         super();
         this._rewards = param1;
         _merged = new RewardData();
         _rewardList = new Vector.<InventoryItem>();
         _rewardTitans = new Vector.<RewardTitan>();
         createValueObjectList();
         if(_merged.heroExperience)
         {
            _heroExperience = new Vector.<RewardHeroExpValueObject>();
            _loc2_ = _merged.heroExperience.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = DataStorage.hero.getHeroById(_merged.heroExperience[_loc3_].id);
               _heroExperience[_loc3_] = new RewardHeroExpValueObject(_loc4_,_merged.heroExperience[_loc3_].exp);
               _loc3_++;
            }
         }
      }
      
      public function get rewardValueObjectList() : Vector.<RewardValueObject>
      {
         return _rewardValueObjectList;
      }
      
      public function get hasShardedHeroes() : Boolean
      {
         return _hasShardedHeroes;
      }
      
      public function get hasHeroes() : Boolean
      {
         return _hasHeroes;
      }
      
      public function get hasShardedTitans() : Boolean
      {
         return _hasShardedTitans;
      }
      
      public function get hasTitans() : Boolean
      {
         return _hasTitans;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      public function get rewardTitans() : Vector.<RewardTitan>
      {
         return _rewardTitans;
      }
      
      public function get heroExperience() : Vector.<RewardHeroExpValueObject>
      {
         return _heroExperience;
      }
      
      protected function createValueObjectList() : void
      {
         _rewardValueObjectList = new Vector.<RewardValueObject>();
         var _loc3_:int = 0;
         var _loc2_:* = _rewards;
         for each(var _loc1_ in _rewards)
         {
            if(_loc1_.heroCards && _loc1_.heroCards.length)
            {
               _hasShardedHeroes = true;
            }
            if(_loc1_.heroes && _loc1_.heroes.length)
            {
               _hasHeroes = true;
            }
            if(_loc1_.titanCards && _loc1_.titanCards.length)
            {
               _hasShardedTitans = true;
            }
            if(_loc1_.titans && _loc1_.titans.length)
            {
               _rewardTitans = _rewardTitans.concat(_loc1_.titans);
               _hasTitans = true;
            }
            _merged.add(_loc1_);
            _rewardList = _rewardList.concat(_loc1_.outputDisplay);
            _rewardValueObjectList.push(new RewardValueObject(_loc1_));
         }
      }
   }
}
