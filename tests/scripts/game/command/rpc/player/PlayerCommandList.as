package game.command.rpc.player
{
   import game.command.CommandManager;
   import game.command.rpc.billing.CommandBillingsGet;
   import game.command.rpc.billing.CommandSubscriptionFarmGifts;
   import game.command.rpc.billing.CommandSubscriptionOnPurchaseGetInfo;
   import game.command.rpc.player.server.CommandServerChangeUser;
   import game.command.rpc.player.server.CommandServerCreateUser;
   import game.command.rpc.player.server.CommandServerGetAll;
   import game.command.rpc.player.server.CommandServerMigrateUser;
   import game.command.rpc.settings.CommandPlayerSettingsSet;
   import game.model.user.UserInfo;
   import game.model.user.settings.PlayerSettingsParameter;
   
   public class PlayerCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function PlayerCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function userResetDay(param1:int) : CommandUserResetDay
      {
         var _loc2_:CommandUserResetDay = new CommandUserResetDay(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function subscriptionGetInfo() : CommandSubscriptionOnPurchaseGetInfo
      {
         var _loc1_:CommandSubscriptionOnPurchaseGetInfo = new CommandSubscriptionOnPurchaseGetInfo();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function subscriptionFarmGifts(param1:Boolean) : CommandSubscriptionFarmGifts
      {
         var _loc2_:CommandSubscriptionFarmGifts = new CommandSubscriptionFarmGifts(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function specialOfferGetAll() : CommandOfferGetAll
      {
         var _loc1_:CommandOfferGetAll = new CommandOfferGetAll();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function specialOfferFarmReward(param1:int) : CommandOfferFarmReward
      {
         var _loc2_:CommandOfferFarmReward = new CommandOfferFarmReward(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function changeNickname(param1:String) : CommandPlayerSetName
      {
         var _loc2_:CommandPlayerSetName = new CommandPlayerSetName(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function changeAvatar(param1:int) : CommandPlayerSetAvatar
      {
         var _loc2_:CommandPlayerSetAvatar = new CommandPlayerSetAvatar(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function changeSettingsParameter(param1:PlayerSettingsParameter) : CommandPlayerSettingsSet
      {
         var _loc2_:CommandPlayerSettingsSet = new CommandPlayerSettingsSet(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function updateBilllings() : CommandBillingsGet
      {
         var _loc1_:CommandBillingsGet = new CommandBillingsGet(false);
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function updateBilllingsOnTransaction() : CommandBillingsGet
      {
         var _loc1_:CommandBillingsGet = new CommandBillingsGet(true);
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function serverGetAll() : CommandServerGetAll
      {
         var _loc1_:CommandServerGetAll = new CommandServerGetAll();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function serverChangeUser(param1:UserInfo) : CommandServerChangeUser
      {
         var _loc2_:CommandServerChangeUser = new CommandServerChangeUser(param1.id);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function serverCreateUser(param1:int) : CommandServerCreateUser
      {
         var _loc2_:CommandServerCreateUser = new CommandServerCreateUser(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function serverMigrate(param1:int) : CommandServerMigrateUser
      {
         var _loc2_:CommandServerMigrateUser = new CommandServerMigrateUser(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function avatarsGetUnlocked() : CommandPlayerGetAvailableAvatars
      {
         var _loc1_:CommandPlayerGetAvailableAvatars = new CommandPlayerGetAvailableAvatars();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function userGetInfoByIds(param1:Array) : CommandUserGetInfoByIds
      {
         var _loc2_:CommandUserGetInfoByIds = new CommandUserGetInfoByIds(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
