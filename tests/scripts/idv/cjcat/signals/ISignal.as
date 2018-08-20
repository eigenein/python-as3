package idv.cjcat.signals
{
   public interface ISignal
   {
       
      
      function add(param1:Function, param2:int = 0) : Function;
      
      function addOnce(param1:Function, param2:int = 0) : Function;
      
      function remove(param1:Function) : Function;
      
      function get valueClasses() : Array;
      
      function getPriority(param1:Function) : Number;
      
      function dispatch(... rest) : Signal;
      
      function clear() : void;
      
      function get listeners() : Array;
   }
}
