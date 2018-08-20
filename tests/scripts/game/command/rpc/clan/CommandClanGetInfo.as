package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.model.user.Player;
   
   public class CommandClanGetInfo extends RPCCommandBase
   {
       
      
      private var clanId:int;
      
      private var _clanValueObject:ClanValueObject;
      
      public function CommandClanGetInfo(param1:int = -1)
      {
         super();
         this.clanId = param1;
         rpcRequest = new RpcRequest("clanGetInfo");
         if(param1 != -1)
         {
            rpcRequest.writeParam("clanId",param1);
         }
      }
      
      public function get clanValueObject() : ClanValueObject
      {
         return _clanValueObject;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:* = null;
         if(clanId != -1 && result.body)
         {
            _loc2_ = new ClanPublicInfoValueObject(result.body);
            _clanValueObject = new ClanValueObject(_loc2_,param1);
         }
         super.clientExecute(param1);
      }
   }
}
