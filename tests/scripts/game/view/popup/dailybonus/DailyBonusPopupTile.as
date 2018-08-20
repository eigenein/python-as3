package game.view.popup.dailybonus
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class DailyBonusPopupTile extends ListItemRenderer implements ITooltipSource
   {
      
      public static const INVALIDATION_FLAG_FARM:String = "INVALIDATION_FLAG_FARM";
       
      
      private var clip:DailyBonusPopupTileClip;
      
      public const signal_farm:Signal = new Signal(DailyBonusValueObject);
      
      private var _tooltipVO:TooltipVO;
      
      public function DailyBonusPopupTile()
      {
         super();
         _tooltipVO = new TooltipVO(InventoryItemInfoTooltip,null);
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         removeEventListener("addedToStage",handler_addedToStage);
         removeEventListener("removedFromStage",handler_removedFromStage);
         var _loc1_:DailyBonusValueObject = super.data as DailyBonusValueObject;
         if(_loc1_)
         {
            _loc1_.updateSignal.remove(onDataUpdate);
         }
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:DailyBonusValueObject = super.data as DailyBonusValueObject;
         if(_loc2_)
         {
            _loc2_.updateSignal.remove(onDataUpdate);
         }
         .super.data = param1;
         if(data)
         {
            _loc2_ = data as DailyBonusValueObject;
            _loc2_.updateSignal.add(onDataUpdate);
         }
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_renderer_daily_bonus();
         addChild(clip.graphics);
         addChild(clip.icon_check.graphics);
         clip.gem_reward.graphics.touchable = false;
         clip.inventory_item.graphics.touchable = false;
         clip.bg.signal_click.add(handler_farmClick);
         clip.bg_current_day.signal_click.add(handler_farmClick);
         width = clip.layout_quad.width;
         height = clip.layout_quad.height;
      }
      
      override protected function commitData() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc1_:DailyBonusValueObject = data as DailyBonusValueObject;
         if(_loc1_)
         {
            _tooltipVO.hintData = _loc1_.rewardItem;
            clip.tf_day.text = Translate.translateArgs("UI_DIALOG_DAILY_BONUS_DAY_N",_loc1_.day);
            var _loc4_:* = _loc1_.vipHasDoubleReward;
            clip.vip_plate.graphics.visible = _loc4_;
            clip.tf_vip.visible = _loc4_;
            _loc2_ = _loc1_.isGemReward;
            clip.gem_reward.graphics.visible = _loc2_;
            clip.inventory_item.graphics.visible = !_loc2_;
            if(_loc2_)
            {
               clip.gem_reward.item_counter.text = _loc1_.rewardItem.amount.toString();
               clip.gem_reward.item_counter.maxWidth = clip.inventory_item.item_image.image.width;
            }
            else
            {
               clip.inventory_item.data = _loc1_.rewardItem;
            }
            _loc3_ = !(_loc1_.rewardItem is InventoryFragmentItem) && _loc1_.rewardItem.item is HeroDescription;
            if(clip.sun_glow.graphics.parent && !_loc3_)
            {
               clip.container.removeChild(clip.sun_glow.graphics);
            }
            if(!clip.sun_glow.graphics.parent && _loc3_)
            {
               clip.container.addChildAt(clip.sun_glow.graphics,clip.container.getChildIndex(clip.inventory_item.graphics));
            }
            if(_loc1_.vipLevelDouble > 0)
            {
               clip.tf_vip.text = "VIP" + _loc1_.vipLevelDouble + " x2";
            }
            commitFarmState();
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("INVALIDATION_FLAG_FARM"))
         {
            commitFarmState();
         }
         super.draw();
      }
      
      private function commitFarmState() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:DailyBonusValueObject = data as DailyBonusValueObject;
         if(_loc2_)
         {
            _loc1_ = _loc2_.availableSingle || _loc2_.availableDouble;
            clip.bg_current_day.graphics.visible = _loc1_;
            clip.bg.graphics.visible = !_loc1_;
            clip.icon_check.graphics.visible = _loc2_.farmed;
            clip.layout_quad.visible = false;
            if(_loc2_.farmed)
            {
               if(!clip.graphics.filter)
               {
                  clip.graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
               }
            }
            else if(clip.graphics.filter)
            {
               clip.graphics.filter.dispose();
               clip.graphics.filter = null;
            }
            if(_loc1_)
            {
            }
         }
      }
      
      private function onDataUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_FARM");
      }
      
      private function handler_farmClick() : void
      {
         signal_farm.dispatch(data as DailyBonusValueObject);
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_ADDED",true);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true);
      }
   }
}
