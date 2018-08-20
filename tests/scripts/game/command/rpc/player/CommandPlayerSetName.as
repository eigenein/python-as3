package game.command.rpc.player
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandPlayerSetName extends CostCommand
   {
       
      
      private var newName:String;
      
      public function CommandPlayerSetName(param1:String)
      {
         super();
         rpcRequest = new RpcRequest("setName");
         rpcRequest.writeParam("name",param1);
         this.newName = param1;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:PlayerRefillableEntry = param1.refillable.getById(DataStorage.rule.nicknameUpdate.cooldown);
         if(_loc2_)
         {
            param1.refillable.spend(_loc2_,1);
         }
         param1.changeNickname(newName);
         param1.flags.setFlag(4,true);
         super.clientExecute(param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         if(param1.flags.getFlag(4))
         {
            _cost = new CostData(DataStorage.rule.nicknameUpdate.cost);
         }
         var _loc2_:PlayerRefillableEntry = param1.refillable.getById(DataStorage.rule.nicknameUpdate.cooldown);
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         _loc3_.invalid = _loc2_ != null && _loc2_.value == 0;
         return _loc3_;
      }
   }
}
