package game.battle.view.systems
{
   import org.osflash.signals.Signal;
   
   public interface IBattleDisposable
   {
       
      
      function get signal_dispose() : Signal;
      
      function advanceTime(param1:Number) : void;
   }
}
