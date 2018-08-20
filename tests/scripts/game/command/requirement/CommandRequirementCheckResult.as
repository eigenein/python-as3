package game.command.requirement
{
   import game.data.cost.CostData;
   
   public class CommandRequirementCheckResult
   {
       
      
      private var requirement:CommandRequirement;
      
      private var _insufficientCost:CostData;
      
      private var _insufficientVipLevel:int;
      
      public function CommandRequirementCheckResult(param1:CommandRequirement)
      {
         super();
         this.requirement = param1;
      }
      
      public function get insufficientCost() : CostData
      {
         return _insufficientCost;
      }
      
      public function set insufficientCost(param1:CostData) : void
      {
         if(_insufficientCost == param1)
         {
            return;
         }
         _insufficientCost = param1;
      }
      
      public function get insufficientVipLevel() : int
      {
         return _insufficientVipLevel;
      }
      
      public function set insufficientVipLevel(param1:int) : void
      {
         if(_insufficientVipLevel == param1)
         {
            return;
         }
         _insufficientVipLevel = param1;
      }
      
      public function get debugMessage() : String
      {
         if(requirement.invalid)
         {
            return "requirement is not possible";
         }
         if(_insufficientCost)
         {
            return "insufficient funds " + _insufficientCost.toString();
         }
         if(_insufficientVipLevel)
         {
            return "need vip lvl " + _insufficientVipLevel;
         }
         return "ok";
      }
      
      public function get valid() : Boolean
      {
         return !requirement.invalid && !_insufficientCost && !_insufficientVipLevel;
      }
   }
}
