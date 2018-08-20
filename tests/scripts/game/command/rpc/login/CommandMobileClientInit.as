package game.command.rpc.login
{
   import flash.net.SharedObject;
   import game.command.CommandManager;
   import game.command.rpc.CommandResult;
   import game.command.rpc.CommandResultError;
   import idv.cjcat.signals.Signal;
   
   public class CommandMobileClientInit
   {
       
      
      private var commandManager:CommandManager;
      
      public const onComplete:Signal = new Signal(CommandMobileClientInit);
      
      public const onError:Signal = new Signal(CommandMobileClientInit);
      
      private var _result:CommandResult;
      
      private var _error:CommandResultError;
      
      private var _so:SharedObject;
      
      public function CommandMobileClientInit()
      {
         super();
         _so = SharedObject.getLocal("CommandMobileLogin","/");
      }
      
      public function get result() : CommandResult
      {
         return _result;
      }
      
      public function get error() : CommandResultError
      {
         return _error;
      }
      
      public function get so() : SharedObject
      {
         return _so;
      }
      
      private function executeLogin() : void
      {
         var _loc1_:CommandMobileLogin = new CommandMobileLogin();
         _loc1_.signal_complete.add(onMobileLoginCommandSuccess);
         _loc1_.signal_error.add(onMobileLoginCommandError);
         commandManager.executeRPCCommand(_loc1_);
      }
      
      private function executeRegistration() : void
      {
         var _loc1_:CommandMobileRegistration = new CommandMobileRegistration();
         _loc1_.signal_complete.add(onMobileRegisterCommandSuccess);
         _loc1_.signal_error.add(onMobileRegisterCommandError);
         commandManager.executeRPCCommand(_loc1_);
      }
      
      public function execute(param1:CommandManager) : void
      {
         this.commandManager = param1;
         if(so.data.userId && so.data.authKey)
         {
            param1.initializer.auth_key = so.data.authKey;
            param1.initializer.user_id = so.data.userId;
            executeLogin();
         }
         else
         {
            executeRegistration();
         }
      }
      
      private function onMobileRegisterCommandSuccess(param1:CommandMobileRegistration) : void
      {
         so.data.userId = param1.result.body.userId;
         so.data.authKey = param1.result.body.authKey;
         so.flush();
         commandManager.initializer.auth_key = so.data.authKey;
         commandManager.initializer.user_id = so.data.userId;
         executeLogin();
      }
      
      private function onMobileLoginCommandSuccess(param1:CommandMobileLogin) : void
      {
         _result = param1.result;
         onComplete.dispatch(this);
      }
      
      private function onMobileRegisterCommandError(param1:CommandMobileRegistration) : void
      {
         _error = new CommandResultError();
         _error = param1.error;
         onError.dispatch(this);
      }
      
      private function onMobileLoginCommandError(param1:CommandMobileLogin) : void
      {
         _error = new CommandResultError();
         _error = param1.error;
         onError.dispatch(this);
      }
   }
}
