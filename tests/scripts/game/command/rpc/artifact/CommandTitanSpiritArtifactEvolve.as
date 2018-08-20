package game.command.rpc.artifact
{
   import game.battle.BattleDataFactory;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class CommandTitanSpiritArtifactEvolve extends CostCommand
   {
       
      
      private var artifact:PlayerTitanArtifact;
      
      public function CommandTitanSpiritArtifactEvolve(param1:PlayerTitanArtifact)
      {
         super();
         isImmediate = true;
         this.artifact = param1;
         rpcRequest = new RpcRequest("titanSpiritEvolve");
         rpcRequest.writeParam("id",param1.desc.id);
         _cost = new CostData();
         var _loc2_:ArtifactEvolutionStar = param1.nextEvolutionStar;
         if(_loc2_)
         {
            _cost.fragmentCollection.addItem(param1.desc,_loc2_.costFragmentsAmount);
            _cost.add(_loc2_.costBase);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<PlayerTitanEntry> = param1.titans.getList();
         var _loc2_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].artifacts.spirit == artifact)
            {
               _loc2_ = Number(_loc2_ + BattleDataFactory.getTitanStatsPower(_loc3_[_loc4_].getStatsNext(false,false),_loc3_[_loc4_].artifacts.elementStats));
            }
            _loc4_++;
         }
         param1.titans.titanSpiritArtifactEvolveStar(artifact);
         var _loc5_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].artifacts.spirit == artifact)
            {
               _loc5_ = Number(_loc5_ + BattleDataFactory.getTitanStatsPower(_loc3_[_loc4_].getStatsNext(false,false),_loc3_[_loc4_].artifacts.elementStats));
            }
            _loc4_++;
         }
         _reward = new RewardData();
         _reward.addInventoryItem(DataStorage.consumable.getTitanSparkDesc(),_loc5_ - _loc2_);
         super.clientExecute(param1);
      }
   }
}
