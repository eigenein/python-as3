package game.mechanics.expedition.model
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.model.user.Player;
   
   public class CommandExpeditionFarm extends CostCommand
   {
       
      
      private var expeditionId:int;
      
      private var _expedition:ExpeditionValueObject;
      
      public function CommandExpeditionFarm(param1:ExpeditionValueObject)
      {
         super();
         this._expedition = param1;
         this.expeditionId = param1.entry.id;
         rpcRequest = new RpcRequest("expeditionFarm");
         rpcRequest.writeParam("expeditionId",param1.entry.id);
      }
      
      public function get expedition() : ExpeditionValueObject
      {
         return _expedition;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _reward = new RewardData(result.body.reward);
         var _loc2_:Object = result.body.newExpedition;
         super.clientExecute(param1);
         param1.expedition.handleFarm(expeditionId,_loc2_);
      }
   }
}
