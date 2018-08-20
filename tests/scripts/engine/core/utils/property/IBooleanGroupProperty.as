package engine.core.utils.property
{
   public interface IBooleanGroupProperty
   {
       
      
      function get value() : Array;
      
      function onValue(param1:Function) : void;
      
      function unsubscribe(param1:Function) : void;
   }
}
