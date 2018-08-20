package game.data.storage.subscription
{
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   
   public class SubscriptionDescription extends DescriptionBase
   {
       
      
      private var _reward:RewardData;
      
      private var _duration:int;
      
      private var _renewDuration:int;
      
      private var _networkIdent:Array;
      
      private var _ident:String;
      
      private var _levels:Vector.<SubscriptionLevelDescription>;
      
      public function SubscriptionDescription(param1:*)
      {
         super();
         _id = param1.id;
         _reward = new RewardData(param1.reward);
         _duration = param1.duration;
         _renewDuration = param1.renewDuration;
         _networkIdent = param1.networkIdent;
         _levels = new Vector.<SubscriptionLevelDescription>();
         var _loc2_:Object = param1.levels;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _levels.push(new SubscriptionLevelDescription(_loc3_,_loc2_[_loc3_]));
         }
         _ident = param1.ident;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get dailyReward() : RewardData
      {
         return _reward;
      }
      
      public function get renewDuration() : int
      {
         return _renewDuration;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get levels() : Vector.<SubscriptionLevelDescription>
      {
         return _levels;
      }
   }
}
