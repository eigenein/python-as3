package feathers.controls
{
   [Event(name="change",type="starling.events.Event")]
   public interface IScrollBar extends IRange
   {
       
      
      function get page() : Number;
      
      function set page(param1:Number) : void;
   }
}
