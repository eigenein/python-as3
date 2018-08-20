package game.mediator.gui.popup.resourcepanel
{
   import game.command.timer.GameTimer;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.util.NumberUtils;
   import game.view.popup.common.resourcepanel.ResourcePanelRefillableTooltipView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ResourcePanelRefillableTooltipData extends ResourcePanelTooltipData
   {
       
      
      private var refillable:PlayerRefillableEntry;
      
      public function ResourcePanelRefillableTooltipData(param1:ResourcePanelValueObject, param2:PlayerRefillableEntry)
      {
         super(param1);
         this.refillable = param2;
         _rendererType = ResourcePanelRefillableTooltipView;
         GameTimer.instance.oneSecTimer.add(handler_time);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_time);
         refillable = null;
      }
      
      override public function get text() : String
      {
         if(!refillable)
         {
            return "";
         }
         if(refillable.maxValue)
         {
            return parentData.item.name + ": " + ColorUtils.hexToRGBFormat(16383999) + NumberUtils.numberToString(parentData.amount) + "/" + refillable.maxValue;
         }
         return super.text;
      }
      
      public function get refillsLeft() : int
      {
         if(!refillable)
         {
            return 0;
         }
         return refillable.maxRefillCount - refillable.refillCount;
      }
      
      public function get refillsMax() : int
      {
         if(!refillable)
         {
            return 0;
         }
         return refillable.maxRefillCount;
      }
      
      public function get regenTimer() : int
      {
         if(!refillable)
         {
            return -1;
         }
         if(refillable.value < refillable.maxValue)
         {
            return refillable.refillTimeLeft;
         }
         return -1;
      }
      
      public function setRefillable(param1:PlayerRefillableEntry) : void
      {
         this.refillable = param1;
         _signal_updateText.dispatch();
      }
      
      private function handler_time() : void
      {
         if(regenTimer != -1)
         {
            _signal_updateText.dispatch();
         }
      }
   }
}
