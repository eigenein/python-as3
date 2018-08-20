package game.model.user.refillable
{
   import game.data.storage.refillable.RefillableDescription;
   
   public class PlayerEliteMissionRefillableEntry extends PlayerRefillableEntry
   {
       
      
      public function PlayerEliteMissionRefillableEntry(param1:Object, param2:RefillableDescription, param3:PlayerRefillableVIPSource)
      {
         super(null,param2,param3);
         _id = param2.id;
         if(param1)
         {
            _value = maxValue - int(param1.triesSpent);
            _refillCount = param1.resetToday;
         }
         else
         {
            _value = maxValue;
         }
      }
      
      public function reset() : void
      {
         if(_value != maxValue || _refillCount != 0)
         {
            _value = maxValue;
            _refillCount = 0;
            _signal_update.dispatch();
         }
      }
      
      public function refill() : void
      {
         _value = _value + refillAmount;
         _refillCount = Number(_refillCount) + 1;
         _signal_update.dispatch();
      }
      
      public function spendEliteMission(param1:int) : void
      {
         _value = _value - param1;
         _signal_update.dispatch();
      }
   }
}
