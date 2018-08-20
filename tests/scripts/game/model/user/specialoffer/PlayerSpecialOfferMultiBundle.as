package game.model.user.specialoffer
{
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.specialoffer.MultiBundleOfferValueObject;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   
   public class PlayerSpecialOfferMultiBundle extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "multibundle";
       
      
      protected var _bundles:Vector.<MultiBundleOfferValueObject>;
      
      protected var _titleLocale:String;
      
      protected var _popupAsset:AssetClipLink;
      
      private const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(5);
      
      public function PlayerSpecialOfferMultiBundle(param1:Player, param2:*)
      {
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_openPopup);
      }
      
      public function get bundles() : Vector.<MultiBundleOfferValueObject>
      {
         return _bundles;
      }
      
      public function get titleLocale() : String
      {
         return _titleLocale;
      }
      
      public function get popupAsset() : AssetClipLink
      {
         return _popupAsset;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         if(_sideBarIcon)
         {
            _sideBarIcon.signal_click.add(handler_openPopup);
         }
         if(clientData.popup)
         {
            _popupAsset = new AssetClipLink(AssetStorage.rsx.getByName(clientData.popup.asset),clientData.popup.clip);
         }
         _titleLocale = clientData.popupHeaderLocaleId;
         param1.addAutoPopup(autoPopupQueueEntry);
      }
      
      protected function handler_openPopup(param1:PopupStashEventParams) : void
      {
      }
      
      override protected function update(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         super.update(param1);
         if(!_bundles)
         {
            _bundles = new Vector.<MultiBundleOfferValueObject>();
         }
         var _loc4_:Array = param1.notAvailableBillings;
         var _loc5_:Array = param1.billings;
         var _loc3_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _loc5_[_loc6_].id;
            _loc7_ = getVoById(_loc2_);
            if(!_loc7_)
            {
               _loc8_ = player.billingData.getById(_loc2_);
               _loc7_ = new MultiBundleOfferValueObject(_loc5_[_loc6_],new BillingPopupValueObject(_loc8_,player));
               _bundles.push(_loc7_);
            }
            _loc7_.setBought(_loc4_.indexOf(_loc2_) != -1);
            _loc6_++;
         }
      }
      
      private function getVoById(param1:int) : MultiBundleOfferValueObject
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_bundles)
         {
            _loc2_ = _bundles.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_bundles[_loc3_].id == param1)
               {
                  return _bundles[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
   }
}
