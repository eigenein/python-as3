package game.model.user.specialoffer
{
   import engine.core.utils.property.PropertyStream;
   import flash.utils.Dictionary;
   import game.command.rpc.CommandResultSpecialOfferUpdateData;
   import game.command.rpc.RPCCommandBase;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class PlayerSpecialOfferData
   {
       
      
      private var player:Player;
      
      private var entries:Vector.<PlayerSpecialOfferEntry>;
      
      private const registeredTypes:Dictionary = new Dictionary();
      
      public const mainScreenIcons:SpecialOfferIconCollection = new SpecialOfferIconCollection(this);
      
      public const zeppelingIcons:SpecialOfferIconCollection = new SpecialOfferIconCollection(this);
      
      public const signal_updated:Signal = new Signal();
      
      public const autoPopupStream:PropertyStream = new PropertyStream(AutoPopupQueueEntry);
      
      public const hooks:PlayerSpecialOfferHooks = new PlayerSpecialOfferHooks();
      
      public const costReplace:PlayerSpecialOfferCostReplaceData = new PlayerSpecialOfferCostReplaceData();
      
      private var _mergebonusEndTime:Number;
      
      public function PlayerSpecialOfferData(param1:Player)
      {
         entries = new Vector.<PlayerSpecialOfferEntry>();
         super();
         this.player = param1;
         registeredTypes["energySpent"] = PlayerSpecialOfferEnergySpent;
         registeredTypes["energySpentWithoutTimer"] = PlayerSpecialOfferEnergySpentWithoutTimer;
         registeredTypes["energySpentEventDrop"] = PlayerSpecialOfferEnergySpentEventDrop;
         registeredTypes["rewardModifier"] = PlayerSpecialOfferRewardModifier;
         registeredTypes["paymentRepeat"] = PlayerSpecialOfferPaymentRepeatWithTimer;
         registeredTypes["nextPaymentReward"] = PlayerNextPaymentRewardSpecialOffer;
         registeredTypes["paymentRepeatInfinite"] = PlayerSpecialOfferPaymentRepeatNoTimer;
         registeredTypes["paymentRepeatWelcomeBackBonuses"] = PlayerSpecialOfferPaymentRepeatWelcomeBackBonuses;
         registeredTypes[PlayerSpecialOfferBundleCarousel.OFFER_TYPE] = PlayerSpecialOfferBundleCarousel;
         registeredTypes["costReplaceTownChestPack"] = PlayerSpecialOfferCostReplaceTownChestPack;
         registeredTypes["bundleReward"] = PlayerSpecialOfferBundleReward;
         registeredTypes["newYear2016Tree"] = PlayerSpecialOfferNewYear;
         registeredTypes["sideBarIcon"] = PlayerSpecialOfferWithSideBarIcon;
         registeredTypes["sideBarIcon_tripleSkinBundle"] = PlayerSpecialOfferTripleSkinBundle;
         registeredTypes["dailyReward"] = PlayerSpecialOfferDailyReward;
         registeredTypes["sideBarIcon_birthday2016_billing"] = PlayerSpecialOfferWithSideBarIcon_BirthdayBilling;
         registeredTypes["threeBoxes"] = PlayerSpecialOfferThreeBoxes;
         registeredTypes["heroChoice"] = PlayerSpecialOfferHeroChoice;
         registeredTypes["lootBoxWithDelay"] = PlayerSpecialOfferLootBoxWithDelay;
         registeredTypes["welcomeBack"] = PlayerSpecialOfferWelcomeBack;
         registeredTypes["halloween2k17secretReward"] = PlayerSpecialOfferHalloween2k17secretReward;
         registeredTypes["blackFriday2017"] = PlayerSpecialOfferBlackFriday2017;
         registeredTypes["subscriptionBundle"] = PlayerSpecialOfferSubscriptionBundle;
         registeredTypes["newYear2018"] = PlayerSpecialOfferNewYear2018;
         registeredTypes["newYear2018gifts"] = PlayerSpecialOfferNewYear2018Gifts;
         registeredTypes["multibundleBlackFriday2017SkinCoins"] = PlayerSpecialOfferMultiBundleCyberMonday2017;
         registeredTypes["bundle"] = PlayerSpecialOfferBundle;
         registeredTypes["costReplaceAllChests"] = PlayerSpecialOfferCostReplaceAllChests;
         registeredTypes["ny2k18secretReward"] = NY2018SecretRewardOffer;
      }
      
      public function get unsafeList() : Vector.<PlayerSpecialOfferEntry>
      {
         return entries;
      }
      
      public function get mergebonusEndTime() : Number
      {
         return _mergebonusEndTime;
      }
      
      public function set mergebonusEndTime(param1:Number) : void
      {
         _mergebonusEndTime = param1;
      }
      
      public function init(param1:*) : void
      {
         updateOffersFromRawArray(param1);
      }
      
      public function reset(param1:*) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function onRpc_update(param1:RPCCommandBase) : void
      {
         var _loc3_:* = false;
         var _loc5_:Boolean = false;
         var _loc2_:* = null;
         if(param1.result.specialOfferUpdates)
         {
            _loc3_ = false;
            _loc5_ = false;
            _loc2_ = param1.result.specialOfferUpdates;
            _loc5_ = updateOffersFromRawArray(_loc2_.updated);
            var _loc7_:int = 0;
            var _loc6_:* = _loc2_.ended;
            for each(var _loc4_ in _loc2_.ended)
            {
               if(!_loc3_)
               {
                  _loc3_ = removeOffer(_loc4_);
               }
            }
            if(_loc3_ || _loc5_)
            {
               signal_updated.dispatch();
            }
         }
      }
      
      public function hasSpecialOffer(param1:String) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getSpecialOffer(param1:String) : PlayerSpecialOfferEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getSpecialOfferById(param1:int) : PlayerSpecialOfferEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      function specialOfferEnded(param1:PlayerSpecialOfferEntry) : void
      {
         if(removeOffer(param1.id))
         {
            signal_updated.dispatch();
         }
      }
      
      function invalidateBillings() : void
      {
         player.billingData.signal_updated.dispatch(player.billingData);
      }
      
      function addAutoPopup(param1:AutoPopupQueueEntry) : void
      {
         autoPopupStream.dispatch(param1);
      }
      
      function addViewSlotEntry(param1:SpecialOfferViewSlotEntry) : void
      {
         hooks.addViewSlotEntry(param1);
      }
      
      protected function hasOfferType(param1:Object) : Boolean
      {
         if(param1 && param1.offerType)
         {
            return registeredTypes[param1.offerType];
         }
         return false;
      }
      
      protected function addOffer(param1:*) : void
      {
         if(param1.billings)
         {
            player.billingData.add(param1);
         }
         var _loc4_:String = param1.offerType;
         var _loc3_:Class = registeredTypes[_loc4_];
         var _loc2_:PlayerSpecialOfferEntry = new _loc3_(player,param1);
         entries.push(_loc2_);
         _loc2_.start(this);
      }
      
      function getOffer(param1:int) : PlayerSpecialOfferEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function removeOffer(param1:int) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateOffersFromRawArray(param1:Array) : Boolean
      {
         var _loc2_:* = null;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_ = getOffer(_loc3_.id);
            if(_loc2_)
            {
               _loc2_.updateExisting(_loc3_);
            }
            else if(hasOfferType(_loc3_))
            {
               addOffer(_loc3_);
               _loc4_ = true;
            }
         }
         return true;
      }
   }
}
