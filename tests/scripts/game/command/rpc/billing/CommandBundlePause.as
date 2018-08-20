package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   
   public class CommandBundlePause extends RPCCommandBase
   {
       
      
      private var _stashParams:PopupStashEventParams;
      
      public function CommandBundlePause()
      {
         super();
         rpcRequest = new RpcRequest("bundlePause");
      }
      
      public function get stashParams() : PopupStashEventParams
      {
         return _stashParams;
      }
      
      public function set stashParams(param1:PopupStashEventParams) : void
      {
         _stashParams = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
