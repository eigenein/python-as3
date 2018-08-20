package game.command.rpc.ny
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.model.user.Player;
   
   public class CommandNYTreeDecorate extends CostCommand
   {
       
      
      private var delayTreeUpdate:Boolean;
      
      private var canApplyTreeUpdate:Boolean = false;
      
      public function CommandNYTreeDecorate(param1:NY2018TreeDecorateAction, param2:int, param3:Boolean = false)
      {
         super();
         rpcRequest = new RpcRequest("newYearDecorateTree");
         rpcRequest.writeParam("optionId",param1.id);
         rpcRequest.writeParam("amount",param2);
         this.delayTreeUpdate = param3;
         var _loc4_:CostData = new CostData();
         _loc4_.add(param1.cost);
         _loc4_.multiply(param2);
         _cost = _loc4_;
      }
      
      public function applyTreeUpdate(param1:Player) : void
      {
         if(result && result.body)
         {
            param1.ny.treeLevel = result.body.treeLevel;
            param1.ny.treeExpPercent = result.body.treeExpPercent;
         }
         else
         {
            canApplyTreeUpdate = true;
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _reward = new RewardData(result.body.reward);
         if(delayTreeUpdate == false || canApplyTreeUpdate)
         {
            applyTreeUpdate(param1);
         }
         super.clientExecute(param1);
      }
   }
}
