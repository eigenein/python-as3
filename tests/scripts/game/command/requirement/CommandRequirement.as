package game.command.requirement
{
   import game.data.cost.CostData;
   
   public class CommandRequirement
   {
       
      
      private var _cost:CostData;
      
      private var _invalid:Boolean;
      
      private var _vipLevel:int;
      
      public function CommandRequirement()
      {
         super();
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function set cost(param1:CostData) : void
      {
         if(_cost == param1)
         {
            return;
         }
         _cost = param1;
      }
      
      public function get invalid() : Boolean
      {
         return _invalid;
      }
      
      public function set invalid(param1:Boolean) : void
      {
         if(_invalid == param1)
         {
            return;
         }
         _invalid = param1;
      }
      
      public function get vipLevel() : int
      {
         return _vipLevel;
      }
      
      public function set vipLevel(param1:int) : void
      {
         if(_vipLevel == param1)
         {
            return;
         }
         _vipLevel = param1;
      }
   }
}
