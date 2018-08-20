package game.mediator.gui.tooltip
{
   import starling.display.DisplayObject;
   
   public class TooltipProxy implements ITooltipSource
   {
       
      
      private var viewClass:ITooltipView;
      
      private var _graphics:DisplayObject;
      
      private var _tooltipVO:TooltipVO;
      
      public function TooltipProxy(param1:DisplayObject, param2:TooltipVO)
      {
         super();
         this._tooltipVO = param2;
         this._graphics = param1;
      }
      
      public function get graphics() : DisplayObject
      {
         return _graphics;
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
   }
}
