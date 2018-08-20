package game.command.rpc
{
   import game.command.requirement.CommandRequirement;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class RefillableRefillCommand extends CostCommand
   {
       
      
      public function RefillableRefillCommand()
      {
         super();
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:PlayerRefillableEntry = getPlayerRefillable(param1);
         _cost = _loc2_.refillCost;
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         if(_loc2_.maxRefillCount != -1 && _loc2_.refillCount >= _loc2_.maxRefillCount)
         {
            _loc3_.vipLevel = _loc2_.getVipLevelToRefill();
         }
         return _loc3_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.refillable.refill(getPlayerRefillable(param1));
         super.clientExecute(param1);
      }
      
      protected function getPlayerRefillable(param1:Player) : PlayerRefillableEntry
      {
         trace("Using ob abstract method RefillableRefillCommand.getPlayerRefillable() in",this);
         return null;
      }
   }
}
