package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.CommandOfferFarmReward;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.overlay.offer.SpecialOfferClipButton;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.specialoffer.lootboxwithdelay.SpecialOfferLootBoxWithDelayPopupMediator;
   import game.view.specialoffer.lootboxwithdelay.SpecialOfferLootBoxWithDelaySideBarIcon;
   
   public class PlayerSpecialOfferLootBoxWithDelay extends PlayerSpecialOfferEntry implements ISpecialOfferSideBarIconFactory
   {
      
      public static const OFFER_TYPE:String = "lootBoxWithDelay";
       
      
      private var autoPopupQueueEntry:AutoPopupQueueEntry;
      
      private var delay:PlayerDeferredEvent;
      
      private var endTime:PlayerDeferredEvent;
      
      private var _popupAsset:AssetClipLink;
      
      private var _isReady:BooleanPropertyWriteable;
      
      private var _isOpen:BooleanPropertyWriteable;
      
      private var _commandFarm:CommandOfferFarmReward;
      
      public function PlayerSpecialOfferLootBoxWithDelay(param1:Player, param2:Object)
      {
         autoPopupQueueEntry = new AutoPopupQueueEntry(4);
         delay = new PlayerDeferredEvent();
         endTime = new PlayerDeferredEvent();
         _isReady = new BooleanPropertyWriteable(false);
         _isOpen = new BooleanPropertyWriteable(false);
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_autoPopupOpen);
      }
      
      public function get title() : String
      {
         return Translate.translate(clientData.locale.title);
      }
      
      public function get fullDuration() : int
      {
         return offerData.timeDelay;
      }
      
      public function get timeToOpenString() : String
      {
         return delay.toHMS;
      }
      
      public function get popupAsset() : AssetClipLink
      {
         return _popupAsset;
      }
      
      public function get isReady() : BooleanProperty
      {
         return _isReady;
      }
      
      public function get isOpen() : BooleanProperty
      {
         return _isOpen;
      }
      
      public function get showEndTimeTimer() : Boolean
      {
         return endTime.timeLeft < 86400;
      }
      
      public function get timeToEndString() : String
      {
         return endTime.toHMS;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         delay.signal_complete.add(handler_delayComplete);
         endTime.signal_complete.add(handler_endTimeComplete);
         _sideBarIcon.signal_click.add(handler_sideBarIconClick);
         if(isReady.value)
         {
            param1.addAutoPopup(autoPopupQueueEntry);
         }
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
         delay.signal_complete.remove(handler_delayComplete);
         endTime.signal_complete.remove(handler_endTimeComplete);
      }
      
      public function action_open() : void
      {
         if(!_commandFarm)
         {
            _commandFarm = GameModel.instance.actionManager.playerCommands.specialOfferFarmReward(id);
            _commandFarm.onClientExecute(handler_commandReward);
         }
      }
      
      public function action_collect() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         if(_commandFarm)
         {
            _commandFarm.farmReward(player);
            _loc3_ = new HeroBundleRewardPopupDescription();
            _loc3_.title = title;
            _loc3_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
            _loc3_.description = "";
            _loc2_ = _commandFarm.reward.outputDisplay;
            _loc3_.reward = _loc2_;
            _loc3_.skinCoinSortWeight = 500;
            _loc1_ = new HeroBundleRewardPopup(_loc3_);
            _loc1_.open();
         }
         player.specialOffer.specialOfferEnded(this);
      }
      
      public function createSideBarIcon() : SpecialOfferClipButton
      {
         return new SpecialOfferLootBoxWithDelaySideBarIcon();
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         delay.setEndTime(param1.delayEndTime);
         endTime.setEndTime(param1.endTime);
         _popupAsset = new AssetClipLink(AssetStorage.rsx.getByName(clientData.assetIdent),clientData.assetClip);
         if(delay.hasPassed)
         {
            _isReady.value = true;
         }
      }
      
      private function handler_autoPopupOpen(param1:PopupStashEventParams) : void
      {
         new SpecialOfferLootBoxWithDelayPopupMediator(player,this).open(param1);
      }
      
      private function handler_sideBarIconClick(param1:PopupStashEventParams) : void
      {
         new SpecialOfferLootBoxWithDelayPopupMediator(player,this).open(param1);
      }
      
      private function handler_commandReward(param1:CommandOfferFarmReward) : void
      {
         _isOpen.value = true;
         _commandFarm = param1;
      }
      
      private function handler_delayComplete() : void
      {
         _isReady.value = true;
      }
      
      private function handler_endTimeComplete() : void
      {
         player.specialOffer.specialOfferEnded(this);
      }
   }
}
