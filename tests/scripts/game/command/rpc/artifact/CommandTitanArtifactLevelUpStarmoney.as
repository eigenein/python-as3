package game.command.rpc.artifact
{
   import game.battle.BattleDataFactory;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactLevel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class CommandTitanArtifactLevelUpStarmoney extends CostCommand
   {
       
      
      private var titan:PlayerTitanEntry;
      
      private var artifact:PlayerTitanArtifact;
      
      public function CommandTitanArtifactLevelUpStarmoney(param1:PlayerTitanEntry, param2:PlayerTitanArtifact)
      {
         super();
         isImmediate = false;
         this.titan = param1;
         this.artifact = param2;
         rpcRequest = new RpcRequest("titanArtifactLevelUpStarmoney");
         rpcRequest.writeParam("titanId",param1.titan.id);
         rpcRequest.writeParam("slotId",param2.slotId);
         _cost = new CostData();
         var _loc3_:ArtifactLevel = param2.nextLevelData;
         if(_loc3_)
         {
            _cost.add(_loc3_.costStarmoney);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(_cost)
         {
            param1.spendCost(_cost);
            _cost = null;
         }
         var _loc2_:Number = BattleDataFactory.getTitanStatsPower(titan.getStatsNext(false,false),titan.artifacts.elementStats);
         param1.titans.titanArtifactLevelUp(titan,artifact);
         var _loc3_:Number = BattleDataFactory.getTitanStatsPower(titan.getStatsNext(false,false),titan.artifacts.elementStats);
         _reward = new RewardData();
         _reward.addInventoryItem(DataStorage.consumable.getTitanSparkDesc(),_loc3_ - _loc2_);
         super.clientExecute(param1);
      }
   }
}
