package game.command.rpc.titan
{
   import game.command.CommandManager;
   import game.command.rpc.artifact.CommandTitanArtifactChestOpen;
   import game.command.rpc.artifact.CommandTitanArtifactEvolve;
   import game.command.rpc.artifact.CommandTitanArtifactLevelUp;
   import game.command.rpc.artifact.CommandTitanArtifactLevelUpStarmoney;
   import game.command.rpc.artifact.CommandTitanSpiritArtifactEvolve;
   import game.command.rpc.artifact.CommandTitanSpiritArtifactLevelUp;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryItem;
   
   public class TitanCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function TitanCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function titanUseSummonCircle(param1:Boolean, param2:uint) : CommandTitanUseSummoningCircle
      {
         var _loc3_:CommandTitanUseSummoningCircle = new CommandTitanUseSummoningCircle(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanCraft(param1:TitanDescription) : CommandTitanCraft
      {
         var _loc2_:CommandTitanCraft = new CommandTitanCraft(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanEvolve(param1:PlayerTitanEntry) : CommandTitanEvolve
      {
         var _loc2_:CommandTitanEvolve = new CommandTitanEvolve(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanConsumableUseXP(param1:PlayerTitanEntry, param2:ConsumableDescription, param3:int) : CommandTitanConsumableUseXP
      {
         var _loc4_:CommandTitanConsumableUseXP = new CommandTitanConsumableUseXP(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function titanLevelUp(param1:PlayerTitanEntry, param2:InventoryItem) : CommandTitanLevelUp
      {
         var _loc3_:CommandTitanLevelUp = new CommandTitanLevelUp(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanArtifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : CommandTitanArtifactEvolve
      {
         var _loc3_:CommandTitanArtifactEvolve = new CommandTitanArtifactEvolve(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : CommandTitanArtifactLevelUp
      {
         var _loc3_:CommandTitanArtifactLevelUp = new CommandTitanArtifactLevelUp(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanArtifactLevelUpStarmoney(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : CommandTitanArtifactLevelUpStarmoney
      {
         var _loc3_:CommandTitanArtifactLevelUpStarmoney = new CommandTitanArtifactLevelUpStarmoney(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanSpiritArtifactEvolve(param1:PlayerTitanArtifact) : CommandTitanSpiritArtifactEvolve
      {
         var _loc2_:CommandTitanSpiritArtifactEvolve = new CommandTitanSpiritArtifactEvolve(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanSpiritArtifactLevelUp(param1:PlayerTitanArtifact, param2:Boolean) : CommandTitanSpiritArtifactLevelUp
      {
         var _loc3_:CommandTitanSpiritArtifactLevelUp = new CommandTitanSpiritArtifactLevelUp(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function artifactChestOpen(param1:Player, param2:uint, param3:Boolean) : CommandTitanArtifactChestOpen
      {
         var _loc4_:CommandTitanArtifactChestOpen = new CommandTitanArtifactChestOpen(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
   }
}
