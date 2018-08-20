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
   
   public class CommandTitanSpiritArtifactLevelUp extends CostCommand
   {
       
      
      private var artifact:PlayerTitanArtifact;
      
      public function CommandTitanSpiritArtifactLevelUp(param1:PlayerTitanArtifact, param2:Boolean)
      {
         super();
         isImmediate = false;
         this.artifact = param1;
         rpcRequest = new RpcRequest("titanSpiritLevelUp");
         rpcRequest.writeParam("id",param1.desc.id);
         rpcRequest.writeParam("paid",param2);
         _cost = new CostData();
         var _loc3_:ArtifactLevel = param1.nextLevelData;
         if(_loc3_)
         {
            if(param2)
            {
               _cost.add(_loc3_.costStarmoney);
            }
            else
            {
               _cost.add(_loc3_.cost);
            }
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
         param1.titans.titanSpiritArtifactLevelUp(artifact);
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
