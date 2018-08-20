package game.command.rpc.refillable
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandStaminaBuy extends CostCommand
   {
       
      
      private var _staminaAmount:int;
      
      public function CommandStaminaBuy()
      {
         super();
         rpcRequest = new RpcRequest("refillableBuyStamina");
      }
      
      public function get staminaAmount() : int
      {
         return _staminaAmount;
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:Boolean = false;
         var _loc3_:PlayerRefillableEntry = param1.refillable.stamina;
         if(_loc3_.refillCount < _loc3_.maxRefillCount)
         {
            _loc2_ = true;
         }
         _cost = _loc3_.refillCost;
         var _loc4_:CommandRequirement = super.prerequisiteCheck(param1);
         if(!_loc2_)
         {
            _loc4_.vipLevel = _loc3_.getVipLevelToRefill();
         }
         return _loc4_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:PlayerRefillableEntry = param1.refillable.stamina;
         _staminaAmount = _loc2_.refillAmount;
         param1.refillable.refill(_loc2_);
         super.clientExecute(param1);
      }
   }
}
