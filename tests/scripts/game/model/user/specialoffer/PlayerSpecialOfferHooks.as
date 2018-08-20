package game.model.user.specialoffer
{
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import flash.utils.Dictionary;
   import game.command.social.SocialBillingBuyResult;
   import game.mediator.gui.popup.billing.BillingBenefitValueObject;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.SideBarBlockValueObject;
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.view.gui.homescreen.HomeScreenGuiChestClipButton;
   import game.view.popup.artifactchest.ArtifactChestPopupClip;
   import game.view.popup.chest.TownChestFullscreenPopupClip;
   import game.view.popup.chest.reward.ChestRewardFullscreenPopupClip;
   import game.view.popup.common.resourcepanel.PopupResourcePanelBase;
   import game.view.popup.summoningcircle.SummoningCirclePopUpClip;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   
   public class PlayerSpecialOfferHooks
   {
       
      
      private var slotMap:Dictionary;
      
      const missionDrop:Signal = new Signal(Vector.<MissionDropValueObject>);
      
      const billings:Signal = new Signal(Vector.<BillingPopupValueObject>);
      
      const billingBenefits:Signal = new Signal(BillingPopupValueObject,Vector.<BillingBenefitValueObject>);
      
      const billingResult:Signal = new Signal(SocialBillingBuyResult);
      
      const chestRewardFullscreenPopupClip:Signal = new Signal(ChestRewardFullscreenPopupClip);
      
      const townChestFullscreenPopupClip:Signal = new Signal(TownChestFullscreenPopupClip);
      
      const summoningCirclePopupClip:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(SummoningCirclePopUpClip);
      
      const artifactChestPopupClip:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(ArtifactChestPopupClip);
      
      const homeScreenChest:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(HomeScreenGuiChestClipButton);
      
      public const homeScreenCampaign:SpecialOfferViewEntryQueue = cteateSlot("homeScreen.campaign");
      
      public const homeScreenStarmoney:SpecialOfferViewEntryQueue = cteateSlot("homeScreen.starmoney");
      
      public const zeppelinArtifactChest:SpecialOfferViewEntryQueue = cteateSlot("zeppelin.artifactChest");
      
      public const artifactChest:SpecialOfferViewEntryQueue = cteateSlot("artifactChest");
      
      public const artifactChestOpenPack:SpecialOfferViewEntryQueue = cteateSlot("artifactChestOpenPack");
      
      public const artifactChestOpenX100:SpecialOfferViewEntryQueue = cteateSlot("artifactChestOpenPack100");
      
      public const summoningCircleOpenPack:SpecialOfferViewEntryQueue = cteateSlot("summoningCircleOpenPack");
      
      public const summoningCircleOpenPack10:SpecialOfferViewEntryQueue = cteateSlot("summoningCircleOpenPack10");
      
      public const summoningCircleSphere:SpecialOfferViewEntryQueue = cteateSlot("summoningCircleSphere");
      
      public const clanScreenSummoningCircle:SpecialOfferViewEntryQueue = cteateSlot("clanScreen.summoningCircle");
      
      const resourcePanel:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(PopupResourcePanelBase);
      
      const chestPopupChestIcon:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(DisplayObject);
      
      const billingSideBarIcon:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(DisplayObject);
      
      const bundlePopupSpecialOffer:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(DisplayObject);
      
      const halloweenSecretSpecialOffer:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(Halloween2k17SpecialOfferViewOwner);
      
      const ny2018SecretSpecialOffer:SpecialOfferDisplayObjectHook = new SpecialOfferDisplayObjectHook(NY2018SecretRewardOfferViewOwner);
      
      const _bundleSideBarValueObjects:VectorPropertyWriteable = new VectorPropertyWriteable(new Vector.<SideBarBlockValueObject>() as Vector.<*>);
      
      const _billingSideBarValueObjects:VectorPropertyWriteable = new VectorPropertyWriteable(new Vector.<SideBarBlockValueObject>() as Vector.<*>);
      
      public function PlayerSpecialOfferHooks()
      {
         slotMap = new Dictionary();
         super();
      }
      
      public function get bundleSideBarValueObjects() : VectorProperty
      {
         return _bundleSideBarValueObjects;
      }
      
      public function get billingSideBarValueObjects() : VectorProperty
      {
         return _billingSideBarValueObjects;
      }
      
      public function adjustMissionDrop(param1:Vector.<MissionDropValueObject>) : void
      {
         missionDrop.dispatch(param1);
      }
      
      public function adjustBillings(param1:Vector.<BillingPopupValueObject>) : void
      {
         this.billings.dispatch(param1);
      }
      
      public function adjustBillingBenefits(param1:BillingPopupValueObject, param2:Vector.<BillingBenefitValueObject>) : void
      {
         billingBenefits.dispatch(param1,param2);
      }
      
      public function adjustBillingResult(param1:SocialBillingBuyResult) : void
      {
         this.billingResult.dispatch(param1);
      }
      
      public function registerTownChestFullscreenPopupClip(param1:TownChestFullscreenPopupClip) : void
      {
         this.townChestFullscreenPopupClip.dispatch(param1);
      }
      
      public function registerSummoningCirclePopupClip(param1:SummoningCirclePopUpClip) : void
      {
         this.summoningCirclePopupClip.register(param1);
      }
      
      public function registerArtifactChestPopupClip(param1:ArtifactChestPopupClip) : void
      {
         this.artifactChestPopupClip.register(param1);
      }
      
      public function registerResourcePanel(param1:PopupResourcePanelBase) : void
      {
         this.resourcePanel.register(param1);
      }
      
      public function registerHomeScreenChest(param1:HomeScreenGuiChestClipButton) : void
      {
         this.homeScreenChest.register(param1);
      }
      
      public function registerChestPopupChestIcon(param1:DisplayObject) : void
      {
         this.chestPopupChestIcon.register(param1);
      }
      
      public function registerBillingSideBarIcon(param1:DisplayObject) : void
      {
         this.billingSideBarIcon.register(param1);
      }
      
      public function registerBundlePopupSpecialOffer(param1:DisplayObject) : void
      {
         this.bundlePopupSpecialOffer.register(param1);
      }
      
      public function registerHalloween2k17SpecialOffer(param1:Halloween2k17SpecialOfferViewOwner) : void
      {
         this.halloweenSecretSpecialOffer.register(param1);
      }
      
      public function registerNY2018SecretRewardOffer(param1:NY2018SecretRewardOfferViewOwner) : void
      {
         this.ny2018SecretSpecialOffer.register(param1);
      }
      
      public function addViewSlotEntry(param1:ViewSlotEntry) : void
      {
         var _loc2_:SpecialOfferViewEntryQueue = slotMap[param1.slot];
         if(_loc2_ != null)
         {
            _loc2_.add(param1);
         }
      }
      
      private function cteateSlot(param1:String) : SpecialOfferViewEntryQueue
      {
         var _loc2_:SpecialOfferViewEntryQueue = new SpecialOfferViewEntryQueue();
         slotMap[param1] = _loc2_;
         return _loc2_;
      }
   }
}
