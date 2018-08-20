package game.battle.controller
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import idv.cjcat.signals.Signal;
   
   public class BattleProgressInfo
   {
       
      
      private var _wavesCount:int;
      
      private var _battleDuration:int;
      
      private var _timeLeft:IntPropertyWriteable;
      
      private var _waveIndex:IntPropertyWriteable;
      
      private var _signal_progress:Signal;
      
      public const timeLeft:IntProperty = _timeLeft;
      
      public const waveIndex:IntProperty = _waveIndex;
      
      public function BattleProgressInfo()
      {
         _timeLeft = new IntPropertyWriteable();
         _waveIndex = new IntPropertyWriteable();
         super();
      }
      
      public function get waveCount() : int
      {
         return _wavesCount;
      }
      
      public function get signal_progress() : Signal
      {
         if(_signal_progress)
         {
            return _signal_progress;
         }
         _signal_progress = new Signal(int,Number);
         return new Signal(int,Number);
      }
      
      public function setup(param1:int, param2:int) : void
      {
         _wavesCount = param1;
         _battleDuration = param2;
      }
      
      public function setWave(param1:int) : void
      {
         _waveIndex.value = param1;
         _timeLeft.value = _battleDuration;
      }
      
      public function setTime(param1:Number) : void
      {
         _timeLeft.value = _battleDuration - int(param1);
         if(_signal_progress)
         {
            _signal_progress.dispatch(_waveIndex.value,param1);
         }
      }
   }
}
