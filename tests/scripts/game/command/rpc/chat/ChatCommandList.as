package game.command.rpc.chat
{
   import game.command.CommandManager;
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class ChatCommandList
   {
      
      public static const CHAT_TYPE_SERVER:String = "server";
      
      public static const CHAT_TYPE_CLAN:String = "clan";
       
      
      private var actionManager:CommandManager;
      
      public function ChatCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function chatGetAll(param1:String) : CommandChatGetAll
      {
         var _loc2_:CommandChatGetAll = new CommandChatGetAll(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function chatSendText(param1:String, param2:String = "server") : void
      {
         var _loc3_:CommandChatSendText = new CommandChatSendText(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         GameModel.instance.player.chat.lastMessageTime = GameTimer.instance.currentServerTime;
      }
      
      public function chatServerSubscribe() : void
      {
         var _loc1_:CommandChatServerSubscribe = new CommandChatServerSubscribe();
         actionManager.executeRPCCommand(_loc1_);
      }
      
      public function chatServerUnSubscribe() : void
      {
         var _loc1_:CommandChatServerUnSubscribe = new CommandChatServerUnSubscribe();
         actionManager.executeRPCCommand(_loc1_);
      }
      
      public function chatBan(param1:String, param2:uint) : void
      {
         var _loc3_:CommandChatBan = new CommandChatBan(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
      }
      
      public function chatSendChallenge(param1:String, param2:Array, param3:String, param4:Boolean = false) : void
      {
         var _loc5_:CommandChatSendChallenge = new CommandChatSendChallenge(param1,param2,param3,param4);
         actionManager.executeRPCCommand(_loc5_);
         GameModel.instance.player.chat.lastMessageTime = GameTimer.instance.currentServerTime;
      }
      
      public function chatAcceptChallenge(param1:int, param2:Array, param3:Boolean, param4:UserInfo, param5:UserInfo) : CommandChatAcceptChallenge
      {
         var _loc6_:CommandChatAcceptChallenge = new CommandChatAcceptChallenge(param1,param2,param3,param4,param5);
         actionManager.executeRPCCommand(_loc6_);
         GameModel.instance.player.chat.lastMessageTime = GameTimer.instance.currentServerTime;
         return _loc6_;
      }
      
      public function chatSendReplay(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:CommandChatSendReplay = new CommandChatSendReplay(param1,param2,param3);
         actionManager.executeRPCCommand(_loc4_);
         GameModel.instance.player.chat.lastMessageTime = GameTimer.instance.currentServerTime;
      }
      
      public function chatBlackListAdd(param1:Player, param2:String) : void
      {
         var _loc3_:CommandChatBlackListAdd = new CommandChatBlackListAdd(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
      }
      
      public function chatBlackListRemove(param1:Player, param2:String) : void
      {
         var _loc3_:CommandChatBlackListRemove = new CommandChatBlackListRemove(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
      }
      
      public function chatBlackListDrop(param1:Player) : void
      {
         var _loc2_:CommandChatBlackListDrop = new CommandChatBlackListDrop(param1);
         actionManager.executeRPCCommand(_loc2_);
      }
      
      public function chatSetSettings(param1:Player) : void
      {
         var _loc2_:CommandChatSetSettings = new CommandChatSetSettings(param1);
         actionManager.executeRPCCommand(_loc2_);
      }
      
      public function chatGetInfo() : void
      {
      }
   }
}
