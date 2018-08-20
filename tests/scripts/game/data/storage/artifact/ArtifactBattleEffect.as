package game.data.storage.artifact
{
   import battle.BattleStats;
   import flash.utils.Dictionary;
   
   public class ArtifactBattleEffect
   {
       
      
      private var _id:uint;
      
      public const levels:Dictionary = new Dictionary();
      
      public function ArtifactBattleEffect()
      {
         super();
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function deserialize(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         _id = param1.id;
         if(param1.battleStatData && param1.battleStatData.levels)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.battleStatData.levels;
            for(var _loc4_ in param1.battleStatData.levels)
            {
               _loc5_ = new BattleStats();
               _loc2_ = param1.battleStatData.levels[_loc4_];
               var _loc7_:int = 0;
               var _loc6_:* = _loc2_;
               for(var _loc3_ in _loc2_)
               {
                  _loc5_[_loc3_] = _loc5_[_loc3_] + _loc2_[_loc3_];
               }
               levels[_loc4_] = _loc5_;
            }
         }
      }
   }
}
