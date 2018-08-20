package game.mediator.gui.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.Signal;
   
   public class ChestPopupValueObject
   {
       
      
      private var player:Player;
      
      private var refillable:PlayerRefillableEntry;
      
      private var _specialHeroReward:Vector.<ChestRewardPresentationValueObject>;
      
      private var _heroReward:Vector.<ChestRewardPresentationValueObject>;
      
      private var _heroMiscReward:Vector.<ChestRewardPresentationValueObject>;
      
      private var _signal_update:Signal;
      
      private var _availableNextFreeIn:int;
      
      private var _chest:ChestDescription;
      
      public function ChestPopupValueObject(param1:Player, param2:ChestDescription, param3:PlayerRefillableEntry, param4:Vector.<ChestRewardPresentationValueObject>)
      {
         _signal_update = new Signal();
         super();
         this.player = param1;
         this._chest = param2;
         _heroReward = _chest.rewardPresentation.hero;
         _heroMiscReward = param4;
         _specialHeroReward = _chest.rewardPresentation.uniqueHero;
         this.refillable = param3;
         _signal_update = param3.signal_update;
         GameTimer.instance.oneSecTimer.add(handler_gameTimer);
         handler_gameTimer();
      }
      
      public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_gameTimer);
      }
      
      public function get specialHeroReward() : Vector.<ChestRewardPresentationValueObject>
      {
         return _specialHeroReward;
      }
      
      public function get heroReward() : Vector.<ChestRewardPresentationValueObject>
      {
         return _heroReward;
      }
      
      public function get heroMiscReward() : Vector.<ChestRewardPresentationValueObject>
      {
         return _heroMiscReward;
      }
      
      public function get name() : String
      {
         return chest.name;
      }
      
      public function get desc() : String
      {
         return Translate.translate("UI_CHEST_GOLD_DESC");
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get cost_single() : InventoryItem
      {
         return player.specialOffer.costReplace.chestOne(chest).outputDisplay[0];
      }
      
      public function get cost_multi() : InventoryItem
      {
         return player.specialOffer.costReplace.chestPack(chest).outputDisplay[0];
      }
      
      public function get cooldownFormatted() : String
      {
         if(availableFreeNow)
         {
            if(maxFreeCount <= 1)
            {
               return Translate.translate("UI_POPUP_CHEST_FREE_NOW");
            }
            return Translate.translateArgs("UI_POPUP_CHEST_FREE_NOW_AMT",availableFreeToday,maxFreeCount);
         }
         if(availableNextFreeIn > 0)
         {
            return Translate.translateArgs("UI_POPUP_CHEST_UNTIL_FREE",TimeFormatter.toMS2(availableNextFreeIn) + "\n");
         }
         return "";
      }
      
      public function get availableNextFreeIn() : int
      {
         return _availableNextFreeIn;
      }
      
      public function get chest() : ChestDescription
      {
         return _chest;
      }
      
      public function get availableFreeToday() : int
      {
         return refillable.maxRefillCount - refillable.refillCount;
      }
      
      public function get availableFreeNow() : Boolean
      {
         return refillable.value > 0;
      }
      
      public function get maxFreeCount() : int
      {
         return refillable.maxRefillCount;
      }
      
      public function get availableNextFreeAt() : int
      {
         if(availableFreeToday > 0)
         {
            return refillable.lastRefill + refillable.desc.refillSeconds;
         }
         return GameTimer.instance.nextDayTimestamp;
      }
      
      protected function handler_gameTimer() : void
      {
         _availableNextFreeIn = availableNextFreeAt - GameTimer.instance.currentServerTime;
         _signal_update.dispatch();
      }
   }
}
