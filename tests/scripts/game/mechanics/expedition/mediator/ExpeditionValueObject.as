package game.mechanics.expedition.mediator
{
   import engine.core.utils.property.BooleanProperty;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mechanics.expedition.model.PlayerExpeditionEntry;
   import game.mechanics.expedition.storage.ExpeditionSlotDescription;
   import game.mechanics.expedition.storage.ExpeditionStoryDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.subscription.PlayerSubscriptionData;
   import org.osflash.signals.Signal;
   
   public class ExpeditionValueObject
   {
       
      
      private var player:Player;
      
      private var actions:IExpeditionValueObjectActions;
      
      private var _entry:PlayerExpeditionEntry;
      
      public const signal_statusUpdate:Signal = new Signal();
      
      public const signal_timer:Signal = new Signal();
      
      public function ExpeditionValueObject(param1:Player, param2:IExpeditionValueObjectActions, param3:PlayerExpeditionEntry)
      {
         super();
         this.player = param1;
         this.actions = param2;
         this._entry = param3;
         _entry.status.signal_update.add(handler_statusUpdate);
         _entry.readyToFarm.signal_update.add(handler_readyToFarm);
         GameTimer.instance.oneSecTimer.add(handler_oneSecTimer);
         param1.subscription.signal_updated.add(handler_playerSubcriptionUpdated);
      }
      
      public function dispose() : void
      {
         player.subscription.signal_updated.remove(handler_playerSubcriptionUpdated);
         _entry.status.unsubscribe(handler_statusUpdate);
         _entry.readyToFarm.unsubscribe(handler_readyToFarm);
         GameTimer.instance.oneSecTimer.remove(handler_oneSecTimer);
      }
      
      public function get story() : ExpeditionStoryDescription
      {
         return DataStorage.expeditionSlot.getStoryById(_entry.storyId);
      }
      
      public function get entry() : PlayerExpeditionEntry
      {
         return _entry;
      }
      
      public function get rarity() : int
      {
         return _entry.rarity;
      }
      
      public function get attribute_vip() : Boolean
      {
         return DataStorage.expeditionSlot.getById(_entry.slotId).unlockRequirementVipLevel;
      }
      
      public function get attribute_subscription() : Boolean
      {
         return DataStorage.expeditionSlot.getById(_entry.slotId).unlockRequirementSubscription;
      }
      
      public function get name() : String
      {
         return story.name;
      }
      
      public function get duration() : String
      {
         return _entry.duration.toDaysOrHoursAndMinutes;
      }
      
      public function get timeLeft() : String
      {
         return _entry.endTime.toDaysLeftOrHMS;
      }
      
      public function get power() : int
      {
         return _entry.power;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _entry.reward.outputDisplay;
      }
      
      public function get heroes() : Vector.<HeroEntryValueObject>
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc2_:Vector.<HeroEntryValueObject> = new Vector.<HeroEntryValueObject>();
         var _loc6_:int = 0;
         var _loc5_:* = _entry.heroes;
         for each(var _loc3_ in _entry.heroes)
         {
            _loc4_ = DataStorage.hero.getHeroById(_loc3_);
            _loc1_ = player.heroes.getById(_loc3_);
            _loc2_.push(new HeroEntryValueObject(_loc4_,_loc1_));
         }
         return _loc2_;
      }
      
      public function get isInProgress() : Boolean
      {
         return _entry.isInProgress;
      }
      
      public function get isReadyToFarm() : Boolean
      {
         return _entry.isReadyToFarm;
      }
      
      public function get isReadyToStart() : Boolean
      {
         return _entry.isNew && !isLocked;
      }
      
      public function get isFarmed() : Boolean
      {
         return _entry.isFarmed;
      }
      
      public function get heroesAreLocked() : BooleanProperty
      {
         return _entry.heroesAreLocked;
      }
      
      public function get requirementString() : String
      {
         if(!isLocked)
         {
            return "";
         }
         var _loc1_:ExpeditionSlotDescription = DataStorage.expeditionSlot.getById(_entry.slotId);
         if(isLockedByVipLevel)
         {
            return "vip level needed " + _loc1_.unlockVipLevel;
         }
         if(isLockedByTeamLevel)
         {
            return "team level needed " + _loc1_.unlockTeamLevel;
         }
         if(isLockedBySubscription)
         {
            return "subscription needed";
         }
         return "locked";
      }
      
      public function get isLockedByVipLevel() : Boolean
      {
         return desc && desc.unlockRequirementVipLevel && player.vipLevel.level < desc.unlockVipLevel;
      }
      
      public function get isLockedByTeamLevel() : Boolean
      {
         return desc && desc.unlockRequirementTeamLevel && player.levelData.level.level < desc.unlockTeamLevel;
      }
      
      public function get isLockedBySubscription() : Boolean
      {
         return desc && desc.unlockRequirementSubscription && !player.subscription.subscriptionInfo.isActive;
      }
      
      public function get isLocked() : Boolean
      {
         if(!_entry.isNew)
         {
            return false;
         }
         return isLockedByVipLevel || isLockedByTeamLevel || isLockedBySubscription;
      }
      
      public function get storyDesc_unitId() : int
      {
         return !!story?story.unitId:0;
      }
      
      public function get storyDesc_assetScale() : Number
      {
         return !!story?story.assetScale:1;
      }
      
      public function get teamLevel() : int
      {
         return !!desc?desc.unlockTeamLevel:0;
      }
      
      public function get vipLevel() : int
      {
         return !!desc?desc.unlockVipLevel:0;
      }
      
      public function action_start() : void
      {
         actions.action_start(this);
      }
      
      public function action_farm() : void
      {
         actions.action_farm(this);
      }
      
      private function get desc() : ExpeditionSlotDescription
      {
         return DataStorage.expeditionSlot.getById(_entry.slotId);
      }
      
      private function handler_statusUpdate(param1:int) : void
      {
         signal_statusUpdate.dispatch();
      }
      
      private function handler_readyToFarm(param1:Boolean) : void
      {
         signal_statusUpdate.dispatch();
      }
      
      private function handler_oneSecTimer() : void
      {
         signal_timer.dispatch();
      }
      
      private function handler_playerSubcriptionUpdated(param1:PlayerSubscriptionData) : void
      {
         signal_statusUpdate.dispatch();
      }
   }
}
