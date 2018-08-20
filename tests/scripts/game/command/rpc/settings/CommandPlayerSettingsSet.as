package game.command.rpc.settings
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.settings.PlayerSettingsParameter;
   
   public class CommandPlayerSettingsSet extends RPCCommandBase
   {
       
      
      private var parameter:PlayerSettingsParameter;
      
      private var newValue;
      
      public function CommandPlayerSettingsSet(param1:PlayerSettingsParameter)
      {
         super();
         rpcRequest = new RpcRequest("settingsSet");
         newValue = param1.getValue();
         rpcRequest.writeParam(param1.getName(),newValue);
         this.parameter = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.settings.syncronizeParameter(parameter,newValue);
         super.clientExecute(param1);
      }
   }
}
