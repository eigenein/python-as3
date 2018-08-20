package game.command.rpc.titan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.titan.TitanDescription;
   
   public class CommandTitanCraft extends CostCommand
   {
       
      
      private var _titan:TitanDescription;
      
      public function CommandTitanCraft(param1:TitanDescription)
      {
         super();
         this._titan = param1;
         rpcRequest = new RpcRequest("titanCraft");
         rpcRequest.writeParam("titanId",param1.id);
         _cost = param1.summonCost;
         _reward = new RewardData();
         _reward.addTitan(param1);
      }
      
      public function get titan() : TitanDescription
      {
         return _titan;
      }
   }
}
