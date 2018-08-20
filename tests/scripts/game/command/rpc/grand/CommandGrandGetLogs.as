package game.command.rpc.grand
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class CommandGrandGetLogs extends RPCCommandBase
   {
      
      private static const MAX_LOGS_PER_REQUEST:int = 40;
       
      
      private var _resultLogs:Vector.<GrandBattleResult>;
      
      public const signal_resultLogs:Signal = new Signal(Vector.<GrandBattleResult>);
      
      public function CommandGrandGetLogs()
      {
         _resultLogs = new Vector.<GrandBattleResult>();
         super();
         rpcRequest = new RpcRequest("battleGetByType");
         rpcRequest.writeParam("type","grand");
         rpcRequest.writeParam("limit",40);
         rpcRequest.writeParam("offset",0);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc12_:* = null;
         var _loc3_:int = 0;
         var _loc6_:* = undefined;
         var _loc11_:* = null;
         var _loc2_:int = 0;
         var _loc7_:Object = {};
         var _loc4_:Object = result.body.users;
         var _loc16_:int = 0;
         var _loc15_:* = _loc4_;
         for each(var _loc14_ in _loc4_)
         {
            _loc12_ = new UserInfo();
            _loc12_.parse(_loc14_);
            _loc7_[_loc12_.id] = _loc12_;
         }
         var _loc13_:int = -1;
         var _loc8_:* = null;
         var _loc9_:Array = result.body.replays;
         var _loc5_:Array = null;
         var _loc10_:int = _loc9_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc10_)
         {
            _loc6_ = _loc9_[_loc3_];
            _loc11_ = _loc6_.userId + _loc6_.typeId;
            if(_loc13_ != _loc6_.startTime || _loc11_ != _loc8_)
            {
               _loc8_ = _loc11_;
               if(_loc5_)
               {
                  parseReplayPack(param1,_loc5_,_loc7_);
               }
               _loc5_ = [];
               _loc13_ = _loc6_.startTime;
            }
            _loc2_ = _loc6_.result.battleOrder;
            _loc5_[_loc2_] = _loc6_;
            _loc3_++;
         }
         if(_loc5_ && _loc5_.length > 0)
         {
            parseReplayPack(param1,_loc5_,_loc7_);
         }
         tryApplyPlaceFix(_resultLogs);
         signal_resultLogs.dispatch(_resultLogs);
         super.clientExecute(param1);
      }
      
      protected function parseReplayPack(param1:Player, param2:Array, param3:Object) : void
      {
         var _loc4_:* = null;
         var _loc10_:Object = param2[param2.length - 1];
         var _loc5_:UserInfo = param3[_loc10_.userId];
         var _loc11_:UserInfo = param3[_loc10_.typeId];
         var _loc6_:Boolean = false;
         var _loc13_:int = 0;
         var _loc12_:* = param2;
         for(var _loc7_ in param2)
         {
            if(param2[_loc7_].result)
            {
               _loc6_ = true;
            }
         }
         var _loc9_:* = param2[0] !== undefined;
         var _loc8_:* = param2[1] !== undefined;
         if(_loc6_ && _loc9_ && _loc8_)
         {
            _loc4_ = new GrandBattleResult(param1,_loc5_,_loc11_,param2);
            _resultLogs.push(_loc4_);
         }
      }
      
      protected function tryApplyPlaceFix(param1:Vector.<GrandBattleResult>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
