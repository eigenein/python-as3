package game.command.rpc.clan
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   
   public class CommandClanCreate extends CostCommand implements IClanTitleUpdateCommand
   {
       
      
      private var _error_titleNotUnique:Boolean;
      
      public function CommandClanCreate(param1:String, param2:String, param3:int, param4:ClanIconValueObject)
      {
         super();
         rpcRequest = new RpcRequest("clanCreate");
         rpcRequest.writeParam("title",param1);
         rpcRequest.writeParam("description",param2);
         rpcRequest.writeParam("news",param2);
         rpcRequest.writeParam("icon",param4.serialize());
         rpcRequest.writeParam("minLevel",param3);
         _cost = DataStorage.level.getClanLevel(1).levelUpCost;
      }
      
      public function get error_titleNotUnique() : Boolean
      {
         return _error_titleNotUnique;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(_error_titleNotUnique)
         {
            _cost = null;
         }
         else
         {
            param1.clan.action_create(this);
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
