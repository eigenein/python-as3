package game.data.storage.rule
{
   import engine.core.utils.VectorUtil;
   
   public class QuestHeroAdviceTimerConfigRule
   {
       
      
      private var daysSinceLastLogin:Object;
      
      private var indices:Array;
      
      private var _minPlayerLevel:int;
      
      private var _onScreenTime:int;
      
      public function QuestHeroAdviceTimerConfigRule(param1:Object)
      {
         var _loc3_:* = 0;
         super();
         this.daysSinceLastLogin = param1.daysSinceLastLogin;
         this._minPlayerLevel = param1.minPlayerLevel;
         this._onScreenTime = param1.adviceOnScreenTime * 1000;
         indices = [];
         var _loc5_:int = 0;
         var _loc4_:* = daysSinceLastLogin;
         for(_loc3_ in daysSinceLastLogin)
         {
            indices.push(_loc3_);
         }
         indices.sort(VectorUtil.sortInt);
      }
      
      public function get minPlayerLevel() : int
      {
         return _minPlayerLevel;
      }
      
      public function get onScreenTime() : int
      {
         return _onScreenTime;
      }
      
      public function getInitialInterval(param1:int) : int
      {
         var _loc2_:int = getDayIndex(param1);
         if(!daysSinceLastLogin[_loc2_])
         {
            return 5000;
         }
         return daysSinceLastLogin[_loc2_].initialAdviceTimer * 1000;
      }
      
      public function getRepeatInterval(param1:int) : int
      {
         var _loc2_:int = getDayIndex(param1);
         if(!daysSinceLastLogin[_loc2_])
         {
            return 20000;
         }
         return daysSinceLastLogin[_loc2_].adviceRepeatTimer * 1000;
      }
      
      private function getDayIndex(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1 / 86400;
         var _loc2_:int = indices.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_ <= indices[_loc4_] || _loc4_ == _loc2_ - 1)
            {
               return indices[_loc4_];
            }
            _loc4_++;
         }
         return indices[indices.length - 1];
      }
   }
}
