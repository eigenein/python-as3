package game.command.rpc.arena
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.UserInfo;
   
   public class CommandArenaGetLog extends RPCCommandBase
   {
       
      
      public var resultLog:Vector.<ArenaBattleResultValueObject>;
      
      public function CommandArenaGetLog()
      {
         resultLog = new Vector.<ArenaBattleResultValueObject>();
         super();
         rpcRequest = new RpcRequest("battleGetByType");
         rpcRequest.writeParam("type","arena");
         rpcRequest.writeParam("limit",20);
         rpcRequest.writeParam("offset",0);
      }
      
      override protected function successHandler() : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc8_:Object = {};
         var _loc5_:Object = result.body.users;
         var _loc10_:int = 0;
         var _loc9_:* = _loc5_;
         for each(var _loc7_ in _loc5_)
         {
            _loc3_ = new UserInfo();
            _loc3_.parse(_loc7_);
            _loc8_[_loc3_.id] = _loc3_;
         }
         var _loc1_:Array = result.body.replays;
         var _loc2_:int = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = BattleResultValueObjectFactory.parseArenaLogEntry(_loc1_[_loc4_]);
            _loc6_.attacker = _loc8_[_loc6_.userId];
            _loc6_.defender = _loc8_[_loc6_.typeId];
            resultLog[_loc4_] = _loc6_;
            _loc4_++;
         }
         super.successHandler();
      }
   }
}
