package game.mechanics.zeppelin.mediator
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.billing.CommandSubscriptionFarmGifts;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.expedition.mediator.SubscriptionRewardPopupMediator;
   import game.mechanics.zeppelin.popup.ZeppelinPopup;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.RedMarkerState;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.model.user.subscription.PlayerSubscriptionData;
   import game.stat.Stash;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.homescreen.ShopHoverSound;
   import game.view.gui.overlay.offer.SpecialOfferSideBarMediatorBase;
   import game.view.popup.PopupBase;
   
   public class ZeppelinPopupMediator extends PopupMediator
   {
      
      private static var _music:ShopHoverSound;
       
      
      private var _sideBar:SpecialOfferSideBarMediatorBase;
      
      private var _property_subscriptionActive:BooleanPropertyWriteable;
      
      public function ZeppelinPopupMediator(param1:Player)
      {
         _property_subscriptionActive = new BooleanPropertyWriteable();
         super(param1);
         param1.subscription.signal_updated.add(handler_subscriptionUpdate);
         handler_subscriptionUpdate();
         _sideBar = new SpecialOfferSideBarMediatorBase(param1,param1.specialOffer.zeppelingIcons,"zeppelin");
      }
      
      public static function get music() : ShopHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.zeppelinHover);
         }
         return _music;
      }
      
      override protected function dispose() : void
      {
         _sideBar.dispose();
         _music.shopClosed();
         player.subscription.signal_updated.remove(handler_subscriptionUpdate);
         super.dispose();
      }
      
      public function get sideBar() : SpecialOfferSideBarMediatorBase
      {
         return _sideBar;
      }
      
      public function get property_subscriptionActive() : BooleanProperty
      {
         return _property_subscriptionActive;
      }
      
      public function get redMarkerState_subscription() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.subscription;
      }
      
      public function get redMarkerState_chest() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.artifactChest;
      }
      
      public function get redMarkerState_expeditions() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.expeditions;
      }
      
      public function get redMarkerState_artifacts() : RedMarkerState
      {
         return RedMarkerGlobalMediator.instance.artifacts;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ZeppelinPopup(this);
         return _popup;
      }
      
      public function action_navigate_artifacts() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT,Stash.click("artifacts",_popup.stashParams));
      }
      
      public function action_navigate_chest() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT_CHEST,Stash.click("chest",_popup.stashParams));
      }
      
      public function action_navigate_merchant() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT_MERCHANT,Stash.click("merchant",_popup.stashParams));
      }
      
      public function action_navigate_expeditions() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.EXPEDITIONS,Stash.click("arena",_popup.stashParams));
      }
      
      public function action_navigate_subscription() : void
      {
         var _loc1_:* = null;
         if(player.subscription.currentZeppelinGift.canFarm.value || player.subscription.dailyReward.canFarm.value)
         {
            _loc1_ = GameModel.instance.actionManager.playerCommands.subscriptionFarmGifts(player.subscription.currentZeppelinGift.canFarm.value);
            _loc1_.signal_complete.add(handler_farmGiftCommandComplete);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.SUBSCRIPTION,Stash.click("subscription",_popup.stashParams));
         }
      }
      
      public function registerSpecialOfferSpot(param1:ClipLayout) : void
      {
         var _loc2_:Halloween2k17SpecialOfferViewOwner = new Halloween2k17SpecialOfferViewOwner(param1,this,"zeppelin");
         player.specialOffer.hooks.registerHalloween2k17SpecialOffer(_loc2_);
      }
      
      private function handler_subscriptionUpdate(param1:PlayerSubscriptionData = null) : void
      {
         _property_subscriptionActive.value = player.subscription.subscriptionInfo.isActive;
      }
      
      private function handler_farmGiftCommandComplete(param1:CommandSubscriptionFarmGifts) : void
      {
         var _loc2_:* = null;
         if(player)
         {
            _loc2_ = new SubscriptionRewardPopupMediator(player,param1);
            _loc2_.open(Stash.click("subscription_farm",_popup.stashParams));
         }
      }
   }
}
