package game.mediator.gui.popup
{
   import com.progrestar.common.error.ClientErrorManager;
   import com.progrestar.common.social.GMRSocialAdapter;
   import com.progrestar.common.social.SocialAdapter;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.mediator.gui.popup.mail.PlayerMailImportantPopupMediator;
   import game.mediator.gui.popup.social.CommunityPromoPopupMediator;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferWithSideBarIcon;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.stat.Stash;
   import game.view.gui.overlay.offer.SpecialOfferSideBarIconController;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.shop.special.SpecialShopWelcomePopup;
   
   public class AutoPopupMediator
   {
       
      
      private var player:Player;
      
      private var stashEventParams:PopupStashEventParams;
      
      private var timeout_socialQuest:int = 86400;
      
      private var initialized:Boolean = false;
      
      private const popupQueue:Vector.<AutoPopupQueueEntry> = new Vector.<AutoPopupQueueEntry>();
      
      public function AutoPopupMediator(param1:Player)
      {
         super();
         this.player = param1;
         stashEventParams = new PopupStashEventParams();
         stashEventParams.windowName = "global";
         param1.specialOffer.autoPopupStream.add(handler_autoPopupAdded);
      }
      
      public function initialize() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc6_:Boolean = false;
         player.billingData.bundleData.signal_update.add(handler_updatedBundle);
         player.specialShop.model.signal_init.add(handler_specialShopInit);
         if(!Tutorial.flags.mainTutorialCompleted)
         {
            return;
         }
         if(player.specialOffer.mergebonusEndTime - GameTimer.instance.currentServerTime > 0 && player.sharedObjectStorage.readTimeout("game.view.popup.merge.MergeInfoPopUpMediator.mergeBonus"))
         {
            PopupList.instance.dialog_merge_info(null,true);
            return;
         }
         try
         {
            _loc1_ = player.specialOffer.mainScreenIcons.getList();
            _loc3_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = _loc1_[_loc5_].specialOffer as PlayerSpecialOfferWithSideBarIcon;
               if(_loc4_ && _loc4_.showOnStart)
               {
                  player.sharedObjectStorage.setTimeout("game.view.gui.overlay.offer.SpecialOfferSideBarIconController.method",_loc4_.showTimeout);
                  if(player.sharedObjectStorage.readTimeout("game.view.gui.overlay.offer.SpecialOfferSideBarIconController.method"))
                  {
                     SpecialOfferSideBarIconController.call(_loc4_.sideBarIcon,stashEventParams,true);
                     return;
                  }
               }
               _loc5_++;
            }
         }
         catch(error:Error)
         {
            ClientErrorManager.action_handleError(error);
         }
         if(player.mail.hasImportantUpdate)
         {
            showUpdateMail();
         }
         if(popupQueue.length > 0)
         {
            _loc2_ = popupQueue.pop();
            _loc2_.open(stashEventParams);
         }
         else
         {
            showBundle();
         }
         if(!(SocialAdapter.instance is GMRSocialAdapter))
         {
            _loc6_ = !player.freeGiftData.hasOnceRecievedGiftsFromGroup && player.sharedObjectStorage.readTimeout("game.mediator.gui.popup.AutoPopupMediator.communityPromo");
            if(_loc6_)
            {
               showCommunityPromo();
            }
            else
            {
               showSocialQuest();
            }
         }
         initialized = true;
      }
      
      protected function showPopup() : void
      {
      }
      
      private function showUpdateMail() : void
      {
         var _loc1_:PlayerMailImportantPopupMediator = new PlayerMailImportantPopupMediator(player);
         _loc1_.openDelayed(Stash.click("mail_important",stashEventParams));
      }
      
      private function showCommunityPromo() : void
      {
         var _loc1_:CommunityPromoPopupMediator = new CommunityPromoPopupMediator(player);
         _loc1_.openDelayed(Stash.click("community_promo",stashEventParams));
         player.sharedObjectStorage.writeTimeout("game.mediator.gui.popup.AutoPopupMediator.communityPromo");
      }
      
      private function showBundle(param1:Boolean = true) : void
      {
         if(player.billingData.bundleData.activeBundle)
         {
            if(player.billingData.bundleData.activeBundle.desc.duration)
            {
               Game.instance.navigator.navigateToBundle(stashEventParams,param1);
               return;
            }
         }
      }
      
      private function showSocialQuest(param1:Boolean = false) : void
      {
         var _loc2_:* = null;
         if(player.socialQuestData.questAvailable)
         {
            if(param1 || player.sharedObjectStorage.readTimeout("game.mediator.gui.popup.AutoPopupMediator.socialQuest"))
            {
               _loc2_ = new SocialQuestPopupMediator(player);
               _loc2_.openDelayed(Stash.click("social_quest",stashEventParams));
               player.sharedObjectStorage.writeTimeout("game.mediator.gui.popup.AutoPopupMediator.socialQuest");
            }
         }
      }
      
      private function handler_updatedBundle(param1:Boolean) : void
      {
         if(param1)
         {
            showBundle(true);
         }
      }
      
      private function handler_specialShopInit() : void
      {
         var _loc1_:* = null;
         if(player.specialShop.model.getAvailableMerchant())
         {
            _loc1_ = new SpecialShopWelcomePopup(null);
            _loc1_.openDelayed(0);
         }
      }
      
      private function handler_autoPopupAdded(param1:AutoPopupQueueEntry) : void
      {
         if(param1.disposed)
         {
            return;
         }
         if(initialized)
         {
            param1.open(stashEventParams);
         }
         else
         {
            param1.signal_dispose.add(hander_autoPopupRemoved);
            popupQueue.push(param1);
            popupQueue.sort(AutoPopupQueueEntry.sort_byPriority);
         }
      }
      
      private function hander_autoPopupRemoved(param1:AutoPopupQueueEntry) : void
      {
         var _loc2_:int = popupQueue.indexOf(param1);
         if(_loc2_ != -1)
         {
            popupQueue.splice(_loc2_,1);
         }
      }
   }
}
