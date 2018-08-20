package game.command.rpc.friends
{
   import game.command.CommandManager;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class FriendCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function FriendCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function sendGifts(param1:Vector.<PlayerFriendEntry>, param2:Vector.<String>) : CommandSendDailyGift
      {
         var _loc3_:CommandSendDailyGift = new CommandSendDailyGift(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function socialQuestUpdate(param1:Boolean, param2:Boolean) : CommandSocialQuestUpdate
      {
         var _loc3_:CommandSocialQuestUpdate = new CommandSocialQuestUpdate(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function setInvitedBy(param1:PlayerFriendEntry) : void
      {
         var _loc2_:CommandFriendSetInvitedBy = new CommandFriendSetInvitedBy(!!param1?param1.platformUser:null);
         commandManager.executeRPCCommand(_loc2_);
      }
   }
}
