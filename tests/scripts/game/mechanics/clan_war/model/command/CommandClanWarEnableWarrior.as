package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   
   public class CommandClanWarEnableWarrior extends RPCCommandBase
   {
       
      
      private var warriorIds:Array;
      
      private var nonWarriorIds:Array;
      
      public function CommandClanWarEnableWarrior(param1:Array, param2:Array)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super();
         this.warriorIds = param1;
         this.nonWarriorIds = param2;
         rpcRequest = new RpcRequest("clanWarEnableWarrior");
         var _loc5_:Object = {};
         if(param1)
         {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_[param1[_loc4_]] = true;
               _loc4_++;
            }
         }
         if(param2)
         {
            _loc3_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_[param2[_loc4_]] = false;
               _loc4_++;
            }
         }
         rpcRequest.writeParam("users",_loc5_);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
         GameModel.instance.player.clan.clanWarData.setWarriorsStatus(warriorIds,nonWarriorIds);
      }
   }
}
