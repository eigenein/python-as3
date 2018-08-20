package game.model
{
   import game.command.rpc.RPCCommandBase;
   
   public class SplitResolver
   {
       
      
      public function SplitResolver()
      {
         super();
      }
      
      public static function applySplitData(param1:Object, param2:RPCCommandBase) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:Object = param2.result.data["splitGetAll"];
         if(_loc5_ == null)
         {
            return;
         }
         var _loc13_:int = 0;
         var _loc12_:* = _loc5_;
         for each(var _loc3_ in _loc5_)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _loc3_;
            for(var _loc7_ in _loc3_)
            {
               _loc6_ = param1;
               var _loc9_:int = 0;
               var _loc8_:* = _loc7_.split("_");
               for each(var _loc4_ in _loc7_.split("_"))
               {
                  _loc6_ = _loc6_[_loc4_];
               }
               if(_loc6_)
               {
                  applySplitToTable(_loc6_,_loc3_[_loc7_],_loc7_ == "rule");
               }
               else
               {
                  trace("SplitResolver:","no such table",_loc7_);
               }
            }
         }
      }
      
      protected static function applySplitToTable(param1:*, param2:*, param3:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc11_:int = 0;
         var _loc10_:* = param2;
         for(var _loc7_ in param2)
         {
            _loc4_ = param1[_loc7_];
            _loc6_ = param2[_loc7_];
            if(param3 || _loc4_ == null)
            {
               param1[_loc7_] = _loc6_;
            }
            else
            {
               var _loc9_:int = 0;
               var _loc8_:* = _loc6_;
               for(var _loc5_ in _loc6_)
               {
                  _loc4_[_loc5_] = _loc6_[_loc5_];
               }
            }
         }
      }
   }
}
