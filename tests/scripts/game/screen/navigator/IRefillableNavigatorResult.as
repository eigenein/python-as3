package game.screen.navigator
{
   import idv.cjcat.signals.Signal;
   
   public interface IRefillableNavigatorResult
   {
       
      
      function get signal_refillComplete() : Signal;
      
      function get signal_refillCancel() : Signal;
      
      function set closeAfterRefill(param1:Boolean) : void;
   }
}
