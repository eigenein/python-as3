package game.command.rpc.login
{
   import engine.context.GameContext;
   import game.command.CommandManager;
   
   public class LoginCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function LoginCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function commandMobileInit() : CommandMobileClientInit
      {
         var _loc1_:CommandMobileClientInit = new CommandMobileClientInit();
         _loc1_.execute(commandManager);
         return _loc1_;
      }
      
      public function commandSocialInit(param1:GameContext) : CommandSocialClientInit
      {
         var _loc2_:CommandSocialClientInit = new CommandSocialClientInit(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
