package game.mediator.gui.popup.billing.bundle
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.view.popup.PopupBase;
   
   public class BundleListPopupMediator extends PopupMediator
   {
       
      
      private var lastSelectedIndex:int = -1;
      
      private var _lastSwitchDirection:int = 0;
      
      private var _currentPopupMediator:ObjectPropertyWriteable;
      
      private var _bundlesVector:Vector.<BundleValueObject>;
      
      public const bundles:ListCollection = new ListCollection();
      
      public function BundleListPopupMediator(param1:Player)
      {
         _currentPopupMediator = new ObjectPropertyWriteable(PopupMediator);
         super(param1);
         param1.billingData.bundleData.signal_update.add(handler_bundleUpdate);
         handler_bundleUpdate(true);
      }
      
      public static function createBundlePopupMediator(param1:Player, param2:PlayerBillingBundleEntry) : BundlePopupMediator
      {
         var _loc3_:* = param2.desc.dialogType;
         if("bundle2_purple" !== _loc3_)
         {
            if("bundle2" !== _loc3_)
            {
               if("bundle3" !== _loc3_)
               {
                  if("hero" !== _loc3_)
                  {
                     if("skin" !== _loc3_)
                     {
                        if("upsell" !== _loc3_)
                        {
                           return null;
                        }
                        return new HeroEvolveUpsellBundlePopupMediator(param1);
                     }
                     return new GenericSkinBundlePopupMediator(param1);
                  }
                  return new GenericHeroBundlePopupMediator(param1);
               }
               return new Bundle3PopupMediator(param1);
            }
            return new Bundle2PopupMediator(param1,AssetStorage.rsx.asset_bundle,param2.desc.dialogClip);
         }
         return new Bundle2PopupMediator(param1,AssetStorage.rsx.asset_bundle,param2.desc.dialogClip);
      }
      
      override protected function dispose() : void
      {
         player.billingData.bundleData.signal_update.remove(handler_bundleUpdate);
         player.billingData.bundleData.signal_update.dispatch(false);
         super.dispose();
      }
      
      public function get currentPopupMediator() : ObjectProperty
      {
         return _currentPopupMediator;
      }
      
      public function get lastSwitchDirection() : int
      {
         return _lastSwitchDirection;
      }
      
      public function get selectedItemIndex() : int
      {
         if(lastSelectedIndex < _bundlesVector.length)
         {
            return lastSelectedIndex;
         }
         return -1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BundleListPopup(this);
         return new BundleListPopup(this);
      }
      
      public function action_select(param1:BundleValueObject) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         player.billingData.bundleData.selectBundle(param1.entry);
         var _loc3_:BundlePopupMediator = createBundlePopupMediator(player,param1.entry);
         if(_loc3_)
         {
            if(_currentPopupMediator.value != null)
            {
               _loc2_ = _currentPopupMediator.value as BundlePopupMediator;
            }
            _loc4_ = _bundlesVector.indexOf(param1);
            if(_loc4_ > lastSelectedIndex)
            {
               _lastSwitchDirection = 1;
            }
            else if(_loc4_ < lastSelectedIndex)
            {
               _lastSwitchDirection = -1;
            }
            else
            {
               _lastSwitchDirection = 0;
            }
            lastSelectedIndex = _loc4_;
            _currentPopupMediator.value = _loc3_;
         }
      }
      
      protected function selectActiveBundle() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_bundleUpdate(param1:Boolean) : void
      {
         var _loc4_:* = null;
         if(!player)
         {
            return;
         }
         _bundlesVector = new Vector.<BundleValueObject>();
         var _loc3_:Vector.<PlayerBillingBundleEntry> = player.billingData.bundleData.activeList;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc4_ = new BundleValueObject(this,_loc2_);
            _bundlesVector.push(_loc4_);
         }
         _bundlesVector.sort(BundleValueObject.sort_byType);
         this.bundles.data = _bundlesVector;
         selectActiveBundle();
      }
   }
}
