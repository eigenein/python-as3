package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.specialoffer.bundlereward.SpecialOfferBundleRewardOnIconView;
   import game.view.specialoffer.bundlereward.SpecialOfferBundleRewardOnPopupView;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class PlayerSpecialOfferBundleReward extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "bundleReward";
       
      
      public function PlayerSpecialOfferBundleReward(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function get asset() : RsxGuiAsset
      {
         return AssetStorage.rsx.getByName(clientData.assetIdent) as RsxGuiAsset;
      }
      
      public function get assetClipOnIcon() : String
      {
         return clientData.assetClipOnIcon;
      }
      
      public function get assetClipOnPopup() : String
      {
         return clientData.assetClipOnPopup;
      }
      
      public function get title() : String
      {
         return Translate.translate(clientData.locale.title);
      }
      
      public function get reward() : RewardData
      {
         var _loc6_:* = null;
         var _loc1_:int = 0;
         var _loc4_:Number = offerData.modifier.multiplier;
         var _loc5_:String = offerData.modifier.from;
         try
         {
            _loc6_ = player.billingData.bundleData.activeBundle;
            _loc1_ = _loc6_.desc.reward[_loc5_];
            _loc4_ = _loc4_ * _loc1_;
         }
         catch(e:*)
         {
         }
         var _loc7_:Object = offerData.modifier.to;
         var _loc3_:Object = RewardData.multiplyRawReward(_loc7_,_loc4_);
         var _loc2_:RewardData = new RewardData();
         return new RewardData(_loc3_);
      }
      
      public function get rewardItem() : InventoryItem
      {
         var _loc1_:Vector.<InventoryItem> = reward.outputDisplay;
         if(_loc1_.length > 0)
         {
            return _loc1_[0];
         }
         return new InventoryItem(null,0);
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.hooks.billingSideBarIcon.add(handler_billingSideBarIcon);
         param1.hooks.bundlePopupSpecialOffer.add(handler_bundlePopupSpecialOffer);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.billingSideBarIcon.remove(handler_billingSideBarIcon);
         param1.hooks.bundlePopupSpecialOffer.remove(handler_bundlePopupSpecialOffer);
      }
      
      protected function handler_billingSideBarIcon(param1:DisplayObject) : void
      {
         var _loc2_:SpecialOfferBundleRewardOnIconView = new SpecialOfferBundleRewardOnIconView(this);
         _loc2_.displayStyle.apply(param1,param1.parent,param1.parent);
      }
      
      protected function handler_bundlePopupSpecialOffer(param1:DisplayObject) : void
      {
         var _loc2_:* = null;
         if(!reward.isEmpty)
         {
            _loc2_ = new SpecialOfferBundleRewardOnPopupView(this);
            _loc2_.displayStyle.apply(param1,param1 as DisplayObjectContainer,param1 as DisplayObjectContainer);
         }
      }
   }
}
