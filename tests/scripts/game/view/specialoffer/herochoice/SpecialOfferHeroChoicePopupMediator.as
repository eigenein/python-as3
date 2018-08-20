package game.view.specialoffer.herochoice
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferHeroChoice;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class SpecialOfferHeroChoicePopupMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferHeroChoice;
      
      private var _timerString:StringPropertyWriteable;
      
      public function SpecialOfferHeroChoicePopupMediator(param1:Player, param2:PlayerSpecialOfferHeroChoice)
      {
         _timerString = new StringPropertyWriteable();
         super(param1);
         this.offer = param2;
         handler_timer();
         GameTimer.instance.oneSecTimer.add(handler_timer);
         param2.signal_paymentConfirm.add(handler_paymentConfirm);
         param2.signal_removed.add(handler_removed);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         offer.signal_removed.remove(handler_removed);
         offer.signal_paymentConfirm.remove(handler_paymentConfirm);
      }
      
      public function get title() : String
      {
         return offer.title;
      }
      
      public function get description() : String
      {
         return offer.description;
      }
      
      public function get costString() : String
      {
         return offer.costString;
      }
      
      public function get selectedHero() : ObjectProperty
      {
         return offer.selectedHero;
      }
      
      public function get defaultUnknownHero() : UnitDescription
      {
         return offer.defaultUnknownHero;
      }
      
      public function get timerString() : StringProperty
      {
         return _timerString;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return offer.reward;
      }
      
      public function get heroFramgentsCount() : int
      {
         return offer.heroFramgentsCount;
      }
      
      public function get oldPrice() : String
      {
         var _loc3_:String = offer.costString;
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Number = _loc2_[0];
         _loc1_ = _loc1_ * (100 / (100 - discountValue));
         if(Math.round(_loc1_) != _loc1_)
         {
            return _loc1_.toFixed(2) + " " + _loc2_[1];
         }
         return _loc1_ + " " + _loc2_[1];
      }
      
      public function get discountValue() : int
      {
         return offer.discountPercent;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferHeroChoicePopup(this);
         return new SpecialOfferHeroChoicePopup(this);
      }
      
      public function action_buy() : void
      {
         offer.action_buy();
      }
      
      public function action_select() : void
      {
         offer.action_openSelectionPopup(Stash.click("selectHero",_popup.stashParams));
      }
      
      private function handler_timer() : void
      {
         _timerString.value = offer.timerString;
      }
      
      private function handler_paymentConfirm() : void
      {
         if(!disposed && player)
         {
            close();
         }
      }
      
      private function handler_removed() : void
      {
         close();
      }
   }
}
