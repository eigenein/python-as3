package game.mediator.gui.homescreen
{
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.model.user.Player;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.specialoffer.PlayerSpecialOfferHooks;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.gui.overlay.offer.SpecialOfferSideBar;
   import game.view.gui.overlay.offer.SpecialOfferSideBarMediatorBase;
   import game.view.popup.odnoklassniki.OdnoklassnikiEventPopup;
   import game.view.popup.shop.special.SpecialShopPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class SpecialOfferSideBarMediator
   {
       
      
      private var player:Player;
      
      private var specialShopMerchant:SpecialShopMerchant;
      
      protected var stashEventParams:PopupStashEventParams;
      
      private var _panel:SpecialOfferSideBar;
      
      private var _signal_updateData_socialQuest:Signal;
      
      private var _signal_updateBundleTimeLeft:Signal;
      
      private var _signal_updateSpecialShopTimeLeft:Signal;
      
      private var _signal_updateData_bundle:Signal;
      
      private var _signal_updateData_specialOffer:Signal;
      
      private var _signal_updateData_specialShop:Signal;
      
      public function SpecialOfferSideBarMediator(param1:Player)
      {
         _signal_updateData_socialQuest = new Signal();
         _signal_updateSpecialShopTimeLeft = new Signal();
         _signal_updateData_bundle = new Signal();
         _signal_updateData_specialOffer = new Signal();
         _signal_updateData_specialShop = new Signal();
         super();
         this.player = param1;
         _panel = new SpecialOfferSideBar(this,new SpecialOfferSideBarMediatorBase(param1,param1.specialOffer.mainScreenIcons,"button"));
         stashEventParams = new PopupStashEventParams();
         stashEventParams.windowName = "global";
         param1.socialQuestData.signal_questUpdate.add(handler_socialQuestUpdate);
         param1.billingData.bundleData.signal_update.add(handler_bundleUpdate);
         param1.specialOffer.signal_updated.add(handler_specialOfferUpdate);
         param1.specialShop.model.signal_update.add(handler_specialShopUpdate);
         updateData_specialShop();
         if(param1.isInited)
         {
            handler_playerInit();
         }
         else
         {
            param1.signal_update.initSignal.add(handler_playerInit);
         }
         _signal_updateBundleTimeLeft = param1.billingData.bundleData.signal_updateBundleTimeLeft;
         updateData_specialOffer();
      }
      
      public function get panel() : SpecialOfferSideBar
      {
         return _panel;
      }
      
      public function get signal_updateData_socialQuest() : Signal
      {
         return _signal_updateData_socialQuest;
      }
      
      public function get bundleTimeLeft() : String
      {
         return player.billingData.bundleData.bundleTimeLeft;
      }
      
      public function get bundleNeedTimer() : Boolean
      {
         return player.billingData.bundleData.needTimer;
      }
      
      public function get showAllBundlesWithVip() : Boolean
      {
         return player.vipLevel.level >= showAllBundlesVipNeeded;
      }
      
      public function get showAllBundlesVipNeeded() : int
      {
         return DataStorage.rule.vipRule.allBundlesCarousel;
      }
      
      public function get specialShopTimeLeft() : String
      {
         return !!specialShopMerchant?TimeFormatter.toMS2(specialShopMerchant.timeLeft).toString():TimeFormatter.toMS2(0).toString();
      }
      
      public function get signal_updateBundleTimeLeft() : Signal
      {
         return _signal_updateBundleTimeLeft;
      }
      
      public function get signal_updateSpecialShopTimeLeft() : Signal
      {
         return _signal_updateSpecialShopTimeLeft;
      }
      
      public function get bundleId() : int
      {
         return !!player.billingData.bundleData.activeBundle?player.billingData.bundleData.activeBundle.id:0;
      }
      
      public function get groupId() : int
      {
         return !!player.billingData.bundleData.activeBundle?player.billingData.bundleData.activeBundle.groupId:0;
      }
      
      public function get iconClip() : String
      {
         return !!player.billingData.bundleData.activeBundle?player.billingData.bundleData.activeBundle.desc.iconClip:null;
      }
      
      public function get iconClipType() : String
      {
         return !!player.billingData.bundleData.activeBundle?player.billingData.bundleData.activeBundle.desc.iconClipType:null;
      }
      
      public function get signal_updateData_bundle() : Signal
      {
         return _signal_updateData_bundle;
      }
      
      public function get specialOfferHooks() : PlayerSpecialOfferHooks
      {
         return player.specialOffer.hooks;
      }
      
      public function get signal_updateData_specialOffer() : Signal
      {
         return _signal_updateData_specialOffer;
      }
      
      public function get signal_updateData_specialShop() : Signal
      {
         return _signal_updateData_specialShop;
      }
      
      public function get hasBundle() : Boolean
      {
         return player.billingData.bundleData.activeBundle;
      }
      
      public function get hasSocialQuest() : Boolean
      {
         return player.socialQuestData.questAvailable;
      }
      
      public function get specialOfferIcons() : Vector.<SpecialOfferIconDescription>
      {
         return player.specialOffer.mainScreenIcons.getList();
      }
      
      public function get hasSpecialShop() : Boolean
      {
         return specialShopMerchant != null && specialShopMerchant.canBuy();
      }
      
      public function get hasSpecialOfferNewYear() : Boolean
      {
         return player.specialOffer.hasSpecialOffer("newYear2016Tree");
      }
      
      public function action_socialQuestOpen() : void
      {
         var _loc1_:SocialQuestPopupMediator = new SocialQuestPopupMediator(player);
         _loc1_.open(Stash.click("social_quest",stashEventParams));
      }
      
      public function action_bundleOpen() : void
      {
         Game.instance.navigator.navigateToBundle(stashEventParams);
      }
      
      public function action_odnoklassnikiPaymentOfferOpen() : void
      {
         var _loc1_:OdnoklassnikiEventPopup = new OdnoklassnikiEventPopup(null);
         _loc1_.open();
      }
      
      public function action_specialShopOpen() : void
      {
         var _loc1_:SpecialShopPopupMediator = new SpecialShopPopupMediator(specialShopMerchant);
         _loc1_.open();
      }
      
      private function updateData() : void
      {
         updateData_socialQuest();
         updateData_bundle();
      }
      
      private function updateData_bundle() : void
      {
         _signal_updateData_bundle.dispatch();
      }
      
      private function updateData_specialOffer() : void
      {
         _signal_updateData_specialOffer.dispatch();
      }
      
      private function updateData_socialQuest() : void
      {
         _signal_updateData_socialQuest.dispatch();
      }
      
      private function updateData_specialShop() : void
      {
         specialShopMerchant = player.specialShop.model.getAvailableMerchant();
         if(specialShopMerchant && specialShopMerchant.canBuy())
         {
            GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
            handler_onGameTimer();
         }
         else
         {
            GameTimer.instance.oneSecTimer.remove(handler_onGameTimer);
         }
         signal_updateData_specialShop.dispatch();
      }
      
      private function handler_onGameTimer() : void
      {
         signal_updateSpecialShopTimeLeft.dispatch();
      }
      
      private function handler_socialQuestUpdate() : void
      {
         updateData_socialQuest();
      }
      
      private function handler_playerInit() : void
      {
         updateData();
      }
      
      private function handler_bundleUpdate(param1:Boolean) : void
      {
         updateData_bundle();
      }
      
      private function handler_specialOfferUpdate() : void
      {
         updateData_specialOffer();
      }
      
      private function handler_specialShopUpdate() : void
      {
         updateData_specialShop();
      }
   }
}
