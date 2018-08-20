package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.OKSocialFacadeHelper;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.homescreen.SpecialOfferSideBarMediator;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SpecialOfferSideBar extends SpecialOfferSideBarBase
   {
      
      public static const HIDDEN:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
       
      
      private var mediatorSpecific:SpecialOfferSideBarMediator;
      
      private var clip:SpecialOfferSideBarClip;
      
      private var button_socialQuest:SocialQuestIconClip;
      
      private var button_bundle:SideBarButton;
      
      private var button_odnoklassniki_payment_offer:SpecialOfferOdnoklassnikiClipButton;
      
      private var button_specialShop:SpecialShopButton;
      
      private var currentBundleId:int = 0;
      
      public function SpecialOfferSideBar(param1:SpecialOfferSideBarMediator, param2:SpecialOfferSideBarMediatorBase)
      {
         super(param2);
         height = 450;
         this.mediatorSpecific = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         HIDDEN.onValue(handler_hidden);
         mediatorSpecific.signal_updateBundleTimeLeft.add(handler_updateBundleTime);
         mediatorSpecific.signal_updateSpecialShopTimeLeft.add(handler_updateSpecialShopTime);
         mediatorSpecific.signal_updateData_bundle.add(handler_updateBundleButton);
         mediatorSpecific.signal_updateData_socialQuest.add(handler_updateSocialQuestButton);
         mediatorSpecific.signal_updateData_specialShop.add(handler_updateSpecialShopButton);
         handler_updateBundleButton();
         handler_updateSpecialOfferButton();
         handler_updateSocialQuestButton();
         handler_updateSpecialShopButton();
         if(OKSocialFacadeHelper.promo_active)
         {
            addOdnoklassnikiPromoButton();
         }
      }
      
      private function handler_updateBundleButton() : void
      {
         var _loc1_:* = null;
         if(mediatorSpecific.hasBundle)
         {
            if(button_bundle && currentBundleId != mediatorSpecific.bundleId)
            {
               removeElement(button_bundle.graphics);
               button_bundle.signal_click.remove(mediatorSpecific.action_bundleOpen);
               button_bundle = null;
            }
            if(!button_bundle)
            {
               _loc1_ = mediatorSpecific.iconClip;
               if(_loc1_)
               {
                  var _loc2_:* = mediatorSpecific.iconClipType;
                  if("cagedAnimal" !== _loc2_)
                  {
                     button_bundle = AssetStorage.rsx.bundle_icons.create(BundleButtonClip,_loc1_);
                  }
                  else
                  {
                     button_bundle = AssetStorage.rsx.bundle_icons.create(Bundle3ButtonClip,_loc1_);
                  }
               }
               if(button_bundle)
               {
                  currentBundleId = mediatorSpecific.bundleId;
                  addElement(button_bundle.graphics);
                  button_bundle.signal_click.add(mediatorSpecific.action_bundleOpen);
                  handler_updateBundleTime();
                  mediatorSpecific.specialOfferHooks.registerBillingSideBarIcon(button_bundle.layout_hitArea.graphics);
               }
            }
         }
         else if(button_bundle)
         {
            removeElement(button_bundle.graphics);
            button_bundle.signal_click.remove(mediatorSpecific.action_bundleOpen);
            button_bundle = null;
         }
      }
      
      private function handler_updateSocialQuestButton() : void
      {
         if(mediatorSpecific.hasSocialQuest)
         {
            if(!button_socialQuest)
            {
               button_socialQuest = AssetStorage.rsx.bundle_icons.create(SocialQuestIconClip,"social_quest_event_icon");
               button_socialQuest.signal_click.add(mediatorSpecific.action_socialQuestOpen);
               addElement(button_socialQuest.graphics);
            }
         }
         else if(button_socialQuest)
         {
            removeElement(button_socialQuest.graphics);
            button_socialQuest.signal_click.remove(mediatorSpecific.action_socialQuestOpen);
            button_socialQuest = null;
         }
      }
      
      private function handler_updateSpecialShopButton() : void
      {
         if(mediatorSpecific.hasSpecialShop && (mediatorSpecific.hasSpecialOfferNewYear || DataStorage.rule.personalMerchantRule.useSidebarIcon))
         {
            if(!button_specialShop)
            {
               button_specialShop = AssetStorage.rsx.bundle_icons.create(SpecialShopButton,"bundle_button_cart");
               button_specialShop.signal_click.add(mediatorSpecific.action_specialShopOpen);
               addElement(button_specialShop.graphics);
            }
         }
         else if(button_specialShop)
         {
            removeElement(button_specialShop.graphics);
            button_specialShop.signal_click.remove(mediatorSpecific.action_specialShopOpen);
            button_specialShop = null;
         }
      }
      
      private function handler_updateBundleTime() : void
      {
         if(button_bundle)
         {
            if(mediatorSpecific.bundleNeedTimer || !mediatorSpecific.showAllBundlesWithVip)
            {
               button_bundle.updateTime(mediatorSpecific.bundleTimeLeft);
            }
            else if(mediatorSpecific.showAllBundlesWithVip)
            {
               button_bundle.updateTime(ColorUtils.hexToRGBFormat(16777062) + Translate.translateArgs("UI_COMMON_VIP",mediatorSpecific.showAllBundlesVipNeeded) + "+");
            }
         }
      }
      
      private function handler_updateSpecialShopTime() : void
      {
         if(button_specialShop)
         {
            button_specialShop.updateTime(mediatorSpecific.specialShopTimeLeft);
         }
      }
      
      private function addOdnoklassnikiPromoButton() : void
      {
         button_odnoklassniki_payment_offer = AssetStorage.rsx.bundle_icons.create(SpecialOfferOdnoklassnikiClipButton,"okSale_button_2");
         addElement(button_odnoklassniki_payment_offer.graphics);
         button_odnoklassniki_payment_offer.signal_click.add(mediatorSpecific.action_odnoklassnikiPaymentOfferOpen);
      }
      
      private function handler_hidden(param1:Boolean) : void
      {
         visible = !param1;
      }
   }
}
