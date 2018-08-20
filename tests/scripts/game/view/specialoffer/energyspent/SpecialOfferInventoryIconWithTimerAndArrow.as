package game.view.specialoffer.energyspent
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.reward.RewardData;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.model.user.specialoffer.PlayerSpecialOfferEnergySpent;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferViewSlotEntry;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TitleAndDescriptionTooltip;
   import game.view.gui.components.tooltip.TitleAndDescriptionValueObject;
   import game.view.popup.reward.GuiElementExternalStyle;
   
   public class SpecialOfferInventoryIconWithTimerAndArrow extends GuiClipNestedContainer implements ISpecialOfferViewSlotObject
   {
       
      
      private var offer:PlayerSpecialOfferWithTimer;
      
      private var entry:SpecialOfferViewSlotEntry;
      
      private var _externalStyle:GuiElementExternalStyle;
      
      public var tf_timer:ClipLabel;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public var arrow:Vector.<ClipSpriteUntouchable>;
      
      public var black_plate:ClipSpriteUntouchable;
      
      public function SpecialOfferInventoryIconWithTimerAndArrow(param1:PlayerSpecialOfferWithTimer, param2:SpecialOfferViewSlotEntry)
      {
         var _loc3_:* = null;
         super();
         this.offer = param1;
         this.entry = param2;
         var _loc5_:RsxGuiAsset = AssetStorage.rsx.getByName(param2.assetIdent) as RsxGuiAsset;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc5_,handler_assetLoaded);
         var _loc4_:PlayerSpecialOfferEnergySpent = param1 as PlayerSpecialOfferEnergySpent;
         if(_loc4_)
         {
            _loc3_ = new TitleAndDescriptionValueObject(_loc4_.localeTitle,_loc4_.localeDesc);
            TooltipHelper.addTooltip(graphics,new TooltipVO(TitleAndDescriptionTooltip,_loc3_));
         }
         _externalStyle = new GuiElementExternalStyle();
         _externalStyle.setNextAbove(graphics,param2.createAlignment());
         _externalStyle.signal_dispose.add(dispose);
      }
      
      public function dispose() : void
      {
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         if(offer)
         {
            offer.signal_updated.remove(handler_updateProgress);
         }
         TooltipHelper.removeTooltip(graphics);
         graphics.dispose();
      }
      
      public function get externalStyle() : GuiElementExternalStyle
      {
         return _externalStyle;
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         param1.initGuiClip(this,entry.assetClip);
         offer.signal_updated.add(handler_updateProgress);
         handler_updateProgress();
         if(arrow)
         {
            _loc3_ = entry.params.arrowDirection;
            _loc4_ = 0;
            while(_loc4_ < arrow.length)
            {
               arrow[_loc4_].graphics.visible = _loc4_ == _loc3_;
               _loc4_++;
            }
         }
         if(entry.params.reward)
         {
            _loc2_ = new RewardData(entry.params.reward).outputDisplay[0];
            image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(_loc2_);
            image_item.image.texture = AssetStorageUtil.getItemTexture(_loc2_);
         }
      }
      
      private function handler_updateProgress() : void
      {
         if(offer.hasEndTime)
         {
            tf_timer.text = offer.timerStringConstrained;
            black_plate.graphics.visible = true;
         }
         else
         {
            tf_timer.text = "";
            black_plate.graphics.visible = false;
         }
      }
   }
}
