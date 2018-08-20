package game.command.rpc.mail
{
   import game.command.CommandManager;
   import game.model.user.mail.PlayerMailEntry;
   
   public class MailCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function MailCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function mailFarm(param1:PlayerMailEntry) : CommandMailFarm
      {
         var _loc2_:CommandMailFarm = new CommandMailFarm(new <PlayerMailEntry>[param1]);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function mailFarmMulti(param1:Vector.<PlayerMailEntry>) : CommandMailFarm
      {
         var _loc2_:CommandMailFarm = new CommandMailFarm(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function mailGet() : CommandMailGet
      {
         var _loc1_:CommandMailGet = new CommandMailGet();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
