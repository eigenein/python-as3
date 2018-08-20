package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.homescreen.HomeScreenGuiChestClipButton;
   import game.view.popup.chest.TownChestFullscreenPopupClip;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.costreplacetownchestpack.SpecialOfferCostReplaceTownChestPackButtonClip;
   import game.view.specialoffer.costreplacetownchestpack.SpecialOfferCostReplaceTownChestPackChestIconView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObject;
   
   public class PlayerSpecialOfferCostReplaceTownChestPack extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "costReplaceTownChestPack";
       
      
      public function PlayerSpecialOfferCostReplaceTownChestPack(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function get assetIdent() : String
      {
         return clientData.assetIdent;
      }
      
      public function get assetClipChestOverlay() : String
      {
         return clientData.assetClipChestOverlay;
      }
      
      public function get assetClipHomeScreenChestOverlay() : String
      {
         return clientData.assetClipHomeScreenChestOverlay;
      }
      
      public function get assetClipButtonBuy() : String
      {
         return clientData.assetClipButtonBuy;
      }
      
      public function get localeSale() : String
      {
         var _loc1_:String = ColorUtils.hexToRGBFormat(16776960);
         var _loc2_:String = ColorUtils.hexToRGBFormat(16449533);
         return Translate.translateArgs(localeSaleKey,_loc1_ + saleDiscountString + _loc2_);
      }
      
      public function get localeSaleKey() : String
      {
         return clientData.locale.sale;
      }
      
      public function get localeTitleKey() : String
      {
         return clientData.locale.title;
      }
      
      public function get saleDiscountString() : String
      {
         return clientData.saleDiscountString;
      }
      
      public function get oldCost() : CostData
      {
         if(clientData.oldCost)
         {
            return new CostData(clientData.oldCost);
         }
         return DataStorage.chest.CHEST_TOWN.packCost;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.getByName(assetIdent),handler_assetLoaded);
         param1.costReplace.addModifier(id,offerData);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.homeScreenChest.remove(handler_homeScreenChest);
         param1.hooks.chestPopupChestIcon.remove(handler_chestPopupChestIcon);
         param1.hooks.townChestFullscreenPopupClip.remove(handler_chestPopupClip);
         param1.costReplace.removeModifier(id);
      }
      
      protected function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         player.specialOffer.hooks.homeScreenChest.add(handler_homeScreenChest);
         player.specialOffer.hooks.chestPopupChestIcon.add(handler_chestPopupChestIcon);
         player.specialOffer.hooks.townChestFullscreenPopupClip.add(handler_chestPopupClip);
      }
      
      protected function handler_chestPopupClip(param1:TownChestFullscreenPopupClip) : void
      {
         var _loc5_:RsxGuiAsset = AssetStorage.rsx.getByName(assetIdent) as RsxGuiAsset;
         var _loc3_:CostButton = param1.cost_button_pack;
         var _loc2_:ClipLabel = param1.tf_chest_desc;
         _loc3_.graphics.removeFromParent(true);
         _loc2_.graphics.removeFromParent(true);
         var _loc6_:SpecialOfferCostReplaceTownChestPackButtonClip = _loc5_.create(SpecialOfferCostReplaceTownChestPackButtonClip,assetClipButtonBuy);
         _loc6_.graphics.x = _loc3_.graphics.x;
         _loc6_.graphics.y = _loc3_.graphics.y;
         var _loc4_:int = param1.container.getChildIndex(param1.cost_button_pack.graphics);
         param1.container.addChildAt(_loc6_.graphics,_loc4_ + 1);
         param1.cost_button_pack = _loc6_.cost_button_pack;
         _loc6_.cost_button_pack.oldCost = oldCost.outputDisplay[0];
         param1.tf_chest_desc = _loc6_.tf_sale_old;
         _loc6_.tf_sale.text = localeSale;
      }
      
      protected function handler_chestPopupChestIcon(param1:DisplayObject) : void
      {
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName(assetIdent) as RsxGuiAsset;
         var _loc3_:SpecialOfferCostReplaceTownChestPackChestIconView = new SpecialOfferCostReplaceTownChestPackChestIconView(this,assetClipChestOverlay);
         _loc3_.displayStyle.setNextAbove(_loc3_.graphics,new RelativeAlignment());
         _loc3_.displayStyle.apply(param1,param1.parent.parent,param1.parent.parent);
      }
      
      protected function handler_homeScreenChest(param1:HomeScreenGuiChestClipButton) : void
      {
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName(assetIdent) as RsxGuiAsset;
         var _loc3_:SpecialOfferCostReplaceTownChestPackChestIconView = new SpecialOfferCostReplaceTownChestPackChestIconView(this,assetClipHomeScreenChestOverlay);
         _loc3_.displayStyle.setNextAbove(_loc3_.graphics,new RelativeAlignment());
         _loc3_.displayStyle.apply(param1.container,param1.container.parent,param1.container.parent);
      }
   }
}
