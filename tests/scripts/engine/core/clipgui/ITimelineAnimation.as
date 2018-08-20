package engine.core.clipgui
{
   public interface ITimelineAnimation
   {
       
      
      function get length() : Number;
      
      function setFrame(param1:int) : void;
      
      function advanceTimeTo(param1:Number) : void;
   }
}
