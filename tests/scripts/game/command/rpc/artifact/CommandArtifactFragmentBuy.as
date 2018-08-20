package game.command.rpc.artifact
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.artifact.ArtifactDescription;
   import game.model.user.Player;
   
   public class CommandArtifactFragmentBuy extends CostCommand
   {
       
      
      public var artifact:ArtifactDescription;
      
      public var amount:uint;
      
      public function CommandArtifactFragmentBuy(param1:ArtifactDescription, param2:uint)
      {
         var _loc3_:int = 0;
         super();
         isImmediate = false;
         this.artifact = param1;
         this.amount = param2;
         rpcRequest = new RpcRequest("artifactFragmentBuy");
         rpcRequest.writeParam("artifactId",param1.id);
         rpcRequest.writeParam("amount",param2);
         _cost = new CostData();
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _cost.add(param1.fragmentBuyCost);
            _loc3_++;
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.inventory.getFragmentCollection().addItem(artifact,amount);
         super.clientExecute(param1);
      }
   }
}
