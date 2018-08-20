package game.mechanics.quiz.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.enum.RpcCommandName;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class CommandQuizGetNewQuestion extends CostCommand
   {
       
      
      public function CommandQuizGetNewQuestion(param1:Boolean)
      {
         var _loc2_:* = null;
         super();
         _loc2_ = DataStorage.consumable.getById(59) as InventoryItemDescription;
         _cost = new CostData();
         _cost.addInventoryItem(_loc2_,!!param1?10:1);
         rpcRequest = new RpcRequest(RpcCommandName.QUIZ_GET_NEW_QUESTION);
         rpcRequest.writeParam("x10",param1);
         rpcRequest.writeParam("locale",GameModel.instance.context.locale.id);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.quizData.updateQuestion(result.body);
         super.clientExecute(param1);
      }
   }
}
