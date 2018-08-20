package game.command.rpc.clan
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   
   public class CommandClanJoin extends RPCCommandBase
   {
       
      
      private var _isSucceeded:Boolean;
      
      public function CommandClanJoin(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("clanJoin");
         rpcRequest.writeParam("clanId",param1);
      }
      
      public function get isSucceeded() : Boolean
      {
         return _isSucceeded;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(result.body)
         {
            _isSucceeded = true;
            param1.clan.action_join(this);
         }
         else
         {
            _isSucceeded = false;
         }
         super.clientExecute(param1);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         if(param1.response.error.name == "NotPermitted")
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_CLAN_BLACK_LIST_NOTIFICATION"),"");
         }
         else
         {
            super.onRpc_errorHandler(param1);
         }
      }
   }
}
