package game.mediator.gui.popup
{
   import avmplus.getQualifiedClassName;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetDisposingWatcher;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferHooks;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   import org.osflash.signals.SignalWatcher;
   
   public class PopupMediator
   {
       
      
      protected var player:Player;
      
      protected var disposed:Boolean = false;
      
      protected var _popup:PopupBase;
      
      private var _signal_dispose:Signal;
      
      public function PopupMediator(param1:Player)
      {
         _signal_dispose = new Signal();
         super();
         this.player = param1;
         SignalWatcher.createPopup(this);
         SignalWatcher.nameContext(getQualifiedClassName(this));
         AssetDisposingWatcher.watch(this,getQualifiedClassName(this));
      }
      
      public function get popup() : PopupBase
      {
         return _popup;
      }
      
      public function get signal_dispose() : Signal
      {
         return _signal_dispose;
      }
      
      public function get specialOfferHooks() : PlayerSpecialOfferHooks
      {
         return player.specialOffer.hooks;
      }
      
      public function open(param1:PopupStashEventParams = null) : void
      {
         var _loc2_:PopupBase = createPopup();
         _loc2_.stashSourceClick = param1;
         _loc2_.open();
      }
      
      public function openDelayed(param1:PopupStashEventParams = null, param2:int = 1000) : void
      {
         var _loc3_:PopupBase = createPopup();
         _loc3_.stashSourceClick = param1;
         _loc3_.openDelayed(param2);
      }
      
      public function close() : void
      {
         if(_popup)
         {
            PopUpManager.removePopUp(_popup);
            if(_popup.parent)
            {
               _popup.removeFromParent();
            }
            _popup.dispose();
         }
         dispose();
      }
      
      public function createPopup() : PopupBase
      {
         return null;
      }
      
      public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         return null;
      }
      
      protected function dispose() : void
      {
         player = null;
         disposed = true;
         signal_dispose.dispatch();
         SignalWatcher.disposePopup(this);
      }
   }
}
