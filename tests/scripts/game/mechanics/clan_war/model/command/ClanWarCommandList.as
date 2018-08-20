package game.mechanics.clan_war.model.command
{
   import game.battle.controller.MultiBattleResult;
   import game.command.CommandManager;
   import game.command.rpc.RPCCommandBase;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.clan_war.model.ClanWarDayValueObject;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   
   public class ClanWarCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function ClanWarCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function clanWarGetInfo() : RPCCommandBase
      {
         return null;
      }
      
      public function clanWarGetStatus() : CommandClanWarGetStatus
      {
         var _loc1_:CommandClanWarGetStatus = new CommandClanWarGetStatus();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanWarGetDefence() : CommandClanWarGetDefence
      {
         var _loc1_:CommandClanWarGetDefence = new CommandClanWarGetDefence();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanWarEnableWarrior(param1:Array, param2:Array) : CommandClanWarEnableWarrior
      {
         var _loc3_:CommandClanWarEnableWarrior = new CommandClanWarEnableWarrior(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanWarSetDefenceTeam(param1:Vector.<UnitDescription>, param2:Boolean) : CommandClanWarSetDefenceTeam
      {
         var _loc3_:CommandClanWarSetDefenceTeam = new CommandClanWarSetDefenceTeam(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanWarFillFortification(param1:ClanWarPlanSlotValueObject, param2:ClanWarDefenderValueObject) : CommandClanWarFillFortification
      {
         var _loc3_:CommandClanWarFillFortification = new CommandClanWarFillFortification(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanWarTakeEmptySlots() : CommandClanWarTakeEmptySlots
      {
         var _loc1_:CommandClanWarTakeEmptySlots = new CommandClanWarTakeEmptySlots();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanWarAttack() : RPCCommandBase
      {
         return null;
      }
      
      public function clanWarEndBattle(param1:MultiBattleResult, param2:Boolean = false) : CommandClanWarEndBattle
      {
         var _loc3_:CommandClanWarEndBattle = new CommandClanWarEndBattle(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanWarTestStart() : CommandClanWarTestStart
      {
         var _loc1_:CommandClanWarTestStart = new CommandClanWarTestStart();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanWarGetAvailableHistory() : CommandClanWarGetAvailableHistory
      {
         var _loc1_:CommandClanWarGetAvailableHistory = new CommandClanWarGetAvailableHistory();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanWarGetDayHistory(param1:ClanWarDayValueObject, param2:ClanWarParticipantValueObject, param3:ClanWarParticipantValueObject) : CommandClanWarGetDayHistory
      {
         var _loc4_:CommandClanWarGetDayHistory = new CommandClanWarGetDayHistory(param1,param2,param3);
         actionManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function clanWarLeagueTop(param1:int, param2:Boolean) : CommandClanWarLeagueTop
      {
         var _loc3_:CommandClanWarLeagueTop = new CommandClanWarLeagueTop(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanWarLeagueInfo() : CommandClanWarLeagueInfo
      {
         var _loc1_:CommandClanWarLeagueInfo = new CommandClanWarLeagueInfo();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
