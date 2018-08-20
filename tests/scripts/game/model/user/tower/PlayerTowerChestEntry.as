package game.model.user.tower
{
   import game.data.reward.RewardData;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTowerChestEntry
   {
       
      
      public const signal_updated:Signal = new Signal();
      
      public const signal_costUpdated:Signal = new Signal();
      
      private var _num:int;
      
      private var _opened:Boolean;
      
      private var _reward:RewardData;
      
      private var _critMultiplier:Number;
      
      public function PlayerTowerChestEntry(param1:* = null)
      {
         super();
         if(param1)
         {
            parseRawData(param1);
         }
      }
      
      public function get critMultiplier() : Number
      {
         return _critMultiplier;
      }
      
      public function get num() : int
      {
         return _num;
      }
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function parseRawData(param1:* = null) : void
      {
         _num = param1.num;
         _opened = param1.opened;
         _critMultiplier = param1.critMultiplier;
         if(_opened)
         {
            _reward = new RewardData(param1.reward);
         }
         else
         {
            _reward = null;
         }
         signal_updated.dispatch();
      }
      
      public function updateWithReward(param1:RewardData, param2:Boolean, param3:Number) : void
      {
         _reward = param1;
         _opened = param2;
         _critMultiplier = param3;
         signal_updated.dispatch();
      }
   }
}
