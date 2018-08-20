package game.command.rpc.grand
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.arena.PlayerArenaEnemy;
   
   public class CommandGrandCheckTargetRange extends RPCCommandBase
   {
      
      public static const MAX_ENEMIES_COUNT:int = 3;
       
      
      public function CommandGrandCheckTargetRange(param1:Vector.<PlayerArenaEnemy>)
      {
         var _loc4_:int = 0;
         super();
         rpcRequest = new RpcRequest("grandCheckTargetRange");
         var _loc3_:Array = [];
         var _loc2_:int = Math.min(param1.length,3);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(param1[_loc4_].id);
            _loc4_++;
         }
         rpcRequest.writeParam("ids",_loc3_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.grand.updateEnimiesAvailability(result.body);
      }
   }
}
