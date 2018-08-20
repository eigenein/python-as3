package game.view.gui.overlay.offer
{
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.specialoffer.SpecialOfferIconCollection;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.stat.Stash;
   import org.osflash.signals.ISignal;
   import org.osflash.signals.Signal;
   
   public class SpecialOfferSideBarMediatorBase
   {
       
      
      protected var player:Player;
      
      protected var icons:SpecialOfferIconCollection;
      
      protected var specialShopMerchant:SpecialShopMerchant;
      
      protected var stashEventParams:PopupStashEventParams;
      
      private var _panel:SpecialOfferSideBarBase;
      
      private const _signal_update:Signal = new Signal();
      
      public function SpecialOfferSideBarMediatorBase(param1:Player, param2:SpecialOfferIconCollection, param3:String)
      {
         super();
         this.player = param1;
         this.icons = param2;
         stashEventParams = new PopupStashEventParams();
         stashEventParams.windowName = "sidebar_" + param3;
         _panel = new SpecialOfferSideBarBase(this);
         param1.specialOffer.signal_updated.add(handler_specialOfferUpdate);
      }
      
      public function dispose() : void
      {
         player.specialOffer.signal_updated.remove(handler_specialOfferUpdate);
      }
      
      public function get panel() : SpecialOfferSideBarBase
      {
         return _panel;
      }
      
      public function get signal_update() : ISignal
      {
         return _signal_update;
      }
      
      public function get specialOfferIcons() : Vector.<SpecialOfferIconDescription>
      {
         return icons.getList();
      }
      
      public function action_specialOfferIconSelect(param1:SpecialOfferIconDescription) : void
      {
         if(param1 == null)
         {
            return;
         }
         SpecialOfferSideBarIconController.call(param1,Stash.click("sidebar_button",stashEventParams),false);
      }
      
      private function handler_specialOfferUpdate() : void
      {
         _signal_update.dispatch();
      }
   }
}
