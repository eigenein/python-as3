package game.mediator.gui.popup.billing
{
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.reward.GuiElementExternalStyle;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class BillingPopupValueObject
   {
       
      
      private var _baseStarmoneyReward:int;
      
      protected var player:Player;
      
      private var _externalStyleFactory:Function;
      
      protected var _desc:PlayerBillingDescription;
      
      private var _productURL:String;
      
      public function BillingPopupValueObject(param1:PlayerBillingDescription, param2:Player)
      {
         super();
         this._desc = param1;
         this.player = param2;
         if(param1)
         {
            _baseStarmoneyReward = param2.billingData.getBasicBillingBySlot(param1.slot).reward.starmoney;
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function set externalStyleFactory(param1:Function) : void
      {
         if(param1.length != 0)
         {
            throw new ArgumentError("Метод должен не иметь аргументов и возвращать объект типа GuiElementExternalStyle");
         }
         _externalStyleFactory = param1;
      }
      
      public function createExternalStyle() : GuiElementExternalStyle
      {
         return !!_externalStyleFactory?_externalStyleFactory():null;
      }
      
      public function get signal_updated() : Signal
      {
         return null;
      }
      
      public function get vipPoints() : int
      {
         return _desc.vipPoints;
      }
      
      public function get isSubscription() : Boolean
      {
         return desc.isSubscription;
      }
      
      public function get isTransfer() : Boolean
      {
         return desc.isTransfer;
      }
      
      public function get subscriptionRewardPerDay() : int
      {
         return desc.subscriptionRewardPerDay;
      }
      
      public function get subscriptionDuration() : int
      {
         return desc.subscriptionDuration;
      }
      
      public function get mainStarmoneyReward() : Number
      {
         return reward.starmoney + floatVipBonusStarmoney;
      }
      
      public function get vipBonusStarmoney() : int
      {
         return roundStarmoney(floatVipBonusStarmoney);
      }
      
      public function get floatVipBonusStarmoney() : Number
      {
         var _loc1_:Number = player.vipLevel.getGemsMultiplyer();
         if(_loc1_ > 1 && reward.starmoney > 0)
         {
            return (_loc1_ - 1) * reward.starmoney;
         }
         return 0;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.rsx.getTexture(_desc.imageTexture,_desc.imageAtlas);
      }
      
      public function get background() : Texture
      {
         return AssetStorage.rsx.getTexture(_desc.backgroundTexture,_desc.imageAtlas);
      }
      
      public function get hasBackground() : Boolean
      {
         return _desc.backgroundTexture;
      }
      
      public function get cost() : String
      {
         return String(desc.cost);
      }
      
      public function get costString() : String
      {
         return desc.costString;
      }
      
      public function get name() : String
      {
         return _desc.name;
      }
      
      public function get dynamicStarmoneyName() : String
      {
         return desc.getDynamicStarmoneyName(int(mainStarmoneyReward));
      }
      
      public function get reward() : RewardData
      {
         return _desc.reward;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _desc.rewardList;
      }
      
      public function get useGoldFrame() : Boolean
      {
         return false;
      }
      
      public function get saleStickerText() : String
      {
         return _desc.localeData.saleValue;
      }
      
      public function get saleStickerDescription() : String
      {
         return _desc.localeData.saleDescription;
      }
      
      public function get orderDuration() : String
      {
         return _desc.localeData.orderDuration;
      }
      
      public function get rewardComment() : String
      {
         return _desc.localeData.rewardComment;
      }
      
      public function get bonusRewardComment() : String
      {
         return _desc.localeData.bonusRewardComment;
      }
      
      public function get desc() : PlayerBillingDescription
      {
         return _desc;
      }
      
      public function get canHaveBonuses() : Boolean
      {
         return true;
      }
      
      public function get baseStarmoneyReward() : int
      {
         return _baseStarmoneyReward;
      }
      
      public function get hasBonuses() : Boolean
      {
         return reward.starmoney != _baseStarmoneyReward;
      }
      
      public function get rewardWithoutBonuses() : int
      {
         var _loc1_:* = 0;
         var _loc2_:Number = player.vipLevel.getGemsMultiplyer();
         if(_loc2_ > 1 && reward.starmoney > 0)
         {
            _loc1_ = Number((_loc2_ - 1) * _baseStarmoneyReward);
         }
         else
         {
            _loc1_ = 0;
         }
         var _loc3_:int = roundStarmoney(_loc1_);
         return _baseStarmoneyReward + _loc3_;
      }
      
      public function get available() : Boolean
      {
         return true;
      }
      
      public function get productURL() : String
      {
         return desc.productURL;
      }
      
      protected function roundStarmoney(param1:Number) : int
      {
         return Math.round(param1 * 100) / 100;
      }
   }
}
