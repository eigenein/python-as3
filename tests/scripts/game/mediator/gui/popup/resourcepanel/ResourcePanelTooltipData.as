package game.mediator.gui.popup.resourcepanel
{
   import game.util.NumberUtils;
   import game.view.popup.common.resourcepanel.ResourcePanelTooltipView;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ResourcePanelTooltipData
   {
       
      
      protected var parentData:ResourcePanelValueObject;
      
      protected var _rendererType:Class;
      
      protected var _signal_updateText:Signal;
      
      public function ResourcePanelTooltipData(param1:ResourcePanelValueObject)
      {
         _rendererType = ResourcePanelTooltipView;
         _signal_updateText = new Signal();
         super();
         this.parentData = param1;
         param1.signal_amountUpdate.add(handler_amountUpdate);
      }
      
      public function dispose() : void
      {
         parentData = null;
      }
      
      public function get rendererType() : Class
      {
         return _rendererType;
      }
      
      public function get signal_updateText() : Signal
      {
         return _signal_updateText;
      }
      
      public function get text() : String
      {
         return parentData.item.name + ": " + ColorUtils.hexToRGBFormat(16383999) + NumberUtils.numberToString(parentData.amount);
      }
      
      private function handler_amountUpdate(param1:ResourcePanelValueObject) : void
      {
         signal_updateText.dispatch();
      }
   }
}
