package game.view.popup.hero.rune
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.rune.RuneTypeDescription;
   import game.mediator.gui.popup.rune.PlayerHeroRuneValueObject;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import starling.events.Event;
   
   public class RuneItemClipWithHint extends RuneItemClip implements ITooltipSource
   {
       
      
      private var _tooltipVO:TooltipVO;
      
      public function RuneItemClipWithHint()
      {
         _tooltipVO = new TooltipVO(TooltipTextView,"");
         super();
         isEnabled = false;
         graphics.touchable = true;
         graphics.useHandCursor = false;
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setData(param1:PlayerHeroRuneValueObject) : void
      {
         setupHint(param1);
         super.setData(param1);
      }
      
      protected function setupHint(param1:PlayerHeroRuneValueObject) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc5_ = param1.type;
            _loc2_ = Translate.translate("LIB_BATTLESTATDATA_" + _loc5_.stat.toUpperCase());
            _loc3_ = param1.level;
            if(_loc3_ > 0)
            {
               _loc4_ = _loc5_.getValueByLevel(_loc3_);
               _loc2_ = _loc2_ + (" +" + _loc4_);
            }
            showTooltip(_loc2_);
         }
         else
         {
            hideTooltip();
         }
      }
      
      protected function showTooltip(param1:String) : void
      {
         _tooltipVO.hintData = param1;
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
         if(graphics.stage != null)
         {
            TooltipLayerMediator.instance.addSource(this);
         }
      }
      
      protected function hideTooltip() : void
      {
         graphics.removeEventListener("addedToStage",handler_addedToStage);
         graphics.removeEventListener("removedFromStage",handler_removedFromStage);
         if(graphics.stage != null)
         {
            TooltipLayerMediator.instance.removeSource(this);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
   }
}
