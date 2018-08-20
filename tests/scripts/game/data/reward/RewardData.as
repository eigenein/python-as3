package game.data.reward
{
   import game.data.ResourceListData;
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleHeroReward;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   
   public class RewardData extends ResourceListData
   {
      
      public static const EMPTY_REWARD:RewardData = new RewardData();
       
      
      public var skill_point:int;
      
      public var experience:int;
      
      public var vipPoints:int;
      
      public var clanActivity:int;
      
      public var dungeonActivity:int;
      
      public var playerAvatar:Vector.<PlayerAvatarDescription>;
      
      public var farmSubscription:int;
      
      private var _subscriptions:Vector.<RewardSubscription>;
      
      private var _heroes:Vector.<RewardHero>;
      
      private var _titans:Vector.<RewardTitan>;
      
      private var _heroCards:Vector.<InventoryFragmentItem>;
      
      private var _titanCards:Vector.<InventoryFragmentItem>;
      
      private var _heroExperience:Vector.<RewardHeroExp>;
      
      private var _titanExperience:Vector.<RewardTitanExp>;
      
      private var _bundleHeroReward:Vector.<BundleHeroReward>;
      
      private var _refillables:Vector.<RewardRefillableVO>;
      
      private var _eventBox:Vector.<InventoryItem>;
      
      private var _quizPoints:int;
      
      public function RewardData(param1:Object = null)
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         super(param1);
         if(param1 && param1.bundleHeroReward)
         {
            _bundleHeroReward = new Vector.<BundleHeroReward>();
            var _loc9_:int = 0;
            var _loc8_:* = param1.bundleHeroReward;
            for(var _loc5_ in param1.bundleHeroReward)
            {
               _loc2_ = DataStorage.bundle.getBundleHeroReward(int(_loc5_));
               _bundleHeroReward.push(_loc2_);
            }
         }
         if(param1 && param1.refillable)
         {
            _refillables = new Vector.<RewardRefillableVO>();
            var _loc11_:int = 0;
            var _loc10_:* = param1.refillable;
            for(var _loc7_ in param1.refillable)
            {
               _loc4_ = new RewardRefillableVO();
               _loc4_.id = _loc7_;
               _loc4_.value = param1.refillable[_loc7_];
               _refillables.push(_loc4_);
            }
         }
         if(param1 && param1.avatar)
         {
            playerAvatar = new Vector.<PlayerAvatarDescription>();
            var _loc13_:int = 0;
            var _loc12_:* = param1.avatar;
            for(var _loc3_ in param1.avatar)
            {
               _loc6_ = DataStorage.playerAvatar.getById(_loc3_) as PlayerAvatarDescription;
               playerAvatar.push(_loc6_);
            }
         }
      }
      
      public static function multiplyRawReward(param1:Object, param2:Number) : Object
      {
         return multiplyObjectFieldsRecursive(param1,param2,1);
      }
      
      private static function multiplyObjectFieldsRecursive(param1:Object, param2:Number, param3:int) : Object
      {
         var _loc5_:* = null;
         var _loc4_:Object = {};
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for(var _loc6_ in param1)
         {
            _loc5_ = param1[_loc6_];
            if(_loc5_ is int || _loc5_ is Number)
            {
               _loc4_[_loc6_] = Math.floor(Math.round(int(_loc5_) * param2 * 100) / 100);
            }
            else if(param3 > 0)
            {
               _loc4_[_loc6_] = multiplyObjectFieldsRecursive(_loc5_,param2,param3 - 1);
            }
         }
         return _loc4_;
      }
      
      public function get subscriptions() : Vector.<RewardSubscription>
      {
         return _subscriptions;
      }
      
      public function get heroes() : Vector.<RewardHero>
      {
         return _heroes;
      }
      
      public function get titans() : Vector.<RewardTitan>
      {
         return _titans;
      }
      
      public function get heroCards() : Vector.<InventoryFragmentItem>
      {
         return _heroCards;
      }
      
      public function get titanCards() : Vector.<InventoryFragmentItem>
      {
         return _titanCards;
      }
      
      public function get heroExperience() : Vector.<RewardHeroExp>
      {
         return _heroExperience;
      }
      
      public function get titanExperience() : Vector.<RewardTitanExp>
      {
         return _titanExperience;
      }
      
      public function get bundleHeroReward() : Vector.<BundleHeroReward>
      {
         return _bundleHeroReward;
      }
      
      public function get refillables() : Vector.<RewardRefillableVO>
      {
         return _refillables;
      }
      
      public function get eventBox() : Vector.<InventoryItem>
      {
         return _eventBox;
      }
      
      public function get quizPoints() : int
      {
         return _quizPoints;
      }
      
      override public function get outputDisplay() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Vector.<InventoryItem> = super.outputDisplay;
         if(_eventBox != null)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _eventBox;
            for each(var _loc1_ in _eventBox)
            {
               _loc3_.push(_loc1_);
            }
         }
         if(experience)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.XP,experience));
         }
         if(clanActivity)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.CLAN_ACTIVITY,clanActivity));
         }
         if(dungeonActivity)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.DUNGEON_ACTIVITY,dungeonActivity));
         }
         if(vipPoints)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.VIP,vipPoints));
         }
         if(quizPoints)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.QUIZ_POINT,quizPoints));
         }
         if(heroes != null)
         {
            var _loc10_:int = 0;
            var _loc9_:* = heroes;
            for each(var _loc5_ in heroes)
            {
               _loc3_.push(new InventoryItem(_loc5_.desc,1));
            }
         }
         if(_bundleHeroReward != null)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _bundleHeroReward;
            for each(var _loc4_ in _bundleHeroReward)
            {
               if(_loc4_)
               {
                  _loc3_.push(new BundleRewardHeroInventoryItem(_loc4_));
               }
            }
         }
         if(playerAvatar)
         {
            _loc2_ = playerAvatar.length;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc3_.push(new InventoryItem(playerAvatar[_loc6_],1));
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      override public function toString() : String
      {
         var _loc1_:String = "\n";
         if(heroes && heroes.length)
         {
            _loc1_ = _loc1_ + ("heroes " + heroes + "\n");
         }
         if(heroExperience && heroExperience.length)
         {
            _loc1_ = _loc1_ + ("heroXp " + heroExperience + "\n");
         }
         if(experience)
         {
            _loc1_ = _loc1_ + ("experience " + experience + "\n");
         }
         if(vipPoints)
         {
            _loc1_ = _loc1_ + ("vipPoints " + vipPoints + "\n");
         }
         _loc1_ = _loc1_ + super.toString();
         return _loc1_;
      }
      
      override public function clone() : ResourceListData
      {
         var _loc1_:RewardData = new RewardData();
         _loc1_.experience = experience;
         _loc1_.vipPoints = vipPoints;
         _loc1_.skill_point = skill_point;
         _loc1_.clanActivity = clanActivity;
         _loc1_.dungeonActivity = dungeonActivity;
         _loc1_.farmSubscription = farmSubscription;
         if(_subscriptions)
         {
            _loc1_._subscriptions = _subscriptions.concat();
         }
         if(_heroes)
         {
            _loc1_._heroes = _heroes.concat();
         }
         if(_titans)
         {
            _loc1_._titans = _titans.concat();
         }
         if(_heroCards)
         {
            _loc1_._heroCards = _heroCards.concat();
         }
         if(_titanCards)
         {
            _loc1_._titanCards = _titanCards.concat();
         }
         if(_heroExperience)
         {
            _loc1_._heroExperience = _heroExperience.concat();
         }
         if(_titanExperience)
         {
            _loc1_._titanExperience = _titanExperience.concat();
         }
         if(_bundleHeroReward)
         {
            _loc1_._bundleHeroReward = _bundleHeroReward.concat();
         }
         if(_refillables)
         {
            _loc1_._refillables = _refillables.concat();
         }
         if(_eventBox)
         {
            _loc1_._eventBox = _eventBox.concat();
         }
         if(_quizPoints)
         {
            _loc1_._quizPoints = _quizPoints;
         }
         _loc1_.add(super.clone());
         return _loc1_;
      }
      
      public function addHero(param1:HeroDescription) : void
      {
         if(!_heroes)
         {
            _heroes = new Vector.<RewardHero>();
         }
         _heroes.push(new RewardHero(param1));
      }
      
      public function addTitan(param1:TitanDescription) : void
      {
         if(!_titans)
         {
            _titans = new Vector.<RewardTitan>();
         }
         _titans.push(new RewardTitan(param1));
      }
      
      public function addHeroCard(param1:InventoryFragmentItem) : void
      {
         if(!_heroCards)
         {
            _heroCards = new Vector.<InventoryFragmentItem>();
         }
         _heroCards.push(param1);
      }
      
      public function addTitanCard(param1:InventoryFragmentItem) : void
      {
         if(!_titanCards)
         {
            _titanCards = new Vector.<InventoryFragmentItem>();
         }
         _titanCards.push(param1);
      }
      
      public function addHeroXp(param1:HeroDescription, param2:int) : void
      {
         if(!_heroExperience)
         {
            _heroExperience = new Vector.<RewardHeroExp>();
         }
         var _loc3_:RewardHeroExp = new RewardHeroExp();
         _loc3_.id = param1.id;
         _loc3_.exp = param2;
         _heroExperience.push(_loc3_);
      }
      
      public function addTitanXp(param1:TitanDescription, param2:int) : void
      {
         if(!_titanExperience)
         {
            _titanExperience = new Vector.<RewardTitanExp>();
         }
         var _loc3_:RewardTitanExp = new RewardTitanExp();
         _loc3_.id = param1.id;
         _loc3_.exp = param2;
         _titanExperience.push(_loc3_);
      }
      
      public function addEventBox(param1:Vector.<InventoryItem>) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc8_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(!_eventBox)
         {
            _eventBox = param1.concat();
         }
         else
         {
            _loc6_ = param1.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = param1[_loc4_].item as NYGiftDescription;
               _loc3_ = _eventBox.length;
               _loc8_ = false;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = _eventBox[_loc4_].item as NYGiftDescription;
                  if(_loc2_.id == _loc7_.id)
                  {
                     _loc8_ = true;
                     _eventBox[_loc4_].amount = _eventBox[_loc4_].amount + param1[_loc4_].amount;
                     break;
                  }
                  _loc4_++;
               }
               if(!_loc8_)
               {
                  _eventBox.push(new InventoryItem(_loc7_,param1[_loc4_].amount));
               }
               _loc5_++;
            }
         }
      }
      
      public function addEventBoxRawData(param1:Object) : void
      {
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc7_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(!_eventBox)
         {
            _eventBox = new Vector.<InventoryItem>();
         }
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for(var _loc5_ in param1)
         {
            _loc6_ = DataStorage.nyGifts.getById(int(_loc5_)) as NYGiftDescription;
            _loc3_ = _eventBox.length;
            _loc7_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = _eventBox[_loc4_].item as NYGiftDescription;
               if(_loc2_.id == _loc6_.id)
               {
                  _loc7_ = true;
                  _eventBox[_loc4_].amount = _eventBox[_loc4_].amount + param1[_loc5_];
                  break;
               }
               _loc4_++;
            }
            if(!_loc7_)
            {
               _eventBox.push(new InventoryItem(_loc6_,param1[_loc5_]));
            }
         }
      }
      
      override public function addRawData(param1:Object) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         super.addRawData(param1);
         if(param1.quizPoints)
         {
            _quizPoints = param1.quizPoints;
         }
         if(param1.eventBox)
         {
            addEventBoxRawData(param1.eventBox);
         }
         if(param1.experience)
         {
            experience = experience + param1.experience;
         }
         if(param1.skill_point)
         {
            skill_point = skill_point + param1.skill_point;
         }
         if(param1.clanActivity)
         {
            clanActivity = clanActivity + param1.clanActivity;
         }
         if(param1.dungeonActivity)
         {
            dungeonActivity = dungeonActivity + param1.dungeonActivity;
         }
         if(param1.vipPoints)
         {
            vipPoints = vipPoints + param1.vipPoints;
         }
         if(param1.farmSubscription)
         {
            farmSubscription = int(farmSubscription) + int(param1.farmSubscription);
         }
         if(param1.subscription)
         {
            if(!_subscriptions)
            {
               _subscriptions = new Vector.<RewardSubscription>();
            }
            var _loc6_:int = 0;
            var _loc5_:* = param1.subscription;
            for(var _loc3_ in param1.subscription)
            {
               _subscriptions.push(new RewardSubscription(DataStorage.subscription.getSubscriptionById(_loc3_),param1.subscription[_loc3_]));
            }
         }
         if(param1.heroCard)
         {
            if(!_heroCards)
            {
               _heroCards = new Vector.<InventoryFragmentItem>();
            }
            var _loc8_:int = 0;
            var _loc7_:* = param1.heroCard;
            for(_loc3_ in param1.heroCard)
            {
               _heroCards.push(new InventoryFragmentItem(DataStorage.hero.getUnitById(_loc3_),param1.heroCard[_loc3_]));
            }
         }
         if(param1.titanCard)
         {
            if(!_titanCards)
            {
               _titanCards = new Vector.<InventoryFragmentItem>();
            }
            var _loc10_:int = 0;
            var _loc9_:* = param1.titanCard;
            for(_loc3_ in param1.titanCard)
            {
               _titanCards.push(new InventoryFragmentItem(DataStorage.titan.getTitanById(_loc3_),param1.titanCard[_loc3_]));
            }
         }
         if(param1.hero)
         {
            if(!_heroes)
            {
               _heroes = new Vector.<RewardHero>();
            }
            var _loc12_:int = 0;
            var _loc11_:* = param1.hero;
            for(_loc3_ in param1.hero)
            {
               heroes.push(new RewardHero(DataStorage.hero.getHeroById(_loc3_)));
            }
         }
         if(param1.titan)
         {
            if(!_titans)
            {
               _titans = new Vector.<RewardTitan>();
            }
            var _loc14_:int = 0;
            var _loc13_:* = param1.titan;
            for(_loc3_ in param1.titan)
            {
               titans.push(new RewardTitan(DataStorage.titan.getTitanById(_loc3_)));
            }
         }
         if(param1.heroXp)
         {
            _heroExperience = new Vector.<RewardHeroExp>();
            var _loc16_:int = 0;
            var _loc15_:* = param1.heroXp;
            for(_loc3_ in param1.heroXp)
            {
               _loc4_ = new RewardHeroExp();
               _loc4_.id = _loc3_;
               _loc4_.exp = param1.heroXp[_loc3_];
               _heroExperience.push(_loc4_);
            }
         }
         if(param1.titanXp)
         {
            _titanExperience = new Vector.<RewardTitanExp>();
            var _loc18_:int = 0;
            var _loc17_:* = param1.titanXp;
            for(_loc3_ in param1.titanXp)
            {
               _loc2_ = new RewardTitanExp();
               _loc2_.id = _loc3_;
               _loc2_.exp = param1.titanXp[_loc3_];
               _titanExperience.push(_loc2_);
            }
         }
      }
      
      override public function add(param1:ResourceListData) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:RewardData = param1 as RewardData;
         super.add(param1);
         if(!_loc2_)
         {
            return;
         }
         experience = experience + _loc2_.experience;
         clanActivity = clanActivity + _loc2_.clanActivity;
         dungeonActivity = dungeonActivity + _loc2_.dungeonActivity;
         vipPoints = vipPoints + _loc2_.vipPoints;
         skill_point = skill_point + _loc2_.skill_point;
         farmSubscription = farmSubscription + _loc2_.farmSubscription;
         _quizPoints = _quizPoints + _loc2_.quizPoints;
         if(_loc2_._subscriptions)
         {
            if(_subscriptions)
            {
               _subscriptions.concat(_loc2_._subscriptions);
            }
            else
            {
               _subscriptions = _loc2_._subscriptions.concat();
            }
         }
         if(_loc2_.heroExperience)
         {
            _loc3_ = _loc2_.heroExperience.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = DataStorage.hero.getHeroById(_loc2_.heroExperience[_loc4_].id);
               addHeroXp(_loc5_,_loc2_.heroExperience[_loc4_].exp);
               _loc4_++;
            }
         }
         if(_loc2_.heroes)
         {
            _loc3_ = _loc2_.heroes.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               addHero(_loc2_.heroes[_loc4_].desc);
               _loc4_++;
            }
         }
         if(_loc2_.heroCards)
         {
            _loc3_ = _loc2_.heroCards.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               addHeroCard(_loc2_.heroCards[_loc4_]);
               _loc4_++;
            }
         }
         if(_loc2_.titanCards)
         {
            _loc3_ = _loc2_.titanCards.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               addTitanCard(_loc2_.titanCards[_loc4_]);
               _loc4_++;
            }
         }
         if(_loc2_.bundleHeroReward)
         {
            if(!_bundleHeroReward)
            {
               _bundleHeroReward = new Vector.<BundleHeroReward>();
            }
            _bundleHeroReward = _bundleHeroReward.concat(_loc2_.bundleHeroReward);
         }
         if(_loc2_.refillables)
         {
            if(!_refillables)
            {
               _refillables = new Vector.<RewardRefillableVO>();
            }
            _refillables = _refillables.concat(_loc2_.refillables);
         }
         if(_loc2_.eventBox)
         {
            addEventBox(_loc2_.eventBox);
         }
      }
      
      override protected function _createSplitEntity() : ResourceListData
      {
         return new RewardData();
      }
   }
}
