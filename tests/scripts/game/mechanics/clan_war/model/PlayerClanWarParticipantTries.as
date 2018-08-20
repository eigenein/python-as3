package game.mechanics.clan_war.model
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import org.osflash.signals.Signal;
   
   public class PlayerClanWarParticipantTries
   {
       
      
      private var _tries:Dictionary;
      
      public const signal_triesUpdated:Signal = new Signal();
      
      private var _personalTriesSum:IntPropertyWriteable;
      
      private var _clanTries:IntPropertyWriteable;
      
      private var _clanTriesMax:int;
      
      private var _displayValue_maxTries:IntPropertyWriteable;
      
      private var _displayValue_triesLeft:IntPropertyWriteable;
      
      public function PlayerClanWarParticipantTries(param1:Object, param2:int)
      {
         _personalTriesSum = new IntPropertyWriteable();
         _clanTries = new IntPropertyWriteable();
         _displayValue_maxTries = new IntPropertyWriteable();
         _displayValue_triesLeft = new IntPropertyWriteable();
         super();
         _clanTriesMax = param2;
         setupTriesFromObject(param1);
      }
      
      public function get personalTriesSum() : IntProperty
      {
         return _personalTriesSum;
      }
      
      public function get clanTries() : IntProperty
      {
         return _clanTries;
      }
      
      public function get clanTriesMax() : int
      {
         return _clanTriesMax;
      }
      
      public function get personalTriesMaxSum() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _tries;
         for(var _loc2_ in _tries)
         {
            _loc1_++;
         }
         return _loc1_ * DataStorage.rule.clanWarRule.personalAttackLimit;
      }
      
      public function get userTriesMax() : int
      {
         return DataStorage.rule.clanWarRule.personalAttackLimit;
      }
      
      public function get displayValue_maxTries() : IntProperty
      {
         return _displayValue_maxTries;
      }
      
      public function get displayValue_triesLeft() : IntProperty
      {
         return _displayValue_triesLeft;
      }
      
      public function getUserIsParticipant(param1:String) : Boolean
      {
         return _tries[param1] !== undefined;
      }
      
      public function getUserTries(param1:String) : int
      {
         return _tries[param1];
      }
      
      public function decrementUserTries(param1:String) : void
      {
         var _loc2_:* = _tries;
         var _loc3_:* = param1;
         var _loc4_:* = Number(_loc2_[_loc3_]) - 1;
         _loc2_[_loc3_] = _loc4_;
         updateTries();
      }
      
      protected function setupTriesFromObject(param1:Object) : void
      {
         _tries = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            if(_loc2_ != "clan")
            {
               _tries[_loc2_] = param1[_loc2_];
            }
         }
         _clanTries.value = param1.clan;
         updateTries();
      }
      
      protected function updateTries() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = _tries;
         for(var _loc3_ in _tries)
         {
            _loc2_ = _loc2_ + _tries[_loc3_];
         }
         _personalTriesSum.value = _loc2_;
         _displayValue_maxTries.value = _clanTriesMax;
         if(personalTriesMaxSum <= _clanTriesMax)
         {
            _displayValue_triesLeft.value = _personalTriesSum.value;
         }
         else
         {
            _loc1_ = personalTriesMaxSum - personalTriesSum.value;
            _displayValue_triesLeft.value = displayValue_maxTries.value - _loc1_;
         }
         signal_triesUpdated.dispatch();
      }
   }
}
