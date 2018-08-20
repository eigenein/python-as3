package game.mediator.gui.popup.billing.bundle
{
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.user.inventory.InventoryItem;
   import org.osflash.signals.Signal;
   
   public class ResourceBundleSpecialofferDescription
   {
       
      
      public var rewardList:Vector.<InventoryItem>;
      
      public var title:String;
      
      public var description:String;
      
      public var signal_removed:Signal;
      
      public var signal_updateTimeLeft:Signal;
      
      public var timeLeftMethod:Function;
      
      public var stashWindowName:String;
      
      public var price:String;
      
      public var oldPrice:String;
      
      public var buttonLabel:String;
      
      public var discountValue:int;
      
      public var PopupClass:Class;
      
      public var offerId:int;
      
      public var billing:BillingPopupValueObject;
      
      public const signal_click:Signal = new Signal();
      
      public function ResourceBundleSpecialofferDescription()
      {
         super();
      }
   }
}
