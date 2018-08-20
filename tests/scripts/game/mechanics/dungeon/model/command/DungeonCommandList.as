package game.mechanics.dungeon.model.command
{
   import game.battle.controller.MultiBattleResult;
   import game.command.CommandManager;
   import game.model.user.hero.UnitEntry;
   
   public class DungeonCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function DungeonCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function dungeonGetInfo() : CommandDungeonGetInfo
      {
         var _loc1_:CommandDungeonGetInfo = new CommandDungeonGetInfo();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function dungeonStartBattle(param1:Vector.<UnitEntry>, param2:int) : CommandDungeonStartBattle
      {
         var _loc3_:CommandDungeonStartBattle = new CommandDungeonStartBattle(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function dungeonEndBattle(param1:MultiBattleResult) : CommandDungeonEndBattle
      {
         var _loc2_:CommandDungeonEndBattle = new CommandDungeonEndBattle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function dungeonSaveProgress() : CommandDungeonSaveProgress
      {
         var _loc1_:CommandDungeonSaveProgress = new CommandDungeonSaveProgress();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
