package game.model.user.specialoffer
{
   import engine.core.clipgui.IGuiClip;
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.view.popup.artifactchest.ArtifactChestPopupClip;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.refillable.CostButtonWithSale;
   import game.view.popup.summoningcircle.SummoningCirclePopUpClip;
   import game.view.specialoffer.blackfriday2017.SpecialOfferBlackFriday2017PopupMediator;
   import game.view.specialoffer.costreplacetownchestpack.SpecialOfferCostReplaceTownChestPackButtonClip;
   import starling.display.DisplayObjectContainer;
   
   public class PlayerSpecialOfferCostReplaceAllChests extends PlayerSpecialOfferCostReplaceTownChestPack
   {
      
      public static const OFFER_TYPE:String = "costReplaceAllChests";
       
      
      private const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(5);
      
      private var _popupClip:AssetClipLink;
      
      public function PlayerSpecialOfferCostReplaceAllChests(param1:Player, param2:*)
      {
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_openPopup);
      }
      
      public function get popupClip() : AssetClipLink
      {
         return _popupClip;
      }
      
      public function get localeDescKey() : String
      {
         return clientData.locale.desc;
      }
      
      public function get summoningCircleDiscountString() : String
      {
         return clientData.summoningCircleDiscountString;
      }
      
      public function get artifactChestDiscountString() : String
      {
         return clientData.artifactChestDiscountString;
      }
      
      public function get defaultBillingSale() : String
      {
         return clientData.defaultBillingSale;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         if(_sideBarIcon)
         {
            _sideBarIcon.signal_click.add(handler_openPopup);
         }
         param1.addAutoPopup(autoPopupQueueEntry);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
         player.specialOffer.hooks.summoningCirclePopupClip.remove(handler_summoningCirclePopupClip);
         player.specialOffer.hooks.artifactChestPopupClip.remove(handler_artifactChestPopupClip);
      }
      
      protected function createPopup() : PopupMediator
      {
         return new SpecialOfferBlackFriday2017PopupMediator(player,this,int(clientData.offerChestId),int(clientData.offerBillingId));
      }
      
      override protected function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         super.handler_assetLoaded(param1);
         player.specialOffer.hooks.summoningCirclePopupClip.add(handler_summoningCirclePopupClip);
         player.specialOffer.hooks.artifactChestPopupClip.add(handler_artifactChestPopupClip);
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         _popupClip = new AssetClipLink(AssetStorage.rsx.getByName(clientData.popup.asset),clientData.popup.clip);
      }
      
      protected function replaceCostButon(param1:IGuiClip, param2:IGuiClip) : void
      {
         var _loc3_:DisplayObjectContainer = param1.graphics.parent;
         var _loc4_:int = _loc3_.getChildIndex(param1.graphics);
         param1.graphics.removeFromParent(true);
         _loc3_.addChildAt(param2.graphics,_loc4_ + 1);
         param2.graphics.x = param1.graphics.x;
         param2.graphics.y = param1.graphics.y;
      }
      
      protected function handler_summoningCirclePopupClip(param1:SummoningCirclePopUpClip) : void
      {
         var _loc4_:RsxGuiAsset = AssetStorage.rsx.getByName(assetIdent) as RsxGuiAsset;
         var _loc3_:CostButton = param1.cost_button_pack;
         var _loc5_:SpecialOfferCostReplaceTownChestPackButtonClip = _loc4_.create(SpecialOfferCostReplaceTownChestPackButtonClip,assetClipButtonBuy);
         replaceCostButon(_loc3_,_loc5_.cost_button_pack);
         param1.cost_button_pack = _loc5_.cost_button_pack;
         _loc5_.cost_button_pack.oldCost = DataStorage.clanSummoningCircle.defaultCircle.cost_pack.outputDisplayFirst;
         var _loc2_:CostButton = param1.cost_button_pack10;
         var _loc6_:SpecialOfferCostReplaceTownChestPackButtonClip = _loc4_.create(SpecialOfferCostReplaceTownChestPackButtonClip,assetClipButtonBuy);
         replaceCostButon(_loc2_,_loc6_.cost_button_pack);
         param1.cost_button_pack10 = _loc6_.cost_button_pack;
         _loc6_.cost_button_pack.oldCost = DataStorage.clanSummoningCircle.defaultCircle.cost_pack_x10.outputDisplayFirst;
      }
      
      protected function handler_artifactChestPopupClip(param1:ArtifactChestPopupClip) : void
      {
         var _loc2_:RsxGuiAsset = AssetStorage.rsx.getByName(assetIdent) as RsxGuiAsset;
         var _loc3_:CostButtonWithSale = _loc2_.create(CostButtonWithSale,"green_cost_button_145_wide_custom");
         replaceCostButon(param1.cost_button_pack,_loc3_);
         param1.cost_button_pack = _loc3_;
         _loc3_.oldCost = DataStorage.rule.artifactChestRule.openCostX10.outputDisplayFirst;
         _loc3_ = _loc2_.create(CostButtonWithSale,"green_cost_button_145_wide_custom");
         replaceCostButon(param1.cost_button_pack100,_loc3_);
         param1.cost_button_pack100 = _loc3_;
         _loc3_.oldCost = DataStorage.rule.artifactChestRule.openCostX100.outputDisplayFirst;
      }
      
      private function handler_openPopup(param1:PopupStashEventParams) : void
      {
         createPopup().open(param1);
      }
   }
}
