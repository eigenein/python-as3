package game.mediator.gui.tooltip
{
   import starling.display.DisplayObject;
   
   public interface ITooltipSource
   {
       
      
      function get tooltipVO() : TooltipVO;
      
      function get graphics() : DisplayObject;
   }
}
