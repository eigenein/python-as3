package game.mediator.gui.popup.billing.specialoffer
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.InventoryItemSortOrder;
   import org.osflash.signals.ISignal;
   import org.osflash.signals.Signal;
   
   public class MultiBundleOfferValueObject
   {
       
      
      private var _id:int;
      
      private var _reward:Vector.<InventoryItem>;
      
      private var _billingVO:BillingPopupValueObject;
      
      private var _oldPrice:String;
      
      private var _signal_buy:Signal;
      
      private var _discountValue:int = 50;
      
      private var _isBought:BooleanPropertyWriteable;
      
      public function MultiBundleOfferValueObject(param1:Object, param2:BillingPopupValueObject)
      {
         _signal_buy = new Signal(MultiBundleOfferValueObject);
         _isBought = new BooleanPropertyWriteable();
         super();
         _billingVO = param2;
         _isBought.setValueSilently(param1.id == 707);
         parseRawData(param1);
      }
      
      public function get billingVO() : BillingPopupValueObject
      {
         return _billingVO;
      }
      
      public function set billingVO(param1:BillingPopupValueObject) : void
      {
         _billingVO = param1;
      }
      
      public function get signal_buy() : ISignal
      {
         return _signal_buy;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get oldPrice() : String
      {
         if(!_billingVO)
         {
            return "";
         }
         var _loc3_:String = _billingVO.costString;
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Number = _loc2_[0];
         _loc1_ = _loc1_ * (100 / (100 - _discountValue));
         if(Math.round(_loc1_) != _loc1_)
         {
            return _loc1_.toFixed(2) + " " + _loc2_[1];
         }
         return _loc1_ + " " + _loc2_[1];
      }
      
      public function get costStrng() : String
      {
         return !!_billingVO?_billingVO.costString:"";
      }
      
      public function get discountValue() : int
      {
         return _discountValue;
      }
      
      public function get isBought() : BooleanProperty
      {
         return _isBought;
      }
      
      public function parseRawData(param1:Object) : void
      {
         _id = param1.id;
         _reward = new Vector.<InventoryItem>();
         var _loc2_:InventoryItemSortOrder = new InventoryItemSortOrder(!!param1.sortOrder?param1.sortOrder:[]);
         _reward = _loc2_.sortReward(_billingVO.reward);
      }
      
      public function setBought(param1:Boolean) : void
      {
         _isBought.value = param1;
      }
   }
}
