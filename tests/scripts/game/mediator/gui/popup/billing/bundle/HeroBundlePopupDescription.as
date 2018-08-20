package game.mediator.gui.popup.billing.bundle
{
   import game.data.reward.RewardData;
   import org.osflash.signals.Signal;
   
   public class HeroBundlePopupDescription
   {
       
      
      public var reward:RewardData;
      
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
      
      public const signal_click:Signal = new Signal();
      
      public function HeroBundlePopupDescription()
      {
         super();
      }
   }
}
