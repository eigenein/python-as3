package game.model.user.billing
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.RewardData;
   import game.data.reward.RewardSubscription;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItem;
   
   public class PlayerBillingDescription
   {
      
      public static const TYPE_SERVERTRANSFER:String = "serverTransfer";
      
      public static const TYPE_NONPAYER_ONETIME:String = "nonPayerOneTime";
      
      public static const TYPE_SKIN:String = "skin";
       
      
      private var _libName:String;
      
      public const localeData:PlayerBillingLocaleData = new PlayerBillingLocaleData();
      
      private var _productId:String;
      
      private var _vipPoints:int;
      
      private var _id:int;
      
      private var _cost:int;
      
      private var _type:String;
      
      private var _rewardList:Vector.<InventoryItem>;
      
      private var _reward:RewardData;
      
      private var _imageAtlas:String;
      
      private var _imageTexture:String;
      
      private var _backgroundTexture:String;
      
      private var _slot:int;
      
      private var _priority:int;
      
      private var _inSlotPriority:int;
      
      private var _name:String;
      
      private var _isSubscription:Boolean;
      
      private var _isTransfer:Boolean;
      
      private var _costString:String;
      
      private var _productURL:String;
      
      private var _bundleId:int;
      
      private var _subscriptionId:int;
      
      public function PlayerBillingDescription(param1:Object)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         super();
         _id = param1.id;
         _cost = param1.cost;
         _imageAtlas = param1.imageAtlas;
         _imageTexture = param1.imageTexture;
         _backgroundTexture = param1.backgroundTexture;
         _libName = param1.name;
         _isSubscription = param1.reward.subscription != null;
         _isTransfer = param1.type == "serverTransfer";
         var _loc3_:Boolean = true;
         var _loc8_:int = 0;
         var _loc7_:* = param1.reward;
         for(var _loc6_ in param1.reward)
         {
            if(isNaN(Number(_loc6_)))
            {
               _loc3_ = false;
            }
         }
         if(_loc3_)
         {
            _reward = new RewardData();
            _rewardList = new Vector.<InventoryItem>();
            _loc4_ = param1.reward.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = new RewardData(param1.reward[_loc5_]);
               _rewardList = _rewardList.concat(_loc2_.outputDisplay);
               _reward.add(_loc2_);
               _loc5_++;
            }
         }
         else
         {
            _reward = new RewardData(param1.reward);
         }
         _type = param1.type;
         _vipPoints = param1.vipPoints;
         _productId = param1.productId;
         _slot = param1.slot;
         _priority = param1.priority;
         _inSlotPriority = param1.inSlotPriority;
         _productURL = param1.url;
         _bundleId = param1.bundleId;
         _subscriptionId = param1.subscriptionId;
         if(param1 && param1.costString)
         {
            _costString = param1.costString;
         }
         if(param1 && param1.localeData)
         {
            if(param1.localeData.saleValue)
            {
               localeData.saleValue = Translate.translate(param1.localeData.saleValue);
            }
            if(param1.localeData.saleDescription)
            {
               localeData.saleDescription = Translate.translate(param1.localeData.saleDescription);
            }
            if(param1.localeData.rewardComment)
            {
               localeData.rewardComment = Translate.translate(param1.localeData.rewardComment);
            }
            if(param1.localeData.bonusRewardComment)
            {
               localeData.bonusRewardComment = Translate.translate(param1.localeData.bonusRewardComment);
            }
            if(param1.localeData.orderDuration)
            {
               if(_isSubscription)
               {
                  localeData.orderDuration = Translate.translateArgs(param1.localeData.orderDuration,subscriptionDuration);
               }
               else
               {
                  localeData.orderDuration = Translate.translate(param1.localeData.orderDuration);
               }
            }
         }
      }
      
      public function get productId() : String
      {
         return _productId;
      }
      
      public function get vipPoints() : int
      {
         return _vipPoints;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get cost() : int
      {
         return _cost;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get imageAtlas() : String
      {
         return _imageAtlas;
      }
      
      public function get imageTexture() : String
      {
         return _imageTexture;
      }
      
      public function get backgroundTexture() : String
      {
         return _backgroundTexture;
      }
      
      public function get slot() : int
      {
         return _slot;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get inSlotPriority() : int
      {
         return _inSlotPriority;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isSubscription() : Boolean
      {
         return _isSubscription;
      }
      
      public function get isTransfer() : Boolean
      {
         return _isTransfer;
      }
      
      public function get costString() : String
      {
         if(_costString)
         {
            return _costString;
         }
         return GameModel.instance.context.platformFacade.billingCurrencyTranslate(_cost);
      }
      
      public function get subscriptionRewardPerDay() : int
      {
         var _loc1_:Vector.<RewardSubscription> = _reward.subscriptions;
         if(_loc1_ && _loc1_.length)
         {
            return _loc1_[0].subscription.dailyReward.starmoney;
         }
         return 0;
      }
      
      public function get subscriptionDuration() : int
      {
         var _loc1_:Vector.<RewardSubscription> = _reward.subscriptions;
         if(_loc1_ && _loc1_.length)
         {
            return _loc1_[0].subscription.duration;
         }
         return 0;
      }
      
      public function get productURL() : String
      {
         return _productURL;
      }
      
      public function get bundleId() : int
      {
         return _bundleId;
      }
      
      public function get subscriptionId() : int
      {
         return _subscriptionId;
      }
      
      public function applyLocale() : void
      {
         var _loc1_:int = _reward.starmoney;
         if(_libName)
         {
            _name = Translate.translateArgs(_libName,_loc1_);
         }
         else
         {
            _name = Translate.translateArgs("BILLING_NAME_" + _type.toUpperCase(),_loc1_);
         }
      }
      
      public function getDynamicStarmoneyName(param1:int) : String
      {
         if(_libName)
         {
            return Translate.translateArgs(_libName,param1);
         }
         return Translate.translateArgs("BILLING_NAME_" + _type.toUpperCase(),param1);
      }
   }
}

class PlayerBillingLocaleData
{
    
   
   public var saleValue:String;
   
   public var saleDescription:String;
   
   public var rewardComment:String;
   
   public var bonusRewardComment:String;
   
   public var orderDuration:String;
   
   function PlayerBillingLocaleData()
   {
      super();
   }
}
