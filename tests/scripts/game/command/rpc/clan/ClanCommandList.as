package game.command.rpc.clan
{
   import game.command.CommandManager;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.cost.CostData;
   import game.mediator.gui.popup.clan.ClanRole;
   
   public class ClanCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function ClanCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function clanGetInfo(param1:int = -1) : CommandClanGetInfo
      {
         var _loc2_:CommandClanGetInfo = new CommandClanGetInfo(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanGetRecommended(param1:int) : CommandClanGetRecommended
      {
         var _loc2_:CommandClanGetRecommended = new CommandClanGetRecommended(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanFind() : CommandClanFind
      {
         var _loc1_:CommandClanFind = new CommandClanFind();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanFindByTitle(param1:String) : CommandClanFindByTitle
      {
         var _loc2_:CommandClanFindByTitle = new CommandClanFindByTitle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanIsTitleUnique(param1:String) : void
      {
         var _loc2_:CommandClanIsTitleUnique = new CommandClanIsTitleUnique(param1);
         actionManager.executeRPCCommand(_loc2_);
      }
      
      public function clanCreate(param1:String, param2:String, param3:int, param4:ClanIconValueObject) : CommandClanCreate
      {
         var _loc5_:CommandClanCreate = new CommandClanCreate(param1,param2,param3,param4);
         actionManager.executeRPCCommand(_loc5_);
         return _loc5_;
      }
      
      public function clanUpdate_icon(param1:ClanIconValueObject) : CommandClanUpdateIcon
      {
         var _loc2_:CommandClanUpdateIcon = new CommandClanUpdateIcon(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanUpdate(param1:String, param2:String, param3:int = 0, param4:int = 0) : CommandClanUpdate
      {
         var _loc5_:CommandClanUpdate = new CommandClanUpdate(param1,param2,param3,param4);
         actionManager.executeRPCCommand(_loc5_);
         return _loc5_;
      }
      
      public function clanUpdateTitle(param1:String) : CommandClanUpdateTitle
      {
         var _loc2_:CommandClanUpdateTitle = new CommandClanUpdateTitle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanUpdateRoleNames(param1:String, param2:String, param3:String, param4:String) : CommandClanUpdateRoleNames
      {
         var _loc5_:CommandClanUpdateRoleNames = new CommandClanUpdateRoleNames(param1,param2,param3,param4);
         actionManager.executeRPCCommand(_loc5_);
         return _loc5_;
      }
      
      public function clanLevelUp() : void
      {
      }
      
      public function clanDisband() : CommandClanDisband
      {
         var _loc1_:CommandClanDisband = new CommandClanDisband();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanJoin(param1:int) : CommandClanJoin
      {
         var _loc2_:CommandClanJoin = new CommandClanJoin(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanGetStat() : void
      {
      }
      
      public function clanDismissMember(param1:String = null) : CommandClanDismissMember
      {
         var _loc2_:CommandClanDismissMember = new CommandClanDismissMember(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanAddToBlackList(param1:Array) : CommandClanMemberAddToBlackList
      {
         var _loc2_:CommandClanMemberAddToBlackList = new CommandClanMemberAddToBlackList(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanRemoveFromBlackList(param1:Array) : CommandClanMemberRemoveFromBlackList
      {
         var _loc2_:CommandClanMemberRemoveFromBlackList = new CommandClanMemberRemoveFromBlackList(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanChangeRole(param1:String, param2:ClanRole) : CommandClanChangeRole
      {
         var _loc3_:CommandClanChangeRole = new CommandClanChangeRole(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function clanSkipEnterCooldown() : CommandClanSkipEnterCooldown
      {
         var _loc1_:CommandClanSkipEnterCooldown = new CommandClanSkipEnterCooldown();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanItemsForActivity(param1:CostData) : CommandClanItemsForActivity
      {
         var _loc2_:CommandClanItemsForActivity = new CommandClanItemsForActivity(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function clanGetActivityStat() : CommandClanGetActivityStat
      {
         var _loc1_:CommandClanGetActivityStat = new CommandClanGetActivityStat();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanGetLog() : CommandClanGetLog
      {
         var _loc1_:CommandClanGetLog = new CommandClanGetLog();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanGetWeeklyStat() : CommandClanGetWeeklyStat
      {
         var _loc1_:CommandClanGetWeeklyStat = new CommandClanGetWeeklyStat();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function clanSendGifts(param1:Vector.<String>) : CommandClanSendGifts
      {
         var _loc2_:CommandClanSendGifts = new CommandClanSendGifts(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
