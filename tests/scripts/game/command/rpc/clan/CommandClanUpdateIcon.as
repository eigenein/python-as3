package game.command.rpc.clan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   
   public class CommandClanUpdateIcon extends CostCommand
   {
       
      
      private var icon:ClanIconValueObject;
      
      public function CommandClanUpdateIcon(param1:ClanIconValueObject)
      {
         super();
         this.icon = param1;
         rpcRequest = new RpcRequest("clanUpdateIcon");
         rpcRequest.writeParam("icon",param1.serialize());
         _cost = DataStorage.rule.clanRule.changeIconCost;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.clan.clan.setIcon(icon);
         super.clientExecute(param1);
      }
   }
}
