package game.view.specialoffer.lootboxwithdelay
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.assets.battle.AssetClipLink;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBoxWithDelay;
   import game.view.popup.PopupBase;
   
   public class SpecialOfferLootBoxWithDelayPopupMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferLootBoxWithDelay;
      
      private var _timeLeftString:StringPropertyWriteable;
      
      public function SpecialOfferLootBoxWithDelayPopupMediator(param1:Player, param2:PlayerSpecialOfferLootBoxWithDelay)
      {
         _timeLeftString = new StringPropertyWriteable();
         super(param1);
         this.offer = param2;
         GameTimer.instance.oneSecTimer.add(handler_timer);
         handler_timer();
         param2.signal_removed.add(handler_removed);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         offer.signal_removed.remove(handler_removed);
      }
      
      public function get timeLeftString() : StringProperty
      {
         return _timeLeftString;
      }
      
      public function get asset() : AssetClipLink
      {
         return offer.popupAsset;
      }
      
      public function get isOpen() : BooleanProperty
      {
         return offer.isOpen;
      }
      
      public function get isReady() : BooleanProperty
      {
         return offer.isReady;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferLootBoxWithDelayPopup(this);
         return new SpecialOfferLootBoxWithDelayPopup(this);
      }
      
      public function action_open() : void
      {
         offer.action_open();
      }
      
      public function action_continue() : void
      {
         close();
      }
      
      public function action_chestIsOpen() : void
      {
         offer.action_collect();
         close();
      }
      
      private function handler_removed() : void
      {
         close();
      }
      
      private function handler_timer() : void
      {
         _timeLeftString.value = offer.timeToOpenString;
      }
   }
}
