package game.command.tower
{
   import game.battle.controller.MultiBattleResult;
   import game.command.CommandManager;
   import game.data.cost.CostData;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.mediator.gui.popup.tower.TowerChestValueObject;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.tower.PlayerTowerBuffEntry;
   
   public class TowerCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function TowerCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function towerGetInfo() : CommandTowerGetInfo
      {
         var _loc1_:CommandTowerGetInfo = new CommandTowerGetInfo();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function towerNextFloor() : CommandTowerNextFloor
      {
         var _loc1_:CommandTowerNextFloor = new CommandTowerNextFloor();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function towerChooseDifficulty(param1:TowerBattleDifficulty) : CommandTowerChooseDifficulty
      {
         var _loc2_:CommandTowerChooseDifficulty = new CommandTowerChooseDifficulty(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function towerStartBattle(param1:Vector.<PlayerHeroEntry>) : CommandTowerStartBattle
      {
         var _loc2_:CommandTowerStartBattle = new CommandTowerStartBattle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function towerStartBattleWithDifficulty(param1:Vector.<PlayerHeroEntry>, param2:TowerBattleDifficulty) : CommandTowerStartBattle
      {
         var _loc3_:CommandTowerStartBattle = new CommandTowerStartBattle(param1);
         _loc3_.setupDifficulty(param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function towerEndBattle(param1:MultiBattleResult) : CommandTowerEndBattle
      {
         var _loc2_:CommandTowerEndBattle = new CommandTowerEndBattle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function towerOpenChest(param1:TowerChestValueObject) : CommandTowerOpenChest
      {
         var _loc2_:CommandTowerOpenChest = new CommandTowerOpenChest(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function towerBuyBuff(param1:PlayerTowerBuffEntry, param2:int = 0) : CommandTowerBuyBuff
      {
         var _loc3_:CommandTowerBuyBuff = new CommandTowerBuyBuff(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function towerSkipFloor() : CommandTowerSkipFloor
      {
         var _loc1_:CommandTowerSkipFloor = new CommandTowerSkipFloor();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function towerReset() : CommandTowerReset
      {
         var _loc1_:CommandTowerReset = new CommandTowerReset();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function towerBuySkipFloor(param1:CostData) : CommandTowerBuySkipFloor
      {
         var _loc2_:CommandTowerBuySkipFloor = new CommandTowerBuySkipFloor(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function towerNextChest() : CommandTowerNextChest
      {
         var _loc1_:CommandTowerNextChest = new CommandTowerNextChest();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function towerFullSkip(param1:CostData) : CommandTowerFullSkip
      {
         var _loc2_:CommandTowerFullSkip = new CommandTowerFullSkip(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
