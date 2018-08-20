package game.command.rpc.clan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   
   public class CommandClanUpdateRoleNames extends CostCommand
   {
       
      
      private var _roleNames:Object;
      
      public function CommandClanUpdateRoleNames(param1:String, param2:String, param3:String, param4:String)
      {
         super();
         rpcRequest = new RpcRequest("clanUpdateRoleNames");
         _cost = DataStorage.rule.clanRule.changeRoleNamesCost;
         _roleNames = {};
         if(param1)
         {
            _roleNames.owner = param1;
         }
         if(param2)
         {
            _roleNames.officer = param2;
         }
         if(param3)
         {
            _roleNames.member = param3;
         }
         if(param4)
         {
            _roleNames.warlord = param4;
         }
         rpcRequest.writeParam("roleNames",_roleNames);
      }
   }
}
