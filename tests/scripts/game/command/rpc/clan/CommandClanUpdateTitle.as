package game.command.rpc.clan
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   
   public class CommandClanUpdateTitle extends CostCommand implements IClanTitleUpdateCommand
   {
       
      
      private var title:String;
      
      private var _error_titleNotUnique:Boolean;
      
      public function CommandClanUpdateTitle(param1:String)
      {
         super();
         this.title = param1;
         rpcRequest = new RpcRequest("clanUpdateTitle");
         rpcRequest.writeParam("title",param1);
         _cost = DataStorage.rule.clanRule.changeTitleCost;
      }
      
      public function get error_titleNotUnique() : Boolean
      {
         return _error_titleNotUnique;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(!_error_titleNotUnique)
         {
            param1.clan.clan.action_changeTitle(title);
         }
         else
         {
            _cost = null;
         }
         super.clientExecute(param1);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         if(param1.response.error.name == "Already")
         {
            _error_titleNotUnique = true;
            onRpc_infoHandler({});
         }
         else
         {
            super.onRpc_errorHandler(param1);
         }
      }
   }
}
