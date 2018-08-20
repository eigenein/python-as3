package feathers.controls
{
   import feathers.core.IFeathersControl;
   
   [Event(name="change",type="starling.events.Event")]
   public interface IRange extends IFeathersControl
   {
       
      
      function get minimum() : Number;
      
      function set minimum(param1:Number) : void;
      
      function get maximum() : Number;
      
      function set maximum(param1:Number) : void;
      
      function get value() : Number;
      
      function set value(param1:Number) : void;
      
      function get step() : Number;
      
      function set step(param1:Number) : void;
   }
}
