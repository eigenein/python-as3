package game.mediator.gui.popup.artifacts
{
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.ArtifactLevel;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanArtifactVO
   {
       
      
      private var player:Player;
      
      public var artifact:PlayerTitanArtifact;
      
      public var titan:PlayerTitanEntry;
      
      private var _signal_inventoryUpdated:Signal;
      
      public function PlayerTitanArtifactVO(param1:Player, param2:PlayerTitanArtifact, param3:PlayerTitanEntry)
      {
         _signal_inventoryUpdated = new Signal();
         super();
         this.player = param1;
         this.artifact = param2;
         this.titan = param3;
         param1.signal_spendCost.add(handler_spendCost);
         param1.signal_takeReward.add(handler_takeReward);
      }
      
      public function get signal_inventoryUpdated() : Signal
      {
         return _signal_inventoryUpdated;
      }
      
      public function get playerCanEvolve() : Boolean
      {
         return artifact.canEvolve(player,titan);
      }
      
      public function checkArtifactUpgradeAvaliable() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(artifact && (!titan || titan && artifact.desc.artifactTypeData.minHeroLevel <= titan.level.level))
         {
            _loc2_ = artifact.nextEvolutionStar;
            if(_loc2_)
            {
               _loc1_ = new CostData();
               _loc1_.fragmentCollection.addItem(artifact.desc,_loc2_.costFragmentsAmount);
               _loc1_.add(_loc2_.costBase);
               if(GameModel.instance.player.canSpend(_loc1_))
               {
                  return true;
               }
            }
            _loc3_ = artifact.nextLevelData;
            if(_loc3_ && artifact.awakened)
            {
               _loc1_ = new CostData();
               _loc1_.add(_loc3_.cost);
               if(GameModel.instance.player.canSpend(_loc1_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function handler_spendCost(param1:CostData) : void
      {
         _signal_inventoryUpdated.dispatch();
      }
      
      private function handler_takeReward(param1:RewardData) : void
      {
         _signal_inventoryUpdated.dispatch();
      }
   }
}
