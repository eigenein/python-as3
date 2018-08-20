package game.model.user.specialoffer
{
   import com.progrestar.common.Logger;
   import flash.utils.getDefinitionByName;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.view.specialoffer.SpecialOfferSaleIconView;
   import game.view.specialoffer.SpecialOfferTextView;
   import game.view.specialoffer.energyspent.SpecialOfferInventoryIconWithTimerAndArrow;
   import game.view.specialoffer.paymentrepeat.SpecialOfferPaymentRepeatResourcePanelView;
   
   public class SpecialOfferViewSlotEntry extends ViewSlotEntry
   {
       
      
      private var offer:PlayerSpecialOfferEntry;
      
      public function SpecialOfferViewSlotEntry(param1:PlayerSpecialOfferEntry, param2:Object)
      {
         super(param2);
         if(param1 != null)
         {
            this.offer = param1;
            this.offer.signal_removed.add(handler_removed);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(offer)
         {
            offer.signal_removed.remove(handler_removed);
         }
      }
      
      override public function createObject() : ISpecialOfferViewSlotObject
      {
         var _loc1_:* = null;
         var _loc2_:ISpecialOfferViewSlotObject = null;
         var _loc5_:* = viewDescription.type;
         if("SpecialOfferInventoryIconWithTimerAndArrow" !== _loc5_)
         {
            if("SpecialOfferPaymentRepeatResourcePanelView" !== _loc5_)
            {
               if("SpecialOfferSaleIconView" !== _loc5_)
               {
                  if("SpecialOfferTextView" !== _loc5_)
                  {
                     try
                     {
                        _loc1_ = getDefinitionByName("game.view.specialoffer." + viewDescription.type) as Class;
                        _loc2_ = new _loc1_(offer,this) as ISpecialOfferViewSlotObject;
                     }
                     catch(e:Error)
                     {
                        Logger.getLogger(SpecialOfferViewSlotEntry).error(e);
                        trace("SpecialOfferSlotQueueEntry.createObject",e);
                     }
                  }
                  else
                  {
                     _loc2_ = new SpecialOfferTextView(offer as PlayerSpecialOfferWithTimer,this);
                  }
               }
               else
               {
                  _loc2_ = new SpecialOfferSaleIconView(offer as PlayerSpecialOfferWithTimer,this);
               }
            }
            else
            {
               _loc2_ = new SpecialOfferPaymentRepeatResourcePanelView(offer as PlayerSpecialOfferWithTimer,this);
            }
         }
         else
         {
            _loc2_ = new SpecialOfferInventoryIconWithTimerAndArrow(offer as PlayerSpecialOfferWithTimer,this);
         }
         return _loc2_;
      }
      
      private function handler_removed() : void
      {
         signal_removed.dispatch(this);
      }
   }
}
