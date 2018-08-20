package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.billing.CommandBundleGetAllAvailableId;
   import game.command.rpc.billing.CommandBundlePause;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.SideBarBlockValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.view.specialoffer.bundlecarousel.SpecialOfferBundleCarouselView;
   
   public class PlayerSpecialOfferBundleCarousel extends PlayerSpecialOfferWithTimer
   {
      
      public static var OFFER_TYPE:String = "bundleCarousel";
       
      
      private var allBundleIdsCommand:CommandBundleGetAllAvailableId;
      
      private var sideBarBlock:SideBarBlockValueObject;
      
      private var previousShownBundleId:int = -1;
      
      private var property_shouldShowBar:BooleanPropertyWriteable;
      
      private var hadBundlePreviously:Boolean = false;
      
      public function PlayerSpecialOfferBundleCarousel(param1:Player, param2:*)
      {
         property_shouldShowBar = new BooleanPropertyWriteable(false);
         super(param1,param2);
      }
      
      public function get assetIdent() : String
      {
         return clientData.assetIdent;
      }
      
      public function get assetClip() : String
      {
         return clientData.assetClip;
      }
      
      public function get sideBarPriority() : int
      {
         return clientData.sideBarPriority;
      }
      
      public function get localeTitle() : String
      {
         return Translate.translate(clientData.locale.title);
      }
      
      public function get localeDescKey() : String
      {
         return clientData.locale.desc;
      }
      
      public function get localeButton() : String
      {
         return Translate.translate(clientData.locale.button);
      }
      
      public function get currentIndex() : int
      {
         var _loc1_:PlayerBillingBundleEntry = player.billingData.bundleData.activeBundle;
         if(allBundleIdsCommand != null && _loc1_ != null)
         {
            return allBundleIdsCommand.getBundleIdIndex(_loc1_.id) + 1;
         }
         return 1;
      }
      
      public function get indicesTotal() : int
      {
         if(allBundleIdsCommand)
         {
            return allBundleIdsCommand.getCount();
         }
         return 1;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         property_shouldShowBar.signal_update.add(handler_shouldShowBar);
         hadBundlePreviously = player.billingData.bundleData.activeBundle;
         player.billingData.bundleData.signal_update.add(handler_bundleUpdated);
         var _loc2_:CommandBundleGetAllAvailableId = GameModel.instance.actionManager.bundleGetAllAvailableId();
         _loc2_.onClientExecute(handler_getBundleIds);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         player.billingData.bundleData.signal_update.remove(handler_bundleUpdated);
         property_shouldShowBar.unsubscribe(handler_shouldShowBar);
         param1.hooks._bundleSideBarValueObjects.remove(getSideBarValueObject());
      }
      
      public function action_next(param1:PopupStashEventParams) : void
      {
         var _loc2_:CommandBundlePause = GameModel.instance.actionManager.bundlePause();
         _loc2_.stashParams = param1;
         _loc2_.onClientExecute(handler_commandBundlePause);
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
      }
      
      private function getSideBarValueObject() : SideBarBlockValueObject
      {
         if(!sideBarBlock)
         {
            sideBarBlock = new SideBarBlockValueObject(sideBarPriority);
            sideBarBlock.signal_initialize.add(handler_sideBarBlockInitialize);
         }
         return sideBarBlock;
      }
      
      private function handler_sideBarBlockInitialize(param1:SideBarBlockValueObject) : void
      {
         var _loc2_:* = null;
         param1.sideBarBlock = new SpecialOfferBundleCarouselView(this);
         if(previousShownBundleId != player.billingData.bundleData.activeBundle.id)
         {
            _loc2_ = GameModel.instance.actionManager.bundleGetAllAvailableId();
            _loc2_.signal_complete.add(handler_getBundleIds);
         }
      }
      
      private function handler_getBundleIds(param1:CommandBundleGetAllAvailableId) : void
      {
         if(player.billingData.bundleData.activeBundle)
         {
            allBundleIdsCommand = param1;
            previousShownBundleId = player.billingData.bundleData.activeBundle.id;
            property_shouldShowBar.value = indicesTotal > 1;
         }
      }
      
      private function handler_commandBundlePause(param1:CommandBundlePause) : void
      {
         if(player.billingData.bundleData.activeBundle)
         {
            if(player.billingData.bundleData.activeBundle.desc.duration)
            {
               Game.instance.navigator.navigateToBundle(param1.stashParams,true,200);
            }
         }
      }
      
      private function handler_shouldShowBar(param1:Boolean) : void
      {
         if(param1)
         {
            player.specialOffer.hooks._bundleSideBarValueObjects.push(getSideBarValueObject());
         }
         else
         {
            player.specialOffer.hooks._bundleSideBarValueObjects.remove(getSideBarValueObject());
         }
      }
      
      private function handler_bundleUpdated(param1:Boolean) : void
      {
         var _loc2_:Boolean = player.billingData.bundleData.activeBundle;
         if(hadBundlePreviously != _loc2_)
         {
            hadBundlePreviously = _loc2_;
            if(!_loc2_)
            {
               GameModel.instance.actionManager.playerCommands.updateBilllings();
            }
         }
      }
   }
}
