package game.command.rpc.titan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class CommandTitanEvolve extends CostCommand
   {
       
      
      private var titan:PlayerTitanEntry;
      
      public function CommandTitanEvolve(param1:PlayerTitanEntry)
      {
         super();
         this.titan = param1;
         rpcRequest = new RpcRequest("titanEvolve");
         rpcRequest.writeParam("titanId",param1.titan.id);
         if(param1.star.next)
         {
            _cost = param1.star.next.star.evolveGoldCost.clone() as CostData;
            _cost.fragmentCollection.addItem(param1.titan,param1.star.next.star.evolveFragmentCost);
            _reward = new RewardData();
            _reward.addInventoryItem(DataStorage.consumable.getTitanSparkDesc(),param1.getPowerNext(false,true) - param1.getPower());
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.titans.titanEvolveStar(titan);
      }
   }
}
