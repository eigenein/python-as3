package game.mediator.gui.tooltip
{
   import starling.display.DisplayObjectContainer;
   
   public interface ITooltipView
   {
       
      
      function show(param1:ITooltipSource, param2:DisplayObjectContainer) : void;
      
      function hide() : void;
      
      function placeHint(param1:ITooltipSource, param2:DisplayObjectContainer) : void;
      
      function placeSelf(param1:ITooltipSource, param2:DisplayObjectContainer) : void;
   }
}
