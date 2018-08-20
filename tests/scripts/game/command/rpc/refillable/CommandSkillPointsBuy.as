package game.command.rpc.refillable
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandSkillPointsBuy extends CostCommand
   {
       
      
      public function CommandSkillPointsBuy()
      {
         super();
         rpcRequest = new RpcRequest("refillableBuySkillpoints");
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:Boolean = false;
         var _loc3_:PlayerRefillableEntry = param1.refillable.skillpoints;
         if(_loc3_.maxRefillCount == -1 || _loc3_.refillCount < _loc3_.maxRefillCount)
         {
            _loc2_ = true;
         }
         _cost = _loc3_.refillCost;
         var _loc4_:CommandRequirement = super.prerequisiteCheck(param1);
         _loc4_.invalid = !_loc2_;
         return _loc4_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:PlayerRefillableEntry = param1.refillable.skillpoints;
         param1.refillable.refill(_loc2_);
         super.clientExecute(param1);
      }
   }
}
