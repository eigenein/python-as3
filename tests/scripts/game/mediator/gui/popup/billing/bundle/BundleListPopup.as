package game.mediator.gui.popup.billing.bundle
{
   import engine.core.assets.AssetLoader;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BundleListPopupClip;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.PopupBase;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class BundleListPopup extends ClipBasedPopup
   {
      
      public static const TWEEN_DURATION:Number = 0.5;
      
      public static const TWEEN_X_OFFSET:Number = 40;
       
      
      private var mediator:BundleListPopupMediator;
      
      private var popupContent:PopupMediator;
      
      private var clip:BundleListPopupClip;
      
      public function BundleListPopup(param1:BundleListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         if(popupContent)
         {
            popupContent.signal_dispose.remove(handler_popupDispose);
         }
         AssetLoader.highLoadTasks.free(this);
         Starling.juggler.removeTweens(clip.layout);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(BundleListPopupClip,"dialog_bundle_list");
         addChild(clip.graphics);
         clip.list.dataProvider = mediator.bundles;
         clip.list.selectedIndex = mediator.selectedItemIndex;
         clip.list.addEventListener("change",handler_selected);
         mediator.currentPopupMediator.onValue(handler_currentPopupMediator);
      }
      
      private function handler_currentPopupMediator(param1:PopupMediator) : void
      {
         if(param1 == null)
         {
            return;
         }
         clip.layout.x = 0;
         if(popupContent)
         {
            popupContent.signal_dispose.remove(handler_popupDispose);
            AssetLoader.highLoadTasks.pause(this);
            clip.graphics.touchable = false;
            Starling.juggler.tween(clip.layout,0.5 * 0.5,{
               "alpha":0,
               "x":-40 * mediator.lastSwitchDirection,
               "transition":"easeIn",
               "onComplete":handler_tweenStartComplete,
               "onCompleteArgs":[param1]
            });
         }
         else
         {
            clip.layout.alpha = 1;
            setCurrentPopup(param1);
         }
      }
      
      private function handler_tweenStartComplete(param1:PopupMediator) : void
      {
         clip.layout.removeChildren(0,-1,true);
         popupContent.close();
         setCurrentPopup(param1);
         clip.layout.alpha = 0;
         clip.layout.x = 40 * mediator.lastSwitchDirection;
         Starling.juggler.tween(clip.layout,0.5 * 0.5,{
            "alpha":1,
            "x":0,
            "transition":"easeOut",
            "onComplete":handler_tweenComplete
         });
         clip.graphics.touchable = true;
      }
      
      private function setCurrentPopup(param1:PopupMediator) : void
      {
         popupContent = param1;
         var _loc2_:PopupBase = param1.createPopup();
         param1.signal_dispose.add(handler_popupDispose);
         clip.layout.addChild(_loc2_);
      }
      
      private function handler_tweenComplete() : void
      {
         AssetLoader.highLoadTasks.unpause(this);
      }
      
      private function handler_selected(param1:Event) : void
      {
         mediator.action_select(clip.list.selectedItem as BundleValueObject);
      }
      
      private function handler_popupDispose() : void
      {
         mediator.close();
      }
   }
}
