package game.model
{
   import game.command.rpc.RPCCommandBase;
   
   public class MissionReplaceResolver
   {
       
      
      public function MissionReplaceResolver()
      {
         super();
      }
      
      public static function applyMissionReplace(param1:Object, param2:RPCCommandBase) : void
      {
         var _loc7_:int = 0;
         var _loc5_:Object = param2.result.data["missionGetReplace"];
         var _loc4_:Object = param1.mission;
         if(_loc5_ != null)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc5_;
            for(var _loc6_ in _loc5_)
            {
               _loc7_ = _loc5_[_loc6_];
               _loc4_[_loc7_].id = _loc4_[_loc6_].id;
               _loc4_[_loc7_].isReplaceable = 3;
               _loc4_[_loc6_] = _loc4_[_loc7_];
               delete _loc4_[_loc7_];
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loc4_;
         for(var _loc3_ in _loc4_)
         {
            if(_loc4_[_loc3_].isReplaceable == 2)
            {
               delete _loc4_[_loc3_];
            }
         }
      }
   }
}
