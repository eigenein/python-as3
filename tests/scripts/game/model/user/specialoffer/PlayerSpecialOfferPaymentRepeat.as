package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.VectorUtil;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingBenefitValueObject;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.BillingPopupValueObjectWithBonus;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.stat.Stash;
   import game.view.popup.reward.GuiElementExternalStyle;
   import starling.textures.Texture;
   
   public class PlayerSpecialOfferPaymentRepeat extends PlayerSpecialOfferWithTimer
   {
       
      
      protected var billingIds:Vector.<int>;
      
      protected var billingSlot:int;
      
      protected var multiplier:Number;
      
      protected var multiplierString:String;
      
      protected var excludedBillingIds:Array;
      
      public function PlayerSpecialOfferPaymentRepeat(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function get billingBackgroundTexture() : Texture
      {
         return AssetStorage.rsx.getTexture(clientData.billingBackgroundTexture,clientData.billingBackgroundImageAtlas);
      }
      
      public function get saleValueString() : String
      {
         return multiplierString;
      }
      
      public function get asset() : RsxGuiAsset
      {
         return AssetStorage.rsx.getByName(clientData.assetIdent) as RsxGuiAsset;
      }
      
      public function get assetClipOnResourcePanel() : String
      {
         return clientData.assetClipOnResourcePanel;
      }
      
      public function get assetClipOnBilling() : String
      {
         return clientData.assetClipOnBilling;
      }
      
      public function get assetClipOnBillingDouble() : String
      {
         return clientData.assetClipOnBillingDouble;
      }
      
      public function get billingDoubleText() : String
      {
         if(clientData.locale && clientData.locale.billingDoubleText && Translate.has(clientData.locale.billingDoubleText))
         {
            return Translate.translate(clientData.locale.billingDoubleText);
         }
         return "";
      }
      
      public function get hideDefaultSaleSticker() : Boolean
      {
         return clientData.hideDefaultSaleSticker;
      }
      
      public function get title() : String
      {
         return Translate.translate(clientData.locale.title);
      }
      
      public function getMinSlotBilling() : PlayerBillingDescription
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = billingIds;
         for each(var _loc1_ in billingIds)
         {
            _loc3_ = player.billingData.getById(_loc1_);
            if(_loc2_ == null || _loc3_.slot < _loc2_.slot)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      public function get doubleBillingMode() : Boolean
      {
         return billingIds.length > 1;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.hooks.billings.add(handler_billings);
         param1.hooks.billingBenefits.add(handler_billingBenefits);
         param1.invalidateBillings();
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.billings.remove(handler_billings);
         param1.hooks.billingBenefits.remove(handler_billingBenefits);
         param1.invalidateBillings();
      }
      
      override public function updateExisting(param1:*) : void
      {
         update(param1);
         player.specialOffer.invalidateBillings();
      }
      
      override protected function update(param1:*) : void
      {
         billingIds = Vector.<int>(param1.billingIds);
         multiplier = param1.multiplier;
         billingSlot = param1.offerData.billingSlot;
         if(param1.clientData.multiplier)
         {
            multiplierString = param1.clientData.multiplier;
         }
         else
         {
            multiplierString = "x" + param1.multiplier;
         }
         excludedBillingIds = param1.excludedBillingIds;
         super.update(param1);
      }
      
      protected function overlayFactory() : GuiElementExternalStyle
      {
         return null;
      }
      
      protected function hasBillingId(param1:int) : Boolean
      {
         return billingIds.indexOf(param1) != -1;
      }
      
      private function handler_billings(param1:Vector.<BillingPopupValueObject>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = param1.length;
         var _loc6_:PlayerBillingDescription = this.getMinSlotBilling();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(excludedBillingIds && excludedBillingIds.indexOf(_loc5_.desc.id) != -1)
            {
               _loc5_.dispose();
               VectorUtil.removeAt(param1,_loc4_);
               _loc4_--;
               _loc3_--;
            }
            else if(hasBillingId(_loc5_.desc.id) || _loc5_.desc.slot == billingSlot)
            {
               _loc2_ = new BillingPopupValueObjectWithBonus(_loc5_.desc,player,this);
               _loc2_.bonus = (multiplier - 1) * _loc5_.mainStarmoneyReward;
               if(!doubleBillingMode || _loc5_.desc.slot == _loc6_.slot)
               {
                  _loc2_.externalStyleFactory = overlayFactory;
               }
               _loc5_.dispose();
               param1[_loc4_] = _loc2_;
            }
            _loc4_++;
         }
      }
      
      protected function handler_billingBenefits(param1:BillingPopupValueObject, param2:Vector.<BillingBenefitValueObject>) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(hasBillingId(param1.desc.id) && param1 is BillingPopupValueObjectWithBonus)
         {
            _loc3_ = param1 as BillingPopupValueObjectWithBonus;
            _loc5_ = multiplierString + " " + Translate.translate("UI_SPECIALOFFER_SPECIAL_OFFER");
            _loc6_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               if(!param2[_loc4_].showGemIcon || _loc4_ == _loc6_ - 1)
               {
                  param2.splice(_loc4_,0,new BillingBenefitValueObject(true,"+" + _loc3_.bonus,_loc5_));
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function handler_iconClick() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "global";
         PopupList.instance.dialog_bank(Stash.click("specialOffer:" + id,_loc1_));
      }
   }
}
